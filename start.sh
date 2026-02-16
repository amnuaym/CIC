#!/bin/bash

# Backend Template Quick Start Script
# This script helps you get started quickly with the Backend Template

set -e

echo "🚀 Backend Template Quick Start"
echo "================================"
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
echo "1) All services (Go API + TypeScript API + React Admin + PostgreSQL)"
echo "2) TypeScript stack (TypeScript API + React Admin + PostgreSQL)"
echo "3) Go stack (Go API + PostgreSQL)"
echo "4) Just PostgreSQL"
echo ""
read -p "Enter your choice (1-4) [default: 1]: " choice
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
        echo "   - PostgreSQL: localhost:5432"
        echo "   - Go API: http://localhost:8080"
        echo "   - TypeScript API: http://localhost:3000"
        echo "   - React Admin: http://localhost:3001"
        ;;
    2)
        echo ""
        echo "🚀 Starting TypeScript stack..."
        docker-compose up -d postgres ts-api react-admin
        echo ""
        echo "✅ TypeScript stack is starting!"
        echo ""
        echo "📍 Services:"
        echo "   - PostgreSQL: localhost:5432"
        echo "   - TypeScript API: http://localhost:3000"
        echo "   - React Admin: http://localhost:3001"
        ;;
    3)
        echo ""
        echo "🚀 Starting Go stack..."
        docker-compose up -d postgres go-api
        echo ""
        echo "✅ Go stack is starting!"
        echo ""
        echo "📍 Services:"
        echo "   - PostgreSQL: localhost:5432"
        echo "   - Go API: http://localhost:8080"
        ;;
    4)
        echo ""
        echo "🚀 Starting PostgreSQL..."
        docker-compose up -d postgres
        echo ""
        echo "✅ PostgreSQL is starting!"
        echo ""
        echo "📍 Services:"
        echo "   - PostgreSQL: localhost:5432"
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
echo "   2. Test API: curl http://localhost:3000/health"
echo "   3. Access React Admin: http://localhost:3001"
echo "   4. Read the docs: cat README.md"
echo ""
echo "🛑 To stop services: docker-compose down"
echo "🗑️  To remove all data: docker-compose down -v"
echo ""
echo "Happy coding! 🎉"
