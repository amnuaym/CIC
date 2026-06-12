# SSL/TLS Testing, Verification, and Integration Strategy Handoff Report

This report defines the verification, testing, and integration strategy for the SSL/TLS configuration of the Customer Information Center (CIC) application on `cic.local` (port 443) and its automated key rotation.

---

## 1. Observation

Based on the inspection of the project files, the following code paths, files, and configurations were observed:

1. **Project Layout (`PROJECT.md`)**:
   - The project structure allocates SSL/TLS configurations under `prod-setup/nginx/nginx.conf` and certificate rotation scripts under `prod-setup/nginx/rotate-certs.sh` (or `.ps1`) (Lines 14-15).
   - Milestone 3 is `SSL/TLS & Key Rotation`, and Milestone 4 is `Integration & Verification` (Lines 22-23).
   - The interface contract dictates that Nginx must proxy requests from `cic.local:443` to `cic-api` (Go) and `react-admin` (React), and the rotation script must regenerate certificates and reload Nginx (Lines 28-29).

2. **Current Nginx Gateway Configuration (`nginx/nginx.conf`)**:
   - The Nginx gateway currently listens only on HTTP port 80 (Lines 9-10).
   - It proxies requests to the backend API services (`cic-api:8080` on `/health`, `/swagger/`, `/api/`, `/api/v1/`) and the frontend service (`react-admin:80` on `/`) (Lines 12-52).
   - There is no SSL configuration (port 443), no server block for redirects, and no SSL certificate paths configured.

3. **Docker Compose (`docker-compose.yml`)**:
   - The `react-admin` service maps port `3000:80` and has environment argument `VITE_API_URL` set to `http://localhost:80/api/v1` (Lines 21-34).
   - The `nginx` service mounts the configuration at `./nginx/nginx.conf` and maps port `80:80` (Lines 48-59). There are no volumes for certificates or maps for port 443.

4. **React Admin API URL (`react-admin/src/dataProvider.ts`)**:
   - The application fetches the API URL using:
     `const API_URL = import.meta.env.VITE_API_URL || 'http://localhost:80/api/v1';` (Line 4).
   - Requests are resolved using `window.location.origin` as a base when relative paths are not fully formed (Line 34).

5. **E2E Playwright Tests (`e2e-tests/playwright.config.ts`)**:
   - Playwright runs tests with `baseURL` set to `http://localhost:3001` (Line 14).
   - The tests are located in `e2e-tests/tests/admin.spec.ts` (React Admin) and `e2e-tests/tests/api.spec.ts` (API and Health Checks).
   - The configuration lacks the `ignoreHTTPSErrors: true` property required for running tests against self-signed SSL/TLS certificates.

6. **Go API CORS & Cookie Settings (`go/main.go` & `go/internal/middleware/middleware.go`)**:
   - CORS middleware in `main.go` sets `AllowedOrigins` to `[]string{"*"}` (Line 58).
   - Standard session cookies or secure cookie flags are not explicitly configured to require HTTPS in `go/internal/middleware/middleware.go` or `go/main.go`.

---

## 2. Logic Chain

From the direct observations above, the following step-by-step reasoning defines our strategy:

1. **Protocol Redirection**:
   - *Observation*: The existing setup uses HTTP-only (port 80). The target configuration introduces HTTPS (port 443) for `cic.local`.
   - *Inference*: To enforce secure traffic, port 80 must return an HTTP status code `301 Moved Permanently` directing users to the same path on `https://cic.local/`. This must be validated by checking response headers (`Location: https://cic.local...`).

2. **TLS Connection and Cipher Negotiation**:
   - *Observation*: The target environment is an enterprise production setup.
   - *Inference*: Legacy protocols (SSLv3, TLS 1.0, TLS 1.1) must be disabled. Only TLS 1.2 and TLS 1.3 should be negotiated. Verification must test connection attempts under each protocol version.
   - *Inference*: OpenSSL `s_client` and `curl -Iv` are robust tools to verify negotiation and confirm that the certificate matches the subject alternative name (SAN) `cic.local`.

3. **Zero-Downtime Verification**:
   - *Observation*: Certificates will rotate programmatically. Nginx must reload without dropping client traffic.
   - *Inference*: Nginx supports zero-downtime reloads via `SIGHUP` or `nginx -s reload`. When reloaded, Nginx gracefully handles existing connections while starting new workers with the updated configuration/certificates.
   - *Inference*: We can prove zero-downtime by running a continuous high-frequency connection loop (sending requests every 100ms) during the rotation. If 100% of requests succeed (HTTP 200) and the served certificate serial number changes, we have proven zero-downtime rotation.

4. **Mixed Content Elimination**:
   - *Observation*: If React Admin is served on `https://cic.local` but `VITE_API_URL` points to `http://localhost:80/api/v1`, browsers will block API calls due to Mixed Content policies.
   - *Inference*: The frontend must communicate via HTTPS. By configuring `VITE_API_URL` to a relative path `/api/v1`, the browser will automatically resolve requests using the current scheme and host (HTTPS and `cic.local`), resolving mixed content issues cleanly.

5. **Self-Signed Certificates and Testing**:
   - *Observation*: `cic.local` is a local domain and will use self-signed certificates.
   - *Inference*: Playwright and other HTTP clients will fail requests due to certificate validation errors. Playwright must be configured with `ignoreHTTPSErrors: true` to bypass these checks, and local developers must map `cic.local` in `hosts` and trust the Root CA.

6. **Go API Integrity**:
   - *Observation*: Go API resides behind Nginx SSL termination.
   - *Inference*: Go needs forwarding headers (`X-Forwarded-Proto`, `X-Forwarded-Host`) to know that the original request was HTTPS. This is crucial for Keycloak redirects, audit logs, and generating secure cookie contexts. Go API cookies must also be updated to set the `Secure` flag.

---

## 3. Caveats

- **Mock Certificates**: In local development, self-signed certificates are used. In a true production environment, Let's Encrypt or an enterprise CA (e.g., GCP Certificate Authority Service) would be integrated.
- **DNS Resolution**: The testing strategy assumes the hosts file (`/etc/hosts` or `C:\Windows\System32\drivers\etc\hosts`) has been modified to map `127.0.0.1 cic.local`. For automated E2E testing environments, DNS resolution can be bypassed using `curl --resolve` parameters or local DNS servers.
- **Source Code Alterations**: This strategy acts as a blueprint. Implementation is delegated to `worker_m3`. The verification tools are restricted to CODE_ONLY mode (local verification) and cannot use external TLS analysis APIs (like SSL Labs).

---

## 4. Conclusion

The SSL/TLS integration strategy requires configuring Nginx to listen on port 443 with TLS 1.2/1.3, forwarding protocol headers to the backend, enforcing HTTP-to-HTTPS redirects, and verifying zero-downtime reloading using serial-number checks during load simulation. Playwright tests and React Admin must be updated with HTTPS-aware environment properties (relative URLs and ignored certificate errors) to prevent browser Mixed Content failures.

---

## 5. Verification Method

Once the implementation is complete, execute the following manual and automated verification plans:

### A. Manual Verification Instructions

#### Test 1: Check Certificate Generation & Metadata
Verify that the certificates generated contain the correct subject and SAN:
```bash
# Verify certificate contents
openssl x509 -in certs/cic.local.crt -text -noout | grep -E "Subject:|DNS:|Not After"
```
*Expected Output:*
- `Subject: CN = cic.local`
- `DNS:cic.local, DNS:www.cic.local, IP:127.0.0.1`
- Expiration (`Not After`) matches the generation parameters.

#### Test 2: Verify HTTP to HTTPS Redirection
Send an HTTP request to the gateway and confirm it redirects to HTTPS:
```bash
curl -Iv -H "Host: cic.local" http://localhost/health
```
*Expected Output:*
- HTTP status: `301 Moved Permanently` (or `308 Permanent Redirect`).
- Header: `Location: https://cic.local/health`.

#### Test 3: Verify Secure TLS Handshake
Perform a TLS handshake and check connection negotiation:
```bash
curl -Iv -k --resolve cic.local:443:127.0.0.1 https://cic.local/health
```
*Expected Output:*
- TLS connection negotiated successfully.
- HTTP status `200 OK`.
- Response JSON: `{"status":"healthy"}`.

#### Test 4: Verify TLS Protocol Version Support
Verify that legacy TLS versions are blocked, while modern TLS versions are accepted:
```bash
# 1. TLS 1.3 (Should Succeed)
openssl s_client -connect 127.0.0.1:443 -servername cic.local -tls1_3 </dev/null

# 2. TLS 1.2 (Should Succeed)
openssl s_client -connect 127.0.0.1:443 -servername cic.local -tls1_2 </dev/null

# 3. TLS 1.1 (Should Fail/Be rejected)
openssl s_client -connect 127.0.0.1:443 -servername cic.local -tls1_1 </dev/null
```

#### Test 5: Verify HSTS Header
Verify that Nginx sends the Strict-Transport-Security header:
```bash
curl -sI -k --resolve cic.local:443:127.0.0.1 https://cic.local/ | grep -i "Strict-Transport-Security"
```
*Expected Output:*
- `Strict-Transport-Security: max-age=63072000; includeSubDomains; preload` (or similar).

---

### B. Automated Rotation and Zero-Downtime Verification

Use the following automated plan to verify that certificate rotation is zero-downtime:

#### Step 1: Start Active Traffic Simulator
Run this script in Terminal A to send continuous HTTPS requests:

*For Bash / Linux:*
```bash
#!/bin/bash
echo "Starting continuous traffic simulation..."
SUCCESS=0
FAILURE=0
for i in {1..200}; do
  STATUS=$(curl -s -o /dev/null -w "%{http_code}" -k --resolve cic.local:443:127.0.0.1 https://cic.local/health)
  if [ "$STATUS" -eq 200 ]; then
    SUCCESS=$((SUCCESS+1))
  else
    FAILURE=$((FAILURE+1))
    echo "Request failed with HTTP status: $STATUS"
  fi
  sleep 0.1
done
echo "Completed. Success: $SUCCESS, Failure: $FAILURE"
```

*For PowerShell / Windows:*
```powershell
Write-Output "Starting continuous traffic simulation..."
$success = 0
$failure = 0
[System.Net.ServicePointManager]::ServerCertificateValidationCallback = {$true}
for ($i = 1; $i -le 200; $i++) {
    try {
        $res = Invoke-WebRequest -Uri "https://127.0.0.1/health" -Headers @{Host="cic.local"} -UseBasicParsing -TimeoutSec 1
        if ($res.StatusCode -eq 200) { $success++ } else { $failure++ }
    } catch {
        $failure++
    }
    Start-Sleep -Milliseconds 100
}
Write-Output "Completed. Success: $success, Failure: $failure"
```

#### Step 2: Query Current Serial Number
In Terminal B, run:
```bash
openssl s_client -connect 127.0.0.1:443 -servername cic.local </dev/null 2>/dev/null | openssl x509 -noout -serial
```
Note the serial number (e.g. `serial=OLD_SERIAL`).

#### Step 3: Trigger Certificate Rotation & Reload
While the traffic simulator in Terminal A is running, execute the rotation script in Terminal B:
```bash
# Run rotation script
./prod-setup/nginx/rotate-certs.sh
```
Or manually:
```bash
# Validate config
docker exec cic-nginx nginx -t
# Reload config
docker exec cic-nginx nginx -s reload
```

#### Step 4: Verify Results
1. Check Terminal A: The script must output `Failure: 0`. Any failure indicates downtime occurred during the reload.
2. Query the new serial number in Terminal B:
   ```bash
   openssl s_client -connect 127.0.0.1:443 -servername cic.local </dev/null 2>/dev/null | openssl x509 -noout -serial
   ```
   Compare the output. The serial number **must be different** from `OLD_SERIAL`. This proves the new certificate was successfully reloaded and is active.
3. Check Nginx container logs:
   ```bash
   docker logs cic-nginx | grep -E "reload|signal"
   ```
   Verify Nginx successfully reloaded worker processes without errors.

---

### C. Go API & React Admin Integration Verification

#### Test 1: Verify Relative API URL in Frontend
Ensure that the React Admin built assets request the backend using a relative path rather than an absolute HTTP URL:
1. Open the browser's developer tools (F12) -> Network tab.
2. Navigate to `https://cic.local/`.
3. Verify that requests to `customers` or `users` go to `https://cic.local/api/v1/...` and do not fail with Mixed Content warnings in the console.

#### Test 2: Verify Proxy Header Forwarding
Add or inspect headers received by the Go API.
1. Run a request to the Go API through Nginx:
   ```bash
   curl -k --resolve cic.local:443:127.0.0.1 https://cic.local/health
   ```
2. Check Go API server logs. If header logging is enabled, verify the server receives:
   - `X-Forwarded-Proto: https`
   - `X-Forwarded-Host: cic.local`

#### Test 3: Verify Secure Cookies
Log in via the API using HTTPS:
```bash
curl -k -i -X POST -H "Content-Type: application/json" \
  -d '{"username":"admin","password":"password"}' \
  --resolve cic.local:443:127.0.0.1 \
  https://cic.local/api/auth/login
```
*Expected Output:*
- Inspect the `Set-Cookie` header in the response.
- It must contain the `Secure` attribute, ensuring the browser only transmits it over HTTPS.
- Example: `Set-Cookie: token=...; Path=/; Secure; HttpOnly; SameSite=Lax`

#### Test 4: Playwright E2E Integration Suite
To execute the automated E2E tests over HTTPS:
1. Open `e2e-tests/playwright.config.ts`.
2. Verify or update the configuration:
   ```typescript
   use: {
     baseURL: process.env.BASE_URL || 'https://cic.local',
     ignoreHTTPSErrors: true,
     trace: 'on-first-retry',
     screenshot: 'only-on-failure',
   }
   ```
3. Run the E2E tests:
   ```bash
   cd e2e-tests
   npm run test
   ```
   Confirm all tests pass under the HTTPS base URL.
