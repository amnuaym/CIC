$BaseUrl = "http://localhost/api"
$ErrorActionPreference = "Stop"

function Test-Login {
    param($Username, $Password)
    Write-Host "[->] Testing Login: $Username ..." -NoNewline
    
    $body = @{
        username = $Username
        password = $Password
    } | ConvertTo-Json

    try {
        $res = Invoke-RestMethod -Method Post -Uri "$BaseUrl/auth/login" -Body $body -ContentType "application/json"
        
        if ($res.token) {
            Write-Host " [OK]" -ForegroundColor Green
            # Update: Check if role is returned (optional, depends on API)
            # Write-Host "     Token: $($res.token.Substring(0, 10))..." -ForegroundColor Gray
        }
        else {
            Write-Host " [FAILED] (No Token)" -ForegroundColor Red
        }
    }
    catch {
        Write-Host " [FAILED]" -ForegroundColor Red
        Write-Host "     $($_.Exception.Message)" -ForegroundColor Gray
        # Read stream if available
        if ($_.Exception.Response) {
            $reader = New-Object System.IO.StreamReader $_.Exception.Response.GetResponseStream()
            Write-Host "     Response: $($reader.ReadToEnd())" -ForegroundColor Gray
        }
    }
}

# Test all seeded users
Test-Login -Username "superadmin" -Password "Super!Secret.2024"
Test-Login -Username "contact_admin" -Password "Contact#Admin.99"
Test-Login -Username "consent_admin" -Password "ConsentAdmin.88!"
Test-Login -Username "identity_admin" -Password "Identity`$Admin.88"
