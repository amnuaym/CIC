#!/bin/bash
# CAS Database Deployment Quick Start
# This script automates the deployment of the CAS PostgreSQL database
# 
# Usage: bash deploy_cas.sh
# Or on Windows: Open Command Prompt and run the PowerShell equivalent below

# Color output (optional)
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Configuration
DB_USER="${DB_USER:-postgres}"
DB_HOST="${DB_HOST:-localhost}"
DB_PORT="${DB_PORT:-5432}"
SCRIPT_DIR="scripts/generated"
DEPLOY_SCRIPT="$SCRIPT_DIR/deploy_cas_full.sql"
VALIDATE_SCRIPT="$SCRIPT_DIR/validate_cas_deployment.sql"

echo "╔═══════════════════════════════════════════════════════════════╗"
echo "║          CAS Oracle-to-PostgreSQL Database Deployment        ║"
echo "╚═══════════════════════════════════════════════════════════════╝"
echo ""

# Check if deploy script exists
if [ ! -f "$DEPLOY_SCRIPT" ]; then
    echo -e "${RED}ERROR${NC}: Deploy script not found: $DEPLOY_SCRIPT"
    echo "Make sure you're running this from the CIC repository root directory"
    exit 1
fi

echo "Configuration:"
echo "  PostgreSQL User: $DB_USER"
echo "  PostgreSQL Host: $DB_HOST"
echo "  PostgreSQL Port: $DB_PORT"
echo "  Deployment Script: $DEPLOY_SCRIPT"
echo ""

# Confirm deployment
read -p "Deploy CAS database to PostgreSQL? (yes/no): " -r
echo
if [[ ! $REPLY =~ ^[Yy][Ee][Ss]$ ]]; then
    echo "Deployment cancelled."
    exit 0
fi

echo -e "${YELLOW}Starting deployment...${NC}"
echo ""

# Run the main deployment script
if psql -U "$DB_USER" -h "$DB_HOST" -p "$DB_PORT" -f "$DEPLOY_SCRIPT"; then
    echo ""
    echo -e "${GREEN}✓ Deployment script executed successfully!${NC}"
    echo ""
    
    # Ask if user wants to run validation
    read -p "Run validation queries now? (yes/no): " -r
    echo
    if [[ $REPLY =~ ^[Yy][Ee][Ss]$ ]]; then
        echo -e "${YELLOW}Running validation...${NC}"
        echo ""
        
        if psql -U "$DB_USER" -h "$DB_HOST" -p "$DB_PORT" -d cas_db -f "$VALIDATE_SCRIPT"; then
            echo ""
            echo -e "${GREEN}✓ Validation complete!${NC}"
            echo ""
            echo "Next steps:"
            echo "  1. Review validation output above"
            echo "  2. Update application connection strings to PostgreSQL"
            echo "  3. Test application functionality"
            echo "  4. Monitor oracle_migration_backlog table for remaining work"
            echo ""
        else
            echo -e "${RED}✗ Validation failed${NC}"
            exit 1
        fi
    else
        echo "Validation skipped. Run it manually with:"
        echo "  psql -U $DB_USER -d cas_db -f $VALIDATE_SCRIPT"
        echo ""
    fi
    
    echo "Connect to the database with:"
    echo "  psql -U $DB_USER -h $DB_HOST -p $DB_PORT -d cas_db"
    echo ""
else
    echo ""
    echo -e "${RED}✗ Deployment failed!${NC}"
    echo ""
    echo "Troubleshooting:"
    echo "  1. Check PostgreSQL is running and accessible"
    echo "  2. Verify PostgreSQL user/password is correct"
    echo "  3. Review error messages above"
    echo ""
    exit 1
fi
