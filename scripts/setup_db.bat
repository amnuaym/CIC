@echo off
echo Setting up CIC Database...

REM Prompt for Postgres superuser password
set /p PG_PASSWORD="Enter password for local 'postgres' user (leave empty for default 'postgres'): "
if "%PG_PASSWORD%"=="" set PG_PASSWORD=postgres

echo.
echo Configuration for New Application User
set /p APP_USER="Enter new database username (e.g., admin): "
set /p APP_PASSWORD="Enter new database password: "

if "%APP_USER%"=="" (
    echo Username cannot be empty. Exiting.
    exit /b 1
)
if "%APP_PASSWORD%"=="" (
    echo Password cannot be empty. Exiting.
    exit /b 1
)

echo.
echo 1. Creating Database and User...
REM Create Database cic_dev
docker run --rm -e PGPASSWORD=%PG_PASSWORD% postgres:alpine psql -h host.docker.internal -U postgres -c "CREATE DATABASE \"cic_dev\";"

REM Create User (ignore error if exists)
docker run --rm -e PGPASSWORD=%PG_PASSWORD% postgres:alpine psql -h host.docker.internal -U postgres -c "CREATE USER %APP_USER% WITH ENCRYPTED PASSWORD '%APP_PASSWORD%';"

REM Grant privileges
docker run --rm -e PGPASSWORD=%PG_PASSWORD% postgres:alpine psql -h host.docker.internal -U postgres -c "GRANT ALL PRIVILEGES ON DATABASE \"cic_dev\" TO %APP_USER%;"
docker run --rm -e PGPASSWORD=%PG_PASSWORD% postgres:alpine psql -h host.docker.internal -U postgres -d cic_dev -c "GRANT ALL ON SCHEMA public TO %APP_USER%;"

echo.
echo 2. Running Migrations...
REM Run migration script
docker run --rm -v "%cd%\go\migrations:/migrations" -e PGPASSWORD=%APP_PASSWORD% postgres:alpine psql -h host.docker.internal -U %APP_USER% -d cic_dev -f /migrations/000001_init_schema.up.sql

echo.
echo Database setup complete!
echo Please ensure your .env file matches:
echo POSTGRES_USER=%APP_USER%
echo POSTGRES_PASSWORD=%APP_PASSWORD%
echo.
pause
