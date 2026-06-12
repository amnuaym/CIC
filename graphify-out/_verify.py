import urllib.request, json, ssl

ctx = ssl.create_default_context()
ctx.check_hostname = False
ctx.verify_mode = ssl.CERT_NONE

# Test preflight
req = urllib.request.Request("https://cic.local/api/auth/login", method="OPTIONS")
req.add_header("Origin", "https://cic.local")
req.add_header("Access-Control-Request-Method", "POST")
req.add_header("Access-Control-Request-Headers", "content-type")
resp = urllib.request.urlopen(req, context=ctx)
print(f"Preflight: {resp.status}")
for h in resp.getheaders():
    if "access-control" in h[0].lower():
        print(f"  {h[0]}: {h[1]}")

# Test actual login
data = json.dumps({"username": "superadmin", "password": "Super!Secret.2024"}).encode()
req2 = urllib.request.Request("https://cic.local/api/auth/login", data=data, method="POST")
req2.add_header("Content-Type", "application/json")
req2.add_header("Origin", "https://cic.local")
resp2 = urllib.request.urlopen(req2, context=ctx)
print(f"\nLogin: {resp2.status}")
for h in resp2.getheaders():
    if "access-control" in h[0].lower():
        print(f"  {h[0]}: {h[1]}")
print("OK - token received")
