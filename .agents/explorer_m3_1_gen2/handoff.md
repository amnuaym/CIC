# Handoff Report: Secure HTTPS Configuration for cic.local

This report contains findings, reasoning, and proposals for transitioning the Customer Information Center (CIC) local deployment from HTTP to a secure HTTPS configuration on port 443 under the domain `cic.local`.

---

## 1. Observation

Direct observations from the repository:

1. **Original Nginx Config (`nginx/nginx.conf`):**
   - Runs on port 80 only: `listen 80;` (line 10)
   - Performs reverse proxying via `http://` to backend services `cic-api` (Go API on port 8080) and `react-admin` (React Admin frontend on port 80).
   - Only `/swagger/` location passes `X-Forwarded-Proto $scheme;` (line 26), while other routes (`/health`, `/api/`, `/api/v1/`, `/`) do not.

2. **Original Compose Config (`docker-compose.yml`):**
   - Service `nginx` maps host port 80 to container port 80 (`"80:80"`, line 54) and mounts `./nginx/nginx.conf` directly. Port 443 is not exposed.
   - Service `react-admin` embeds `VITE_API_URL=http://localhost:80/api/v1` during build (`args`, line 26) and runtime environment (`environment`, line 30).
   - Service `keycloak` runs independently on host port 8081, bypassed by the Nginx reverse proxy.

3. **Frontend API URL Consumption (`react-admin/src/dataProvider.ts`):**
   - The React-Admin frontend relies on the environment variable `VITE_API_URL` to connect to the backend (line 4):
     `const API_URL = import.meta.env.VITE_API_URL || 'http://localhost:80/api/v1';`

4. **Go Backend Setup (`go/main.go`):**
   - Serves the API on port 8080 with CORS allowed origins set to `[]string{"*"}` (lines 57-62).

---

## 2. Logic Chain

The reasoning from observations to the proposed secure HTTPS configuration is as follows:

1. **Protocol Transition (Port 80 to 443):**
   - Nginx must listen on port 443 to accept secure incoming client traffic (Observation 1).
   - Exposure of port 443 must be added to the `nginx` service in `docker-compose.yml` (Observation 2).

2. **Certificate Management & Mounting:**
   - HTTPS requires SSL certificate and private key files.
   - We will mount `./prod-setup/nginx/certs` (containing `cic.local.crt` and `cic.local.key`) to `/etc/nginx/certs` inside the container.
   - The Nginx config will point to `/etc/nginx/certs/cic.local.crt` and `/etc/nginx/certs/cic.local.key`.

3. **SSL/TLS Hardening:**
   - To prevent insecure negotiation, SSL protocols are restricted to **TLSv1.2** and **TLSv1.3**.
   - Ciphers are explicitly hardened to strong ECDHE and DHE suites.
   - Session resumption settings (`ssl_session_cache` and `ssl_session_tickets`) are optimized for secure and efficient reconnection.
   - Critical security headers (HSTS, CSP, X-Frame-Options, X-Content-Type-Options) are injected to protect against clickjacking, MIME-sniffing, and cross-site scripting (XSS).

4. **API URL Alignment:**
   - Since Nginx will serve traffic over HTTPS on port 443, the client-side code running in the user's browser must query the API over HTTPS (Observation 3).
   - Thus, the build arg and environment variable `VITE_API_URL` in `docker-compose.yml` must be changed from `http://localhost:80/api/v1` to `https://cic.local/api/v1`.

5. **Redirect HTTP to HTTPS:**
   - To ensure no unencrypted traffic is served, a server block listening on port 80 will perform a permanent 301 redirect to `https://cic.local$request_uri`.

6. **Proxy Header Factoring:**
   - Factoring `proxy_set_header` directives (`Host`, `X-Real-IP`, `X-Forwarded-For`, `X-Forwarded-Proto`) into the `server` block level avoids duplicating configuration across location blocks and guarantees that `X-Forwarded-Proto` correctly tells downstream APIs the request was received over HTTPS.

---

## 3. Caveats

* **Certificate Lifecycle:** Generation/issuance of the SSL certificates (`cic.local.crt`, `cic.local.key`) is outside the scope of this config design. The certificates must be generated externally (e.g., using `mkcert` or OpenSSL) and placed in `./prod-setup/nginx/certs/` before starting Nginx.
* **DNS / Hosts Configuration:** A local hosts file mapping (`127.0.0.1 cic.local`) is required on the developer's machine to route requests to the docker container.
* **Production CORS Restrictions:** The Go API is currently configured with `*` for CORS. In actual production, it is recommended to restrict CORS origins exclusively to `https://cic.local`.

---

## 4. Conclusion

A secure Nginx and Docker configuration has been designed to support HTTPS for `cic.local`. 

### Proposed Nginx Configuration (`prod-setup/nginx/nginx.conf`)
```nginx
user  nginx;
worker_processes  auto;

error_log  /var/log/nginx/error.log notice;
pid        /var/run/nginx.pid;

events {
    worker_connections  1024;
}

http {
    include       /etc/nginx/mime.types;
    default_type  application/octet-stream;

    log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
                      '$status $body_bytes_sent "$http_referer" '
                      '"$http_user_agent" "$http_x_forwarded_for"';

    access_log  /var/log/nginx/access.log  main;

    sendfile        on;
    tcp_nopush      on;
    tcp_nodelay     on;
    keepalive_timeout  65;
    types_hash_max_size 2048;

    # Gzip Compression
    gzip on;
    gzip_disable "msie6";
    gzip_vary on;
    gzip_proxied any;
    gzip_comp_level 6;
    gzip_buffers 16 8k;
    gzip_http_version 1.1;
    gzip_types text/plain text/css application/json application/javascript text/xml application/xml application/xml+rss text/javascript;

    # SSL / TLS Hardening Settings
    ssl_protocols TLSv1.2 TLSv1.3;
    ssl_prefer_server_ciphers off;
    ssl_ciphers ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-CHACHA20-POLY1305:DHE-RSA-AES128-GCM-SHA256:DHE-RSA-AES256-GCM-SHA384;

    # Session Cache Settings
    ssl_session_cache shared:SSL:10m;
    ssl_session_timeout 1d;
    ssl_session_tickets off;

    # DH Parameter (Optional but recommended for TLS 1.2 DHE ciphers)
    # Generate using: openssl dhparam -out /etc/nginx/certs/dhparam.pem 2048
    # ssl_dhparam /etc/nginx/certs/dhparam.pem;

    # HTTP Server (Redirect port 80 to 443 over HTTPS)
    server {
        listen 80;
        listen [::]:80;
        server_name cic.local localhost;

        return 301 https://$host$request_uri;
    }

    # HTTPS Server (Port 443 with Hardened SSL/TLS)
    server {
        listen 443 ssl http2;
        listen [::]:443 ssl http2;
        server_name cic.local localhost;

        # Certificate Files
        ssl_certificate /etc/nginx/certs/cic.local.crt;
        ssl_certificate_key /etc/nginx/certs/cic.local.key;

        # Security Headers
        add_header Strict-Transport-Security "max-age=63072000; includeSubDomains; preload" always;
        add_header X-Frame-Options "SAMEORIGIN" always;
        add_header X-Content-Type-Options "nosniff" always;
        add_header X-XSS-Protection "1; mode=block" always;
        add_header Referrer-Policy "strict-origin-when-cross-origin" always;
        add_header Content-Security-Policy "default-src 'self' http: https: data: blob: 'unsafe-inline'; frame-ancestors 'self';" always;

        # Proxy Headers Configuration (Inherited by all location blocks)
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;

        # Health Check
        location /health {
            proxy_pass http://cic-api:8080/health;
        }

        # Swagger UI
        location /swagger/ {
            proxy_pass http://cic-api:8080/swagger/;
        }

        # Auth & General API
        location /api/ {
            proxy_pass http://cic-api:8080/api/;
        }

        # API Gateway (v1 specific)
        location /api/v1/ {
            proxy_pass http://cic-api:8080/api/v1/;
        }

        # Frontend
        location / {
            proxy_pass http://react-admin:80/;
        }
    }
}
```

### Proposed `docker-compose.yml` Modifications

```yaml
version: '3.8'

services:
  cic-api:
    build:
      context: ./go
      dockerfile: Dockerfile
    container_name: cic-api
    environment:
      # Use host.docker.internal to connect to local Postgres
      DATABASE_URL: postgres://${POSTGRES_USER}:${POSTGRES_PASSWORD}@host.docker.internal:5432/${POSTGRES_DB:-cic_dev}?sslmode=disable
      PORT: 8080
      JWT_SECRET: ${JWT_SECRET:-your-secret-key-change-in-production}
    ports:
      - "8080:8080"
    extra_hosts:
      - "host.docker.internal:host-gateway"
    networks:
      - cic-network

  react-admin:
    build:
      context: ./react-admin
      dockerfile: Dockerfile
      args:
        - VITE_API_URL=https://cic.local/api/v1
    container_name: cic-react-admin
    environment:
      # API URL accessed by browser -> Gateway (https://cic.local:443) -> Nginx -> cic-api
      VITE_API_URL: https://cic.local/api/v1
    ports:
      - "3000:80"
    networks:
      - cic-network

  keycloak:
    image: quay.io/keycloak/keycloak:23.0
    container_name: cic-keycloak
    environment:
      KEYCLOAK_ADMIN: admin
      KEYCLOAK_ADMIN_PASSWORD: admin
    command: start-dev
    ports:
      - "8081:8080"
    networks:
      - cic-network

  nginx:
    image: nginx:alpine
    container_name: cic-nginx
    volumes:
      - ./prod-setup/nginx/nginx.conf:/etc/nginx/nginx.conf:ro
      - ./prod-setup/nginx/certs:/etc/nginx/certs:ro
    ports:
      - "80:80"
      - "443:443"
    depends_on:
      - cic-api
      - react-admin
    networks:
      - cic-network

networks:
  cic-network:
    driver: bridge
```

---

## 5. Verification Method

### 1. Nginx Config Syntax Test
You can test the Nginx configuration syntax directly using docker without starting up the entire cluster:
```powershell
docker run --rm `
  -v "${PWD}/.agents/explorer_m3_1_gen2/proposed_nginx.conf:/etc/nginx/nginx.conf:ro" `
  -v "${PWD}/.agents/explorer_m3_1_gen2:/etc/nginx/certs:ro" `
  nginx:alpine nginx -t -c /etc/nginx/nginx.conf
```
*(Note: To make this test pass, dummy `cic.local.crt` and `cic.local.key` files must exist in the mounted certs directory. Since we have dummy files, the configuration validator will succeed).*

### 2. Runtime Verification Steps
1. **Generate Certificates locally:**
   ```powershell
   mkdir -p prod-setup/nginx/certs
   # Using mkcert (recommended for trusted local certs)
   mkcert -install
   mkcert -cert-file prod-setup/nginx/certs/cic.local.crt -key-file prod-setup/nginx/certs/cic.local.key cic.local localhost 127.0.0.1
   ```
2. **Apply Configuration Files:**
   - Write the proposed `nginx.conf` to `prod-setup/nginx/nginx.conf`.
   - Update `docker-compose.yml` with the proposed content.
3. **Map Domain:**
   - Add `127.0.0.1 cic.local` to your local `hosts` file (`C:\Windows\System32\drivers\etc\hosts`).
4. **Boot up services:**
   - Run `docker-compose up --build -d`.
5. **Verify HTTP to HTTPS redirection:**
   - Run `curl -I http://cic.local/` (Expect `HTTP/1.1 301 Moved Permanently` to `https://cic.local/`).
6. **Verify HTTPS connection & Headers:**
   - Run `curl -k -I https://cic.local/` (Expect `HTTP/1.1 200 OK` and security headers like `Strict-Transport-Security` to be present).
7. **Verify TLS Versions:**
   - Run `openssl s_client -connect cic.local:443 -tls1_3` to ensure TLS 1.3 works.
   - Run `openssl s_client -connect cic.local:443 -tls1_2` to ensure TLS 1.2 works.
