$BaseUrl = "http://localhost/api/v1"
$ErrorActionPreference = "Stop"

function Create-User {
    param($Username, $Email, $Password, $Role)
    Write-Host "[->] Creating User: $Username ($Role)..." -NoNewline
    
    # 0. Cleanup: Delete existing user to allow re-seeding with new password
    $Env:PGPASSWORD = "veo;pMek"
    docker run --rm --add-host=host.docker.internal:host-gateway -e PGPASSWORD=$Env:PGPASSWORD postgres:alpine psql -h host.docker.internal -U postgres -d cic_dev -c "DELETE FROM users WHERE username = '$Username';" | Out-Null

    # 1. Register via API (Handles Password Hashing)
    $body = @{
        username = $Username
        email    = $Email
        password = $Password
    } | ConvertTo-Json

    try {
        $res = Invoke-RestMethod -Method Post -Uri "http://localhost/api/auth/register" -Body $body -ContentType "application/json"
        
        # 2. Update Role via SQL (Since API doesn't support setting role yet)
        $sql = "UPDATE users SET role = '$Role' WHERE username = '$Username';"
        # Use simple docker connection string assuming psql is available in postgres container
        # We use the same technique as migration apply
        $Env:PGPASSWORD = "veo;pMek"
        docker run --rm --add-host=host.docker.internal:host-gateway -e PGPASSWORD=$Env:PGPASSWORD postgres:alpine psql -h host.docker.internal -U postgres -d cic_dev -c $sql | Out-Null
        
        Write-Host " [OK]" -ForegroundColor Green
    }
    catch {
        $msg = $_
        if ($_.Exception.Response.StatusCode -eq "Conflict") {
            Write-Host " [SKIPPED] (Already Exists)" -ForegroundColor Yellow
        }
        else {
            Write-Host " [FAILED]" -ForegroundColor Red
            Write-Host $msg
        }
    }
}

# Seed Users
Create-User -Username "superadmin" -Email "super@cic.local" -Password "Super!Secret.2024" -Role "SUPER_ADMIN"
Create-User -Username "contact_admin" -Email "contact@cic.local" -Password "Contact#Admin.99" -Role "CUSTOMER_CONTACT_ADMIN"
Create-User -Username "consent_admin" -Email "consent@cic.local" -Password "ConsentAdmin.88!" -Role "CUSTOMER_CONSENT_ADMIN"
Create-User -Username "identity_admin" -Email "identity@cic.local" -Password "Identity`$Admin.88" -Role "CUSTOMER_IDENTITY_ADMIN" 
# Note: Backtick escape for $ in PowerShell string if not single quoted, but here strict strings might be safer.
