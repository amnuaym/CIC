# CAS Database Deployment Quick Start (PowerShell)
# Run this script to deploy the CAS PostgreSQL database on Windows
#
# Usage: .\deploy_cas.ps1
# Or in PowerShell: powershell -ExecutionPolicy Bypass -File deploy_cas.ps1

param(
    [string]$DbUser = "postgres",
    [string]$DbHost = "localhost",
    [string]$DbPort = "5432",
    [string]$DbPassword = "",
    [switch]$SkipValidation = $false,
    [switch]$Force = $false,
    [switch]$TwoStep = $true,  # Default to two-step deployment
    [switch]$SingleFile = $false  # Use single-file deployment instead
)

$ErrorActionPreference = "Stop"

# Colors for output
function Write-Header {
    Write-Host ""
    Write-Host "╔═══════════════════════════════════════════════════════════════╗" -ForegroundColor Cyan
    Write-Host "║          CAS Oracle-to-PostgreSQL Database Deployment        ║" -ForegroundColor Cyan
    Write-Host "╚═══════════════════════════════════════════════════════════════╝" -ForegroundColor Cyan
    Write-Host ""
}

function Write-Success {
    param([string]$Message)
    Write-Host "✓ $Message" -ForegroundColor Green
}

function Write-Error {
    param([string]$Message)
    Write-Host "✗ $Message" -ForegroundColor Red
}

function Write-Info {
    param([string]$Message)
    Write-Host "ℹ $Message" -ForegroundColor Yellow
}

# Configuration
$ScriptDir = "scripts\generated"
$SchemaScript = "$ScriptDir\deploy_cas_schema.sql"
$DataScript = "$ScriptDir\deploy_cas_data.sql"
$FullScript = "$ScriptDir\deploy_cas_full.sql"
$ValidateScript = "$ScriptDir\validate_cas_deployment.sql"

Write-Header

# Determine which deployment method to use
if ($SingleFile) {
    $TwoStep = $false
}

# Check if deploy scripts exist
if ($TwoStep) {
    if (-not (Test-Path $SchemaScript)) {
        Write-Error "Schema script not found: $SchemaScript"
        Write-Host "Make sure you're running this from the CIC repository root directory"
        exit 1
    }
    if (-not (Test-Path $DataScript)) {
        Write-Error "Data script not found: $DataScript"
        Write-Host "Make sure you're running this from the CIC repository root directory"
        exit 1
    }
}
else {
    if (-not (Test-Path $FullScript)) {
        Write-Error "Full deployment script not found: $FullScript"
        Write-Host "Make sure you're running this from the CIC repository root directory"
        exit 1
    }
}

# Display configuration
Write-Host "Configuration:" -ForegroundColor Cyan
Write-Host "  PostgreSQL User: $DbUser"
Write-Host "  PostgreSQL Host: $DbHost"
Write-Host "  PostgreSQL Port: $DbPort"
if ($TwoStep) {
    Write-Host "  Deployment Mode: Two-step (schema + data)" -ForegroundColor Green
    Write-Host "  Schema Script:   $SchemaScript"
    Write-Host "  Data Script:     $DataScript"
}
else {
    Write-Host "  Deployment Mode: Single-file (all-in-one)" -ForegroundColor Yellow
    Write-Host "  Deployment Script: $FullScript"
}
Write-Host ""

# Confirm deployment
if (-not $Force) {
    $mode = if ($TwoStep) { "two-step" } else { "single-file" }
    $response = Read-Host "Deploy CAS database using $mode approach? (yes/no)"
    if ($response -ne "yes" -and $response -ne "y") {
        Write-Host "Deployment cancelled."
        exit 0
    }
}

Write-Info "Starting deployment..."
Write-Host ""

# Run the deployment
try {
    if ($TwoStep) {
        # Two-step deployment: schema first, then data
        Write-Host "═══════════════════════════════════════" -ForegroundColor Cyan
        Write-Host "STEP 1: Deploying Database Schema" -ForegroundColor Cyan
        Write-Host "═══════════════════════════════════════" -ForegroundColor Cyan
        Write-Host ""
        
        $schemaArgs = @(
            "-U", $DbUser
            "-h", $DbHost
            "-p", $DbPort
            "-f", $SchemaScript
        )
        
        Write-Host "Running: psql $($schemaArgs -join ' ')" -ForegroundColor DarkGray
        Write-Host ""
        
        & psql @schemaArgs
        
        if ($LASTEXITCODE -ne 0) {
            Write-Error "Schema deployment failed with exit code $LASTEXITCODE"
            exit 1
        }
        
        Write-Host ""
        Write-Success "Schema deployment completed successfully!"
        Write-Host ""
        
        Write-Host "═══════════════════════════════════════" -ForegroundColor Cyan
        Write-Host "STEP 2: Inserting Master Data" -ForegroundColor Cyan
        Write-Host "═══════════════════════════════════════" -ForegroundColor Cyan
        Write-Host ""
        
        $dataArgs = @(
            "-U", $DbUser
            "-h", $DbHost
            "-p", $DbPort
            "-d", "cas_db"
            "-f", $DataScript
        )
        
        Write-Host "Running: psql $($dataArgs -join ' ')" -ForegroundColor DarkGray
        Write-Host ""
        
        & psql @dataArgs
        
        if ($LASTEXITCODE -ne 0) {
            Write-Error "Data insertion failed with exit code $LASTEXITCODE"
            exit 1
        }
        
        Write-Host ""
        Write-Success "Data insertion completed successfully!"
        Write-Host ""
    }
    else {
        # Single-file deployment
        $psqlArgs = @(
            "-U", $DbUser
            "-h", $DbHost
            "-p", $DbPort
            "-f", $FullScript
        )
        
        Write-Host "Running: psql $($psqlArgs -join ' ')" -ForegroundColor DarkGray
        Write-Host ""
        
        & psql @psqlArgs
        
        if ($LASTEXITCODE -ne 0) {
            Write-Error "Deployment failed with exit code $LASTEXITCODE"
            exit 1
        }
        
        Write-Host ""
        Write-Success "Deployment completed successfully!"
        Write-Host ""
    }
    
    # Ask if user wants to run validation
    if (-not $SkipValidation) {
        $response = Read-Host "Run validation queries now? (yes/no)"
        if ($response -eq "yes" -or $response -eq "y") {
            Write-Info "Running validation..."
            Write-Host ""
            
            $validateArgs = @(
                "-U", $DbUser
                "-h", $DbHost
                "-p", $DbPort
                "-d", "cas_db"
                "-f", $ValidateScript
            )
            
            & psql @validateArgs
            
            if ($LASTEXITCODE -eq 0) {
                Write-Host ""
                Write-Success "Validation complete!"
                Write-Host ""
                Write-Host "Next steps:" -ForegroundColor Cyan
                Write-Host "  1. Review validation output above"
                Write-Host "  2. Update application connection strings to PostgreSQL"
                Write-Host "  3. Test application functionality"
                Write-Host "  4. Monitor oracle_migration_backlog table for remaining work"
                Write-Host ""
            }
            else {
                Write-Error "Validation failed"
                exit 1
            }
        }
        else {
            Write-Host "Validation skipped. Run it manually with:" -ForegroundColor Yellow
            Write-Host "  psql -U $DbUser -d cas_db -f $ValidateScript" -ForegroundColor Yellow
            Write-Host ""
        }
    }
    
    Write-Host "Connect to the database with:" -ForegroundColor Cyan
    Write-Host "  psql -U $DbUser -h $DbHost -p $DbPort -d cas_db" -ForegroundColor Cyan
    Write-Host ""
}
catch {
    Write-Host ""
    Write-Error "Deployment failed!"
    Write-Host ""
    Write-Host "Error: $_" -ForegroundColor Red
    Write-Host ""
    Write-Host "Troubleshooting:" -ForegroundColor Yellow
    Write-Host "  1. Check PostgreSQL is running and accessible"
    Write-Host "  2. Verify PostgreSQL is in PATH or provide full path:"
    Write-Host "     C:\Program Files\PostgreSQL\15\bin\psql.exe"
    Write-Host "  3. Verify PostgreSQL user/password is correct"
    Write-Host "  4. Review error messages above"
    if ($TwoStep) {
        Write-Host "  5. If schema deployment succeeded but data failed, you can re-run"
        Write-Host "     just the data insertion: psql -U $DbUser -d cas_db -f $DataScript"
    }
    Write-Host ""
    exit 1
}
