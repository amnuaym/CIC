$Env:PGPASSWORD = "veo;pMek"
docker run --rm -v "d:\GitHub\CIC\go\migrations:/migrations" --add-host=host.docker.internal:host-gateway -e PGPASSWORD=$Env:PGPASSWORD postgres:alpine psql -h host.docker.internal -U postgres -d cic_dev -f /migrations/000002_add_users_table.up.sql
