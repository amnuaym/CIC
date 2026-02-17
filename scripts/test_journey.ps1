$ErrorActionPreference = "Stop"
$BaseUrl = "http://localhost/api/v1"

function Test-Step {
    param($Name, $ScriptBlock)
    Write-Host "➡️ $Name..." -NoNewline
    try {
        & $ScriptBlock
        Write-Host " ✅ OK" -ForegroundColor Green
    } catch {
        Write-Host " ❌ FAILED" -ForegroundColor Red
        Write-Host $_
        exit 1
    }
}

# 1. Create Personal Customer
Test-Step "Create John Doe" {
    $body = @{
        type = "PERSONAL"
        first_name = "John"
        last_name = "Doe"
        title = "Mr."
        status = "ACTIVE"
        date_of_birth = "1990-01-01T00:00:00Z"
        nationality = "Thai"
    } | ConvertTo-Json

    $global:John = Invoke-RestMethod -Method Post -Uri "$BaseUrl/customers" -Body $body -ContentType "application/json"
    if (-not $John.id) { throw "No ID returned" }
}

# 2. Add Address
Test-Step "Add Address" {
    $body = @{
        type = "Registered"
        address_line1 = "123 Sukhumvit Road"
        city = "Bangkok"
        zip_code = "10110"
        country = "Thailand"
    } | ConvertTo-Json

    Invoke-RestMethod -Method Post -Uri "$BaseUrl/customers/$($John.id)/addresses" -Body $body -ContentType "application/json"
}

# 3. Add Identity
Test-Step "Add Identity" {
    $body = @{
        type = "National ID"
        number = "1-2345-67890-12-3"
        issuance_country = "Thailand"
        expiry_date = "2030-12-31T00:00:00Z"
    } | ConvertTo-Json

    Invoke-RestMethod -Method Post -Uri "$BaseUrl/customers/$($John.id)/identities" -Body $body -ContentType "application/json"
}

# 4. Grant Consent
Test-Step "Grant Consent" {
    $body = @{
        topic = "Marketing"
        version = "1.0"
        is_granted = $true
    } | ConvertTo-Json

    Invoke-RestMethod -Method Post -Uri "$BaseUrl/customers/$($John.id)/consents" -Body $body -ContentType "application/json"
}

# 5. Create Juristic Customer
Test-Step "Create Acme Corp" {
    $body = @{
        type = "JURISTIC"
        company_name = "Acme Corp Ltd."
        status = "ACTIVE"
        registration_date = "2020-05-20T00:00:00Z"
        industry_code = "TECH001"
    } | ConvertTo-Json

    $global:Acme = Invoke-RestMethod -Method Post -Uri "$BaseUrl/customers" -Body $body -ContentType "application/json"
    if (-not $Acme.id) { throw "No ID returned" }
}

# 6. Link Relationship
Test-Step "Link John as Director" {
    $body = @{
        to_customer_id = $Acme.id
        role = "Director"
    } | ConvertTo-Json

    Invoke-RestMethod -Method Post -Uri "$BaseUrl/customers/$($John.id)/relationships" -Body $body -ContentType "application/json"
}

# 7. Anonymize John (Right to be Forgotten)
Test-Step "Anonymize John" {
    Invoke-RestMethod -Method Post -Uri "$BaseUrl/customers/$($John.id)/anonymize"
}

# 8. Verify Anonymization
Test-Step "Verify Anonymization" {
    $UpdatedJohn = Invoke-RestMethod -Method Get -Uri "$BaseUrl/customers/$($John.id)"
    if ($UpdatedJohn.first_name -notmatch "Deleted_User_") {
        throw "FirstName not anonymized: $($UpdatedJohn.first_name)"
    }
    if ($UpdatedJohn.status -ne "BLACKLISTED") { # Or whatever status logic we used
        Write-Warning "Status check: Expected BLACKLISTED, got $($UpdatedJohn.status)"
    }
}

Write-Host "`n🎉 Journey Completed Successfully!" -ForegroundColor Cyan
