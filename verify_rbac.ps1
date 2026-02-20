$ErrorActionPreference = "Stop"

function Assert-Success($response, $msg) {
    if ($response.StatusCode -ge 200 -and $response.StatusCode -lt 300) {
        Write-Host "PASS: $msg" -ForegroundColor Green
    }
    else {
        Write-Host "FAIL: $msg (Status: $($response.StatusCode))" -ForegroundColor Red
        exit 1
    }
}

function Assert-Fail($response, $msg) {
    if ($response.StatusCode -ge 400) {
        Write-Host "PASS: $msg (Got expected error)" -ForegroundColor Green
    }
    else {
        Write-Host "FAIL: $msg (Expected error, got success)" -ForegroundColor Red
        exit 1
    }
}

function Create-User($username, $email, $password) {
    $body = @{
        username = $username
        email    = $email
        password = $password
    } | ConvertTo-Json
    
    try {
        $response = Invoke-RestMethod -Uri "http://localhost/api/auth/register" -Method Post -Body $body -ContentType "application/json" -ErrorAction Stop
        return $response
    }
    catch {
        if ($_.Exception.Response.StatusCode -eq 409) {
            # Login if exists
            $loginBody = @{ username = $username; password = $password } | ConvertTo-Json
            $response = Invoke-RestMethod -Uri "http://localhost/api/auth/login" -Method Post -Body $loginBody -ContentType "application/json"
            return $response
        }
        throw $_
    }
}

function Update-Role($username, $role, $supervisorUsername) {
    $supervisorIdClause = "NULL"
    if ($supervisorUsername) {
        $supervisorIdClause = "(SELECT id FROM users WHERE username = '$supervisorUsername')"
    }
    
    $query = "UPDATE users SET role='$role', supervisor_id=$supervisorIdClause WHERE username='$username';"
    # Use docker run to connect to host DB
    # Pass arguments as array to avoid shell parsing issues with ;
    $env:PGPASSWORD = 'veo;pMek'
    # Wait, passing env var to docker run is tricky if we set it in host shell.
    # Docker run takes -e.
    # Use array
    $dockerArgs = @("run", "--rm", "-e", "PGPASSWORD=veo;pMek", "postgres:15-alpine", "psql", "-h", "host.docker.internal", "-U", "postgres", "-d", "cic_dev", "-c", $query)
    & docker $dockerArgs
}

# 1. Create Users
Write-Host "Creating users..."
$adminDeleter = Create-User "admin_deleter" "admin@example.com" "password123"
$adminOther = Create-User "admin_other" "other@example.com" "password123"
$supervisor = Create-User "supervisor" "sup@example.com" "password123"
$userSimple = Create-User "user_simple" "simple@example.com" "password123"

function Decode-JWT($token) {
    if (-not $token) { return "No Token" }
    $parts = $token.Split(".")
    if ($parts.Length -ne 3) { return "Invalid Token Format" }
    $payload = $parts[1]
    # Add padding if needed
    switch ($payload.Length % 4) {
        2 { $payload += "==" }
        3 { $payload += "=" }
    }
    $bytes = [System.Convert]::FromBase64String($payload)
    $json = [System.Text.Encoding]::UTF8.GetString($bytes)
    return $json
}

# ... (Previous user creation logic) ...

# 2. Update Roles
Write-Host "Updating roles..."
Update-Role "supervisor" "admin" $null
Update-Role "admin_deleter" "admin" "supervisor"
Update-Role "admin_other" "admin" $null

# Refresh tokens
Write-Host "Refreshing tokens..."
$adminDeleter = Create-User "admin_deleter" "admin@example.com" "password123"
$tokenDeleter = $adminDeleter.token
Write-Host "AdminDeleter Token Claims: $(Decode-JWT $tokenDeleter)"

$adminOther = Create-User "admin_other" "other@example.com" "password123"
$tokenOther = $adminOther.token

$supervisor = Create-User "supervisor" "sup@example.com" "password123"
$tokenSupervisor = $supervisor.token
Write-Host "Supervisor Token Claims: $(Decode-JWT $tokenSupervisor)"

$userSimple = Create-User "user_simple" "simple@example.com" "password123"
$tokenUser = $userSimple.token
Write-Host "UserSimple Token Claims: $(Decode-JWT $tokenUser)"

# ... (Rest of the script with better error logging) ...

# 4. UserSimple tries to delete
Write-Host "Test: UserSimple delete..."
try {
    Invoke-RestMethod -Uri "http://localhost/api/v1/customers/$custId" -Method Delete -Headers @{ Authorization = "Bearer $tokenUser" } -ErrorAction Stop
    Write-Host "FAIL: UserSimple should NOT be able to delete" -ForegroundColor Red
}
catch {
    $status = $_.Exception.Response.StatusCode
    if ([int]$status -eq 403) {
        Write-Host "PASS: UserSimple delete blocked (403)" -ForegroundColor Green
    }
    elseif ([int]$status -eq 401) {
        Write-Host "FAIL: UserSimple delete blocked with 401 (Unauthorized) - Token issue?" -ForegroundColor Yellow
    }
    else {
        Write-Host "PASS: UserSimple delete blocked ($status)" -ForegroundColor Green
    }
}

# 5. AdminDeleter deletes
Write-Host "Test: AdminDeleter delete..."
try {
    Invoke-RestMethod -Uri "http://localhost/api/v1/customers/$custId" -Method Delete -Headers @{ Authorization = "Bearer $tokenDeleter" } -ErrorAction Stop
    Write-Host "PASS: AdminDeleter delete success" -ForegroundColor Green
}
catch {
    Write-Host "FAIL: AdminDeleter delete failed. Status: $($_.Exception.Response.StatusCode)" -ForegroundColor Red
    exit 1
}

# ... (rest of tests)

# 6. UserSimple tries to restore
Write-Host "Test: UserSimple restore..."
try {
    Invoke-RestMethod -Uri "http://localhost/api/v1/customers/$custId/restore" -Method Post -Headers @{ Authorization = "Bearer $tokenUser" } -ErrorAction Stop
    Write-Host "FAIL: UserSimple should NOT be able to restore" -ForegroundColor Red
}
catch {
    Write-Host "PASS: UserSimple restore blocked" -ForegroundColor Green
}

# 7. AdminOther tries to restore (NOT supervisor)
Write-Host "Test: AdminOther restore..."
try {
    Invoke-RestMethod -Uri "http://localhost/api/v1/customers/$custId/restore" -Method Post -Headers @{ Authorization = "Bearer $tokenOther" } -ErrorAction Stop
    Write-Host "FAIL: AdminOther should NOT be able to restore" -ForegroundColor Red
}
catch {
    Write-Host "PASS: AdminOther restore blocked" -ForegroundColor Green
}

# 8. AdminDeleter tries to restore (Self)
Write-Host "Test: AdminDeleter restore (Self)..."
Invoke-RestMethod -Uri "http://localhost/api/v1/customers/$custId/restore" -Method Post -Headers @{ Authorization = "Bearer $tokenDeleter" }
Write-Host "PASS: AdminDeleter restore success" -ForegroundColor Green

# 9. AdminDeleter deletes AGAIN
Invoke-RestMethod -Uri "http://localhost/api/v1/customers/$custId" -Method Delete -Headers @{ Authorization = "Bearer $tokenDeleter" }

# 10. Supervisor tries to restore
Write-Host "Test: Supervisor restore..."
try {
    Invoke-RestMethod -Uri "http://localhost/api/v1/customers/$custId/restore" -Method Post -Headers @{ Authorization = "Bearer $tokenSupervisor" } -ErrorAction Stop
    Write-Host "PASS: Supervisor restore success" -ForegroundColor Green
}
catch {
    Write-Host "FAIL: Supervisor should be able to restore" -ForegroundColor Red
    Write-Host $_
}

Write-Host "Verification Complete"
