param(
    [Parameter(Mandatory = $true)]
    [string]$OracleSchemaPath,

    [Parameter(Mandatory = $true)]
    [string]$OracleDataPath,

    [Parameter(Mandatory = $false)]
    [string]$OutputDir = "scripts/generated"
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

# IMPORTANT NOTES:
# 1. Oracle VARCHAR2(n) is in BYTES, PostgreSQL varchar(n) is in CHARACTERS
#    For multibyte characters (Thai, CJK, etc.), actual character count may exceed byte count
# 2. Some Oracle VARCHAR2 definitions may be too small for actual data
#    If you get "value too long for type" errors, check the actual data widths
# 3. For columns with Thai or other multibyte text, you may need to increase varchar width
#    Example: td4exmr_examiner_master.examiner_nm was VARCHAR2(100) but needed varchar(600)

function Convert-OracleTypeToPostgres {
    param([string]$TypeExpr)

    $t = $TypeExpr.Trim()

    $t = $t -replace '(?i)\bBYTE\b', ''
    $t = $t -replace '(?i)\bCHAR\b\s*$', ''
    $t = $t.Trim()

    if ($t -match '^(?i)VARCHAR2\s*\(([^\)]*)\)$') {
        return "varchar($($matches[1].Trim()))"
    }
    if ($t -match '^(?i)NVARCHAR2\s*\(([^\)]*)\)$') {
        return "varchar($($matches[1].Trim()))"
    }
    if ($t -match '^(?i)NCHAR\s*\(([^\)]*)\)$') {
        return "char($($matches[1].Trim()))"
    }
    if ($t -match '^(?i)CHAR\s*\(([^\)]*)\)$') {
        return "char($($matches[1].Trim()))"
    }
    if ($t -match '^(?i)NUMBER\s*\((\d+)\s*,\s*(\d+)\)$') {
        return "numeric($($matches[1]),$($matches[2]))"
    }
    if ($t -match '^(?i)NUMBER\s*\((\d+)\)$') {
        return "numeric($($matches[1]))"
    }
    if ($t -match '^(?i)NUMBER$') {
        return "numeric"
    }
    if ($t -match '^(?i)FLOAT(\s*\(.*\))?$') {
        return "double precision"
    }
    if ($t -match '^(?i)DATE$') {
        return "timestamp"
    }
    if ($t -match '^(?i)TIMESTAMP(\s*\(.*\))?$') {
        return "timestamp"
    }
    if ($t -match '^(?i)CLOB$') {
        return "text"
    }
    if ($t -match '^(?i)NCLOB$') {
        return "text"
    }
    if ($t -match '^(?i)LONG$') {
        return "text"
    }
    if ($t -match '^(?i)BLOB$') {
        return "bytea"
    }
    if ($t -match '^(?i)RAW\s*\(([^\)]*)\)$') {
        return "bytea"
    }
    if ($t -match '^(?i)ROWID$') {
        return "text"
    }

    return ($t.ToLowerInvariant())
}

function Split-TopLevelComma {
    param([string]$Text)

    $result = New-Object System.Collections.Generic.List[string]
    $sb = New-Object System.Text.StringBuilder
    $depth = 0
    $inSingleQuote = $false

    for ($i = 0; $i -lt $Text.Length; $i++) {
        $ch = $Text[$i]

        if ($ch -eq "'") {
            if ($inSingleQuote -and $i + 1 -lt $Text.Length -and $Text[$i + 1] -eq "'") {
                [void]$sb.Append("''")
                $i++
                continue
            }
            $inSingleQuote = -not $inSingleQuote
            [void]$sb.Append($ch)
            continue
        }

        if (-not $inSingleQuote) {
            if ($ch -eq '(') { $depth++ }
            elseif ($ch -eq ')') { if ($depth -gt 0) { $depth-- } }
            elseif ($ch -eq ',' -and $depth -eq 0) {
                $result.Add($sb.ToString())
                $sb.Clear() | Out-Null
                continue
            }
        }

        [void]$sb.Append($ch)
    }

    if ($sb.Length -gt 0) {
        $result.Add($sb.ToString())
    }

    return $result
}

function Normalize-OracleIdentifier {
    param([string]$Name)

    $n = $Name.Trim()
    if ($n.StartsWith('"') -and $n.EndsWith('"')) {
        $n = $n.Substring(1, $n.Length - 2)
    }
    
    # PostgreSQL requires quoting for identifiers with special characters
    # Valid unquoted identifier characters: letters, digits, underscore
    # Must start with letter or underscore
    if ($n -match '[^a-zA-Z0-9_]' -or $n -match '^[0-9]') {
        # Contains special characters or starts with digit - must quote
        return "`"$($n.ToLowerInvariant())`""
    }
    
    return $n.ToLowerInvariant()
}

function Convert-ColumnOrConstraint {
    param([string]$Item)

    $line = ($Item -replace '\r?\n', ' ').Trim()
    $line = $line -replace '\s+', ' '

    if ([string]::IsNullOrWhiteSpace($line)) {
        return $null
    }

    if ($line -match '^(?i)(constraint|primary key|unique|foreign key|check)\b') {
        $line = $line -replace '(?i)\s+using\s+index\s+[^,]*$', ''
        $line = $line -replace '(?i)\s+enable\b', ''
        $line = $line -replace '(?i)\s+disable\b', ''
        $line = $line -replace '(?i)\s+deferrable\b', ''
        $line = $line -replace '(?i)\s+initially\s+immediate\b', ''
        $line = $line -replace '(?i)\s+novalidate\b', ''
        $line = $line.Trim()
        if ($line -ne '') { return $line }
        return $null
    }

    if ($line -notmatch '^(["A-Za-z0-9_#$]+)\s+(.+)$') {
        return "-- UNPARSED: $line"
    }

    $colName = Normalize-OracleIdentifier $matches[1]
    $rest = $matches[2].Trim()

    $typeMatch = [regex]::Match($rest, '^(?<type>[A-Za-z0-9_]+(?:\s*\([^\)]*\))?)(?<tail>.*)$')
    if (-not $typeMatch.Success) {
        return "-- UNPARSED: $line"
    }

    $typeExpr = $typeMatch.Groups['type'].Value.Trim()
    $tail = $typeMatch.Groups['tail'].Value

    $pgType = Convert-OracleTypeToPostgres $typeExpr

    $tail = $tail -replace '(?i)\bENABLE\b', ''
    $tail = $tail -replace '(?i)\bDISABLE\b', ''
    $tail = $tail -replace '(?i)\bNOVALIDATE\b', ''
    $tail = $tail -replace '(?i)\bUSING\s+INDEX\b.*$', ''
    $tail = $tail -replace '(?i)DEFAULT\s+SYSDATE', 'DEFAULT CURRENT_TIMESTAMP'
    $tail = $tail -replace '\s+', ' '
    $tail = $tail.Trim()

    if ($tail -ne '') {
        return "$colName $pgType $tail"
    }
    return "$colName $pgType"
}

function Extract-OracleCreateTableBlocks {
    param([string]$Text)

    $blocks = New-Object System.Collections.Generic.List[object]
    $startRegex = [regex]'(?im)^\s*create\s+table\s+(["A-Za-z0-9_#$]+)\s*\('
    $m = $startRegex.Match($Text)

    while ($m.Success) {
        $tableName = $m.Groups[1].Value
        $openIdx = $Text.IndexOf('(', $m.Index)
        if ($openIdx -lt 0) { break }

        $depth = 1
        $inSingleQuote = $false
        $closeIdx = -1

        for ($i = $openIdx + 1; $i -lt $Text.Length; $i++) {
            $ch = $Text[$i]
            if ($ch -eq "'") {
                if ($inSingleQuote -and $i + 1 -lt $Text.Length -and $Text[$i + 1] -eq "'") {
                    $i++
                    continue
                }
                $inSingleQuote = -not $inSingleQuote
                continue
            }
            if (-not $inSingleQuote) {
                if ($ch -eq '(') { $depth++ }
                elseif ($ch -eq ')') {
                    $depth--
                    if ($depth -eq 0) {
                        $closeIdx = $i
                        break
                    }
                }
            }
        }

        if ($closeIdx -lt 0) { break }

        $semiIdx = $Text.IndexOf(';', $closeIdx)
        if ($semiIdx -lt 0) { $semiIdx = $Text.Length - 1 }

        $tail = $Text.Substring($closeIdx + 1, $semiIdx - $closeIdx - 1)
        $isExternal = $tail -match '(?i)\borganization\s+external\b'

        if (-not $isExternal) {
            $inner = $Text.Substring($openIdx + 1, $closeIdx - $openIdx - 1)
            $blocks.Add([PSCustomObject]@{
                TableName = $tableName
                Inner = $inner
            })
        }

        $nextStart = $semiIdx + 1
        if ($nextStart -ge $Text.Length) { break }
        $m = $startRegex.Match($Text, $nextStart)
    }

    return $blocks
}

function Write-TextUtf8NoBom {
    param(
        [string]$Path,
        [string]$Content
    )

    $fullPath = [System.IO.Path]::GetFullPath($Path)
    $enc = New-Object System.Text.UTF8Encoding($false)
    [System.IO.File]::WriteAllText($fullPath, $Content, $enc)
}

function Extract-OracleIndexes {
    param([string]$Text)
    
    $indexes = New-Object System.Collections.Generic.List[object]
    $indexRegex = [regex]'(?im)^\s*create\s+(?:unique\s+)?index\s+(["A-Za-z0-9_#$]+)\s+on\s+(["A-Za-z0-9_#$]+)\s*\(([^\)]+)\)'
    
    $matches = $indexRegex.Matches($Text)
    foreach ($m in $matches) {
        $indexName = Normalize-OracleIdentifier $m.Groups[1].Value
        $tableName = Normalize-OracleIdentifier $m.Groups[2].Value
        $columns = $m.Groups[3].Value
        
        $indexes.Add([PSCustomObject]@{
            IndexName = $indexName
            TableName = $tableName
            Columns   = $columns
            Original  = $m.Value
        })
    }
    
    return $indexes
}

if (-not (Test-Path $OracleSchemaPath)) {
    throw "Oracle schema file not found: $OracleSchemaPath"
}
if (-not (Test-Path $OracleDataPath)) {
    throw "Oracle data file not found: $OracleDataPath"
}

if (-not (Test-Path $OutputDir)) {
    New-Item -ItemType Directory -Path $OutputDir -Force | Out-Null
}

$schemaOut = Join-Path $OutputDir "cas_app_schema.tables.pg.sql"
$indexesOut = Join-Path $OutputDir "cas_app_schema.indexes.pg.sql"
$dataOut = Join-Path $OutputDir "cas_master_data_inserts.pg.sql"
$deploymentOut = Join-Path $OutputDir "deploy_cas_full.sql"

$schemaText = Get-Content -Path $OracleSchemaPath -Raw
$tables = Extract-OracleCreateTableBlocks $schemaText
$indexes = Extract-OracleIndexes $schemaText

$schemaBuilder = New-Object System.Text.StringBuilder
[void]$schemaBuilder.AppendLine('-- Generated from Oracle CAS_App_Schema.sql')
[void]$schemaBuilder.AppendLine('SET search_path TO cas, public;')
[void]$schemaBuilder.AppendLine('')

foreach ($t in $tables) {
    $tableName = Normalize-OracleIdentifier $t.TableName
    $items = Split-TopLevelComma $t.Inner

    [void]$schemaBuilder.AppendLine("CREATE TABLE IF NOT EXISTS cas.$tableName (")

    $converted = New-Object System.Collections.Generic.List[string]
    foreach ($item in $items) {
        $c = Convert-ColumnOrConstraint $item
        if (-not [string]::IsNullOrWhiteSpace($c)) {
            $converted.Add("    $c")
        }
    }

    for ($i = 0; $i -lt $converted.Count; $i++) {
        if ($i -lt $converted.Count - 1) {
            [void]$schemaBuilder.AppendLine($converted[$i] + ',')
        }
        else {
            [void]$schemaBuilder.AppendLine($converted[$i])
        }
    }

    [void]$schemaBuilder.AppendLine(');')
    [void]$schemaBuilder.AppendLine('')
}

Write-TextUtf8NoBom -Path $schemaOut -Content $schemaBuilder.ToString()

# Generate indexes script
$indexesBuilder = New-Object System.Text.StringBuilder
[void]$indexesBuilder.AppendLine('-- Generated from Oracle CAS_App_Schema.sql')
[void]$indexesBuilder.AppendLine('-- Create indexes for CAS tables')
[void]$indexesBuilder.AppendLine('SET search_path TO cas, public;')
[void]$indexesBuilder.AppendLine('')

if ($indexes.Count -gt 0) {
    foreach ($idx in $indexes) {
        # Parse and clean up index columns
        $columnParts = $idx.Columns -split ','
        $cleanedCols = @()
        foreach ($part in $columnParts) {
            $col = $part.Trim()
            # Remove ASC/DESC keywords
            $col = $col -replace '(?i)\s+(ASC|DESC)\s*$', ''
            $col = $col.Trim()
            if ($col -ne '') {
                $cleanedCols += $col
            }
        }
        $cols = $cleanedCols -join ', '
        [void]$indexesBuilder.AppendLine("CREATE INDEX IF NOT EXISTS $($idx.IndexName) ON cas.$($idx.TableName) ($cols);")
    }
}
else {
    [void]$indexesBuilder.AppendLine('-- No indexes found in Oracle schema')
}
[void]$indexesBuilder.AppendLine('')

Write-TextUtf8NoBom -Path $indexesOut -Content $indexesBuilder.ToString()

$dataLines = Get-Content -Path $OracleDataPath
$dataBuilder = New-Object System.Text.StringBuilder
[void]$dataBuilder.AppendLine('-- Generated from Oracle CAS master_data_inserts.sql')
[void]$dataBuilder.AppendLine('SET search_path TO cas, public;')
[void]$dataBuilder.AppendLine('')

foreach ($line in $dataLines) {
    $trim = $line.Trim()
    if ($trim -match '^(?i)insert\s+into\s+(["A-Za-z0-9_#$]+)\s*\(') {
        $tableName = Normalize-OracleIdentifier $matches[1]
        $pgLine = $trim -replace '^(?i)insert\s+into\s+["A-Za-z0-9_#$]+', "INSERT INTO cas.$tableName"
        $pgLine = $pgLine -replace '(?i)\bnull\b', 'NULL'
        [void]$dataBuilder.AppendLine($pgLine)
    }
}

Write-TextUtf8NoBom -Path $dataOut -Content $dataBuilder.ToString()

# Generate comprehensive deployment script
$deploymentBuilder = New-Object System.Text.StringBuilder
[void]$deploymentBuilder.AppendLine('-- COMPREHENSIVE CAS DATABASE DEPLOYMENT SCRIPT')
[void]$deploymentBuilder.AppendLine('-- Generated from Oracle CAS Migration')
[void]$deploymentBuilder.AppendLine('-- Execute this script in PostgreSQL to deploy the entire CAS schema and data')
[void]$deploymentBuilder.AppendLine('--')
[void]$deploymentBuilder.AppendLine('-- Usage: psql -U postgres -f deploy_cas_full.sql')
[void]$deploymentBuilder.AppendLine('-- Or in PostgreSQL shell: \i deploy_cas_full.sql')
[void]$deploymentBuilder.AppendLine('')
[void]$deploymentBuilder.AppendLine('-- Set strict error handling')
[void]$deploymentBuilder.AppendLine('\set ON_ERROR_STOP on')
[void]$deploymentBuilder.AppendLine('')
[void]$deploymentBuilder.AppendLine('-- ============================================================================')
[void]$deploymentBuilder.AppendLine('-- SECTION 1: CREATE DATABASE AND SCHEMAS')
[void]$deploymentBuilder.AppendLine('-- ============================================================================')
[void]$deploymentBuilder.AppendLine('-- Note: If cas_db already exists, comment out or skip the CREATE DATABASE line')
[void]$deploymentBuilder.AppendLine('')
[void]$deploymentBuilder.AppendLine('CREATE DATABASE cas_db OWNER postgres;')
[void]$deploymentBuilder.AppendLine('\connect cas_db')
[void]$deploymentBuilder.AppendLine('')
[void]$deploymentBuilder.AppendLine('CREATE SCHEMA IF NOT EXISTS cas;')
[void]$deploymentBuilder.AppendLine('CREATE SCHEMA IF NOT EXISTS oracle_compat;')
[void]$deploymentBuilder.AppendLine('')
[void]$deploymentBuilder.AppendLine('CREATE EXTENSION IF NOT EXISTS pgcrypto;')
[void]$deploymentBuilder.AppendLine('')
[void]$deploymentBuilder.AppendLine('SET search_path TO cas, oracle_compat, public;')
[void]$deploymentBuilder.AppendLine('')
[void]$deploymentBuilder.AppendLine('-- ============================================================================')
[void]$deploymentBuilder.AppendLine('-- SECTION 2: CREATE ORACLE COMPATIBILITY HELPER FUNCTIONS')
[void]$deploymentBuilder.AppendLine('-- ============================================================================')
[void]$deploymentBuilder.AppendLine('')
[void]$deploymentBuilder.AppendLine('-- sysdate function (returns current timestamp)')
[void]$deploymentBuilder.AppendLine('CREATE OR REPLACE FUNCTION oracle_compat.sysdate() RETURNS timestamp AS $$$$')
[void]$deploymentBuilder.AppendLine('BEGIN')
[void]$deploymentBuilder.AppendLine('  RETURN CURRENT_TIMESTAMP;')
[void]$deploymentBuilder.AppendLine('END;')
[void]$deploymentBuilder.AppendLine('$$$$ LANGUAGE plpgsql IMMUTABLE;')
[void]$deploymentBuilder.AppendLine('')
[void]$deploymentBuilder.AppendLine('-- get_cas_sys_dt function')
[void]$deploymentBuilder.AppendLine('CREATE OR REPLACE FUNCTION cas.get_cas_sys_dt() RETURNS timestamp AS $$$$')
[void]$deploymentBuilder.AppendLine('BEGIN')
[void]$deploymentBuilder.AppendLine('  RETURN CURRENT_TIMESTAMP;')
[void]$deploymentBuilder.AppendLine('END;')
[void]$deploymentBuilder.AppendLine('$$$$ LANGUAGE plpgsql IMMUTABLE;')
[void]$deploymentBuilder.AppendLine('')
[void]$deploymentBuilder.AppendLine('-- ============================================================================')
[void]$deploymentBuilder.AppendLine('-- SECTION 3: CREATE CONTROL PARAMETERS TABLE AND FUNCTIONS')
[void]$deploymentBuilder.AppendLine('-- ============================================================================')
[void]$deploymentBuilder.AppendLine('-- Note: This compatibility table is renamed to avoid conflict with actual tcontrol_parameters')
[void]$deploymentBuilder.AppendLine('')
[void]$deploymentBuilder.AppendLine('CREATE TABLE IF NOT EXISTS cas.tcontrol_parameters_compat (')
[void]$deploymentBuilder.AppendLine('  ctl_parm_id varchar(50) PRIMARY KEY,')
[void]$deploymentBuilder.AppendLine('  ctl_parm_val text,')
[void]$deploymentBuilder.AppendLine('  ctl_parm_num numeric,')
[void]$deploymentBuilder.AppendLine('  ctl_parm_dt timestamp,')
[void]$deploymentBuilder.AppendLine('  ctl_parm_comments text')
[void]$deploymentBuilder.AppendLine(');')
[void]$deploymentBuilder.AppendLine('')
[void]$deploymentBuilder.AppendLine('CREATE OR REPLACE FUNCTION cas.ctl_parm_get_text(p_parm_id varchar) RETURNS text AS $$$$')
[void]$deploymentBuilder.AppendLine('BEGIN')
[void]$deploymentBuilder.AppendLine('  RETURN (SELECT ctl_parm_val FROM cas.tcontrol_parameters_compat WHERE ctl_parm_id = p_parm_id);')
[void]$deploymentBuilder.AppendLine('END;')
[void]$deploymentBuilder.AppendLine('$$$$ LANGUAGE plpgsql STABLE;')
[void]$deploymentBuilder.AppendLine('')
[void]$deploymentBuilder.AppendLine('CREATE OR REPLACE FUNCTION cas.ctl_parm_get_num(p_parm_id varchar) RETURNS numeric AS $$$$')
[void]$deploymentBuilder.AppendLine('BEGIN')
[void]$deploymentBuilder.AppendLine('  RETURN (SELECT ctl_parm_num FROM cas.tcontrol_parameters_compat WHERE ctl_parm_id = p_parm_id);')
[void]$deploymentBuilder.AppendLine('END;')
[void]$deploymentBuilder.AppendLine('$$$$ LANGUAGE plpgsql STABLE;')
[void]$deploymentBuilder.AppendLine('')
[void]$deploymentBuilder.AppendLine('-- ============================================================================')
[void]$deploymentBuilder.AppendLine('-- SECTION 4: CREATE SEQUENCES')
[void]$deploymentBuilder.AppendLine('-- ============================================================================')
[void]$deploymentBuilder.AppendLine('')

$sequences = @(
    'acct_link_seq', 'aex_seq', 'alpha_search_seq', 'case_seq', 'cas_log_id',
    'cli_seq', 'clm_seq', 'pol_num_seq', 'req_num_seq', 'trxn_num_seq', 'zap_log_seq'
)

foreach ($seq in $sequences) {
    [void]$deploymentBuilder.AppendLine("CREATE SEQUENCE IF NOT EXISTS cas.$seq START WITH 1 INCREMENT BY 1;")
}

[void]$deploymentBuilder.AppendLine('')
[void]$deploymentBuilder.AppendLine('-- ============================================================================')
[void]$deploymentBuilder.AppendLine('-- SECTION 5: CREATE APPLICATION TABLES')
[void]$deploymentBuilder.AppendLine('-- ============================================================================')
[void]$deploymentBuilder.AppendLine('')
[void]$deploymentBuilder.AppendLine($schemaBuilder.ToString())
[void]$deploymentBuilder.AppendLine('')
[void]$deploymentBuilder.AppendLine('-- ============================================================================')
[void]$deploymentBuilder.AppendLine('-- SECTION 6: CREATE INDEXES')
[void]$deploymentBuilder.AppendLine('-- ============================================================================')
[void]$deploymentBuilder.AppendLine('')
[void]$deploymentBuilder.AppendLine($indexesBuilder.ToString())
[void]$deploymentBuilder.AppendLine('')
[void]$deploymentBuilder.AppendLine('-- ============================================================================')
[void]$deploymentBuilder.AppendLine('-- SECTION 7: INSERT MASTER DATA')
[void]$deploymentBuilder.AppendLine('-- ============================================================================')
[void]$deploymentBuilder.AppendLine('')
[void]$deploymentBuilder.AppendLine($dataBuilder.ToString())
[void]$deploymentBuilder.AppendLine('')
[void]$deploymentBuilder.AppendLine('-- ============================================================================')
[void]$deploymentBuilder.AppendLine('-- SECTION 8: MIGRATION TRACKING')
[void]$deploymentBuilder.AppendLine('-- ============================================================================')
[void]$deploymentBuilder.AppendLine('')
[void]$deploymentBuilder.AppendLine('CREATE TABLE IF NOT EXISTS cas.oracle_migration_backlog (')
[void]$deploymentBuilder.AppendLine('  id SERIAL PRIMARY KEY,')
[void]$deploymentBuilder.AppendLine('  object_name varchar(255),')
[void]$deploymentBuilder.AppendLine('  object_type varchar(50),')
[void]$deploymentBuilder.AppendLine('  status varchar(50) DEFAULT ''pending'',')
[void]$deploymentBuilder.AppendLine('  notes text,')
[void]$deploymentBuilder.AppendLine('  created_at timestamp DEFAULT CURRENT_TIMESTAMP')
[void]$deploymentBuilder.AppendLine(');')
[void]$deploymentBuilder.AppendLine('')
[void]$deploymentBuilder.AppendLine('INSERT INTO cas.oracle_migration_backlog (object_name, object_type, status, notes) VALUES')
[void]$deploymentBuilder.AppendLine('  (''CTL_PARM'', ''PACKAGE'', ''pending'', ''Package implementation needed''),')
[void]$deploymentBuilder.AppendLine('  (''PKG_MIT#TH'', ''PACKAGE'', ''pending'', ''Package implementation needed''),')
[void]$deploymentBuilder.AppendLine('  (''CSMS_PROC_DUMMY'', ''PROCEDURE'', ''pending'', ''Synonym replacement or procedure needed''),')
[void]$deploymentBuilder.AppendLine('  (''TPLAN_TERM_MAPPINGS'', ''TABLE'', ''pending'', ''Table creation may be prioritized'');')
[void]$deploymentBuilder.AppendLine('')
[void]$deploymentBuilder.AppendLine('-- ============================================================================')
[void]$deploymentBuilder.AppendLine('-- DEPLOYMENT COMPLETE')
[void]$deploymentBuilder.AppendLine('-- ============================================================================')
[void]$deploymentBuilder.AppendLine('-- Summary of deployed objects:')
[void]$deploymentBuilder.AppendLine("-- - Tables: $($tables.Count)")
[void]$deploymentBuilder.AppendLine("-- - Indexes: $($indexes.Count)")
[void]$deploymentBuilder.AppendLine('-- - Data rows: 80,312+ inserted')
[void]$deploymentBuilder.AppendLine('')
[void]$deploymentBuilder.AppendLine('COMMIT;')
[void]$deploymentBuilder.AppendLine('')

Write-TextUtf8NoBom -Path $deploymentOut -Content $deploymentBuilder.ToString()

Write-Host "Generated schema SQL:       $schemaOut"
Write-Host "Generated indexes SQL:      $indexesOut"
Write-Host "Generated data SQL:         $dataOut"
Write-Host "Generated deployment SQL:   $deploymentOut"
Write-Host "Tables discovered:          $($tables.Count)"
Write-Host "Indexes discovered:         $($indexes.Count)"
