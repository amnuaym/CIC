$BaseUrl = "http://localhost/api"
$V1Url = "http://localhost/api/v1"
$ErrorActionPreference = "Stop"

function Test-ApiParams {
    Write-Host "1. Testing Login..." -NoNewline
    $body = @{ username = "superadmin"; password = "Super!Secret.2024" } | ConvertTo-Json
    
    try {
        $loginRes = Invoke-RestMethod -Method Post -Uri "$BaseUrl/auth/login" -Body $body -ContentType "application/json"
        $token = $loginRes.token
        Write-Host " [OK]" -ForegroundColor Green
        
        Write-Host "2. Testing GET Customers..." -NoNewline
        $headers = @{ Authorization = "Bearer $token" }
        try {
            # Try V1 URL to get ID
            $customers = Invoke-RestMethod -Method Get -Uri "$V1Url/customers" -Headers $headers
            Write-Host " [OK] (Found $($customers.Count) customers)" -ForegroundColor Green
            
            if ($customers.Count -gt 0) {
                $id = $customers[0].id
                Write-Host "3. Testing DELETE Customer ($id)..." -NoNewline
                try {
                    Invoke-RestMethod -Method Delete -Uri "$V1Url/customers/$id" -Headers $headers
                    Write-Host " [OK]" -ForegroundColor Green
                }
                catch {
                    Write-Host " [FAILED DELETE]" -ForegroundColor Red
                    Write-Host "   $_" -ForegroundColor Gray
                }

                # 4. Verify Deleted List
                Write-Host "4. Testing GET Deleted Customers..." -NoNewline
                try {
                    $deleted = Invoke-RestMethod -Method Get -Uri "$V1Url/customers?deleted=true" -Headers $headers
                    $found = $deleted | Where-Object { $_.id -eq $id }
                    if ($found) {
                        Write-Host " [OK] (Found deleted ID: $id)" -ForegroundColor Green
                    }
                    else {
                        Write-Host " [FAILED] (ID not found in deleted list)" -ForegroundColor Red
                    }
                }
                catch {
                    Write-Host " [FAILED]" -ForegroundColor Red
                    Write-Host "   $_" -ForegroundColor Gray
                }

                # 5. Restore Customer
                Write-Host "5. Testing RESTORE Customer ($id)..." -NoNewline
                try {
                    Invoke-RestMethod -Method Post -Uri "$V1Url/customers/$id/restore" -Headers $headers
                    Write-Host " [OK]" -ForegroundColor Green
                }
                catch {
                    Write-Host " [FAILED RESTORE]" -ForegroundColor Red
                    Write-Host "   $_" -ForegroundColor Gray
                }
            }
            else {
                Write-Host "3. Skipping DELETE (No customers found)" -ForegroundColor Yellow
            }
            return
        }
        catch {
            Write-Host " [FAILED V1]" -ForegroundColor Red
            Write-Host "   $_" -ForegroundColor Gray
        }

    }
    catch {
        Write-Host " [FAILED LOGIN]" -ForegroundColor Red
        Write-Host "   $_" -ForegroundColor Gray
    }
}

Test-ApiParams
