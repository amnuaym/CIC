#!/bin/bash

# Customer Information Center (CIC) Quick Start Script
# This script helps you get started quickly with the CIC API

set -e

echo "🚀 Customer Information Center (CIC) Quick Start"
echo "==============================================="
echo ""

# Check if Docker is installed
if ! command -v docker &> /dev/null; then
    echo "❌ Docker is not installed. Please install Docker first."
    echo "Visit: https://docs.docker.com/get-docker/"
    exit 1
fi

# Check if Docker Compose is installed
if ! command -v docker-compose &> /dev/null; then
    echo "❌ Docker Compose is not installed. Please install Docker Compose first."
    echo "Visit: https://docs.docker.com/compose/install/"
    exit 1
fi

echo "✅ Docker and Docker Compose are installed"
echo ""

# Check if .env file exists
if [ ! -f .env ]; then
    echo "📝 Creating .env file from .env.example..."
    cp .env.example .env
    echo "✅ .env file created. You can customize it later."
else
    echo "✅ .env file already exists"
fi
echo ""

# Choose which services to start
echo "Which services would you like to start?"
echo "1) All services (Go CIC API + React Admin + Keycloak + Nginx)"
echo "2) CIC API stack (Go CIC API + React Admin + Nginx)"
echo "3) CIC API only (Go CIC API)"
echo ""
read -p "Enter your choice (1-3) [default: 1]: " choice
choice=${choice:-1}

case $choice in
    1)
        echo ""
        echo "🚀 Starting all services..."
        docker-compose up -d
        echo ""
        echo "✅ All services are starting!"
        echo ""
        echo "📍 Services:"
        echo "   - Go CIC API: http://localhost:8080"
        echo "   - Swagger Docs: http://localhost:8080/swagger/"
        echo "   - React Admin: http://localhost:3000 (via Nginx on port 80)"
        echo "   - Keycloak: http://localhost:8081"
        echo "   - Nginx Gateway: http://localhost:80"
        ;;
    2)
        echo ""
        echo "🚀 Starting CIC API stack..."
        docker-compose up -d cic-api react-admin nginx
        echo ""
        echo "✅ CIC API stack is starting!"
        echo ""
        echo "📍 Services:"
        echo "   - Go CIC API: http://localhost:8080"
        echo "   - Swagger Docs: http://localhost:8080/swagger/"
        echo "   - React Admin: http://localhost:3000 (via Nginx on port 80)"
        echo "   - Nginx Gateway: http://localhost:80"
        ;;
    3)
        echo ""
        echo "🚀 Starting CIC API..."
        docker-compose up -d cic-api
        echo ""
        echo "✅ CIC API is starting!"
        echo ""
        echo "📍 Services:"
        echo "   - Go CIC API: http://localhost:8080"
        echo "   - Swagger Docs: http://localhost:8080/swagger/"
        ;;
    *)
        echo "Invalid choice. Exiting."
        exit 1
        ;;
esac

echo ""
echo "⏳ Waiting for services to be ready..."
sleep 5

echo ""
echo "📊 Service status:"
docker-compose ps

echo ""
echo "✅ Setup complete!"
echo ""
echo "📚 Next steps:"
echo "   1. Check service logs: docker-compose logs -f"
echo "   2. Test API health: curl http://localhost:8080/health"
echo "   3. View Swagger docs: http://localhost:8080/swagger/"
echo "   4. Access React Admin: http://localhost:3000"
echo "   5. Read the docs: cat README.md"
echo "   6. See example API usage: cat documentation/user_journey.md"
echo ""
echo "🛑 To stop services: docker-compose down"
echo "🗑️  To remove all data: docker-compose down -v"
echo ""
echo "Welcome to CIC! 🛡️"
