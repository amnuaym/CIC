$ErrorActionPreference = "Stop"
$BaseUrl = "http://localhost:8080/api/v1"

# Login to get Bearer token for all requests
$LoginBody = @{
    username = "superadmin"
    password = "Super!Secret.2024"
} | ConvertTo-Json
$AuthRes = Invoke-RestMethod -Method Post -Uri "http://localhost:8080/api/auth/login" -Body $LoginBody -ContentType "application/json"
$Headers = @{
    Authorization = "Bearer $($AuthRes.token)"
}

function Test-Step {
    param($Name, $ScriptBlock, $ExpectError = $false)
    Write-Host "[->] $Name..." -NoNewline
    try {
        & $ScriptBlock
        if ($ExpectError) {
            Write-Host " [FAILED] (Expected Error but got Success)" -ForegroundColor Red
            exit 1
        }
        Write-Host " [OK]" -ForegroundColor Green
    }
    catch {
        if ($ExpectError) {
            Write-Host " [OK] (Expected Error: $_)" -ForegroundColor Green
        }
        else {
            Write-Host " [FAILED]" -ForegroundColor Red
            Write-Host $_
            exit 1
        }
    }
}

# 1. Create Customer
Test-Step "Create Test User" {
    $body = @{
        type       = "PERSONAL"
        first_name = "Test"
        last_name  = "Validation"
        status     = "ACTIVE"
    } | ConvertTo-Json

    $global:User = Invoke-RestMethod -Method Post -Uri "$BaseUrl/customers" -Body $body -ContentType "application/json" -Headers $Headers
    if (-not $User.id) { throw "No ID returned" }
}

# 2. Invalid Format (Short)
Test-Step "Add Invalid Format ID (Short)" {
    $body = @{
        type             = "National ID"
        number           = "123456"
        issuance_country = "Thailand"
    } | ConvertTo-Json

    Invoke-RestMethod -Method Post -Uri "$BaseUrl/customers/$($User.id)/identities" -Body $body -ContentType "application/json" -Headers $Headers
} -ExpectError $true

# 3. Invalid Checksum
Test-Step "Add Invalid Checksum ID (1234567890120)" {
    $body = @{
        type             = "National ID"
        number           = "1234567890120"
        issuance_country = "Thailand"
    } | ConvertTo-Json

    Invoke-RestMethod -Method Post -Uri "$BaseUrl/customers/$($User.id)/identities" -Body $body -ContentType "application/json" -Headers $Headers
} -ExpectError $true

function Generate-ThaiID {
    $digits = 1..12 | ForEach-Object { Get-Random -Minimum 0 -Maximum 10 }
    $sum = 0
    for ($i = 0; $i -lt 12; $i++) {
        $sum += $digits[$i] * (13 - $i)
    }
    $check = (11 - ($sum % 11)) % 10
    return ($digits -join "") + $check
}

# 4. Valid ID
$ValidID = Generate-ThaiID
Test-Step "Add Valid ID ($ValidID)" {
    $body = @{
        type             = "National ID"
        number           = $ValidID
        issuance_country = "Thailand"
    } | ConvertTo-Json

    Invoke-RestMethod -Method Post -Uri "$BaseUrl/customers/$($User.id)/identities" -Body $body -ContentType "application/json" -Headers $Headers
}

Write-Host "`n[DONE] Validation Tests Completed Successfully!" -ForegroundColor Cyan
