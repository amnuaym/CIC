# Backend Application Template

A comprehensive backend application template supporting both **Go** and **TypeScript**, with PostgreSQL database, React Admin dashboard, and complete testing infrastructure.

## 🚀 Features

- **Multiple Backend Options**
  - Go backend with Gorilla Mux
  - TypeScript backend with Express
- **Database**
  - PostgreSQL with pre-configured schema
  - Connection pooling and migrations
- **Authentication**
  - JWT token authentication
  - API Key authentication (certificate-based)
  - OAuth support (Google example provided)
  - Password hashing with bcrypt
- **Admin Dashboard**
  - React Admin with Material-UI
  - Full CRUD operations
  - Authentication integration
- **Testing**
  - Unit tests for both backends
  - End-to-end tests with Playwright
- **DevOps**
  - Docker and Docker Compose setup
  - GitHub Actions CI/CD pipeline
  - Multi-stage Docker builds
- **Security**
  - CORS configuration
  - Helmet security headers (TypeScript)
  - Environment-based configuration
  - Secure password storage

## 📋 Table of Contents

- [Quick Start](#quick-start)
- [Project Structure](#project-structure)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Running with Docker](#running-with-docker)
- [Development](#development)
- [Testing](#testing)
- [API Documentation](#api-documentation)
- [Configuration](#configuration)
- [Deployment](#deployment)
- [Contributing](#contributing)
- [License](#license)

## ⚡ Quick Start

### Using Docker (Recommended)

1. Clone the repository:
```bash
git clone https://github.com/amnuaym/BE-Template.git
cd BE-Template
```

2. Copy and configure environment variables:
```bash
cp .env.example .env
# Edit .env with your configuration
```

3. Start all services:
```bash
docker-compose up
```

This will start:
- PostgreSQL database on port 5432
- Go API on port 8080
- TypeScript API on port 3000
- React Admin on port 3001

### Manual Setup

See individual README files in each directory:
- [Go Backend](./go/README.md)
- [TypeScript Backend](./typescript/README.md)
- [React Admin](./react-admin/README.md)
- [E2E Tests](./e2e-tests/README.md)

## 📁 Project Structure

```
BE-Template/
├── .github/
│   └── workflows/
│       └── ci-cd.yml           # GitHub Actions workflow
├── go/                          # Go backend application
│   ├── internal/
│   │   ├── api/                # API handlers
│   │   ├── auth/               # Authentication logic
│   │   ├── database/           # Database connection
│   │   ├── middleware/         # HTTP middleware
│   │   └── models/             # Data models
│   ├── main.go                 # Entry point
│   ├── Dockerfile
│   └── README.md
├── typescript/                  # TypeScript backend application
│   ├── src/
│   │   ├── config/             # Configuration
│   │   ├── controllers/        # Request handlers
│   │   ├── middleware/         # Express middleware
│   │   ├── routes/             # API routes
│   │   ├── types/              # TypeScript types
│   │   └── utils/              # Utility functions
│   ├── __tests__/              # Unit tests
│   ├── Dockerfile
│   └── README.md
├── react-admin/                 # React Admin dashboard
│   ├── src/
│   │   ├── resources/          # Resource components
│   │   ├── App.tsx             # Main app
│   │   ├── authProvider.ts     # Auth logic
│   │   └── dataProvider.ts     # Data fetching
│   ├── Dockerfile
│   └── README.md
├── e2e-tests/                   # End-to-end tests
│   ├── tests/
│   │   ├── api.spec.ts         # API tests
│   │   └── admin.spec.ts       # UI tests
│   ├── playwright.config.ts
│   └── README.md
├── scripts/
│   └── init-db.sql             # Database initialization
├── docker-compose.yml           # Docker Compose configuration
├── .env.example                 # Environment variables template
└── README.md                    # This file
```

## 🔧 Prerequisites

- **For Docker Setup:**
  - Docker 20.10+
  - Docker Compose 2.0+

- **For Manual Setup:**
  - Go 1.21+
  - Node.js 18+
  - PostgreSQL 15+
  - npm or yarn

## 📦 Installation

### Docker Installation (Recommended)

```bash
# Clone the repository
git clone https://github.com/amnuaym/BE-Template.git
cd BE-Template

# Copy environment variables
cp .env.example .env

# Start services
docker-compose up -d

# View logs
docker-compose logs -f
```

### Manual Installation

#### 1. Database Setup

```bash
# Install PostgreSQL 15
# Ubuntu/Debian:
sudo apt-get install postgresql-15

# macOS:
brew install postgresql@15

# Start PostgreSQL
sudo service postgresql start  # Linux
brew services start postgresql@15  # macOS

# Create database and user
createdb template_db
psql template_db < scripts/init-db.sql
```

#### 2. Go Backend

```bash
cd go
go mod download
go run main.go
```

#### 3. TypeScript Backend

```bash
cd typescript
npm install
npm run dev
```

#### 4. React Admin

```bash
cd react-admin
npm install
npm run dev
```

## 🐳 Running with Docker

### Start All Services

```bash
docker-compose up
```

### Start Specific Service

```bash
# Only PostgreSQL and Go API
docker-compose up postgres go-api

# Only PostgreSQL and TypeScript API
docker-compose up postgres ts-api

# Only PostgreSQL, TypeScript API, and React Admin
docker-compose up postgres ts-api react-admin
```

### Rebuild Images

```bash
docker-compose build
docker-compose up
```

### View Logs

```bash
# All services
docker-compose logs -f

# Specific service
docker-compose logs -f ts-api
```

### Stop Services

```bash
docker-compose down

# Remove volumes (database data)
docker-compose down -v
```

## 💻 Development

### Go Backend Development

```bash
cd go
go run main.go
```

See [Go README](./go/README.md) for detailed information.

### TypeScript Backend Development

```bash
cd typescript
npm run dev  # Hot reload enabled
```

See [TypeScript README](./typescript/README.md) for detailed information.

### React Admin Development

```bash
cd react-admin
npm run dev
```

See [React Admin README](./react-admin/README.md) for detailed information.

## 🧪 Testing

### Unit Tests

**Go:**
```bash
cd go
go test ./...
go test -cover ./...
```

**TypeScript:**
```bash
cd typescript
npm test
npm run test:coverage
```

### End-to-End Tests

```bash
cd e2e-tests
npm install
npx playwright install
npm test
```

See [E2E Tests README](./e2e-tests/README.md) for detailed information.

### Running All Tests

```bash
# Go tests
(cd go && go test ./...)

# TypeScript tests
(cd typescript && npm test)

# E2E tests (requires running services)
(cd e2e-tests && npm test)
```

## 📚 API Documentation

### Authentication Endpoints

#### Register
```http
POST /api/auth/register
Content-Type: application/json

{
  "email": "user@example.com",
  "username": "username",
  "password": "password123"
}
```

#### Login
```http
POST /api/auth/login
Content-Type: application/json

{
  "username": "username",
  "password": "password123"
}
```

Response:
```json
{
  "token": "jwt_token_here",
  "user": {
    "id": "uuid",
    "email": "user@example.com",
    "username": "username"
  }
}
```

### Protected Endpoints

Include JWT token in Authorization header:
```http
GET /api/posts
Authorization: Bearer <jwt_token>
```

Or use API Key:
```http
GET /api/v1/posts
X-API-Key: <api_key>
```

### Available Endpoints

| Method | Endpoint | Auth | Description |
|--------|----------|------|-------------|
| GET | /health | None | Health check |
| POST | /api/auth/register | None | Register new user |
| POST | /api/auth/login | None | Login user |
| GET | /api/users/me | JWT | Get current user |
| GET | /api/posts | JWT | List all posts |
| POST | /api/posts | JWT | Create new post |
| GET | /api/posts/:id | JWT | Get specific post |
| PUT | /api/posts/:id | JWT | Update post |
| DELETE | /api/posts/:id | JWT | Delete post |
| GET | /api/v1/posts | API Key | List posts (API key) |

## ⚙️ Configuration

### Environment Variables

Copy `.env.example` to `.env` and configure:

```bash
# Database
POSTGRES_USER=admin
POSTGRES_PASSWORD=admin123
POSTGRES_DB=template_db
POSTGRES_HOST=localhost
POSTGRES_PORT=5432

# API Ports
GO_API_PORT=8080
TS_API_PORT=3000
REACT_ADMIN_PORT=3001

# JWT Secret (CHANGE IN PRODUCTION!)
JWT_SECRET=your-secret-key-change-in-production

# OAuth (Optional)
OAUTH_CLIENT_ID=your-client-id
OAUTH_CLIENT_SECRET=your-client-secret
OAUTH_REDIRECT_URL=http://localhost:3000/auth/callback

# React Admin
REACT_APP_API_URL=http://localhost:3000
```

### Database Schema

The database schema is automatically initialized from `scripts/init-db.sql`:

- `users` - User accounts
- `roles` - User roles
- `user_roles` - User-role relationships
- `api_keys` - API keys for authentication
- `sessions` - User sessions
- `posts` - Example content table

## 🚀 Deployment

### Docker Deployment

```bash
# Build production images
docker-compose build

# Deploy to your server
docker-compose -f docker-compose.yml up -d
```

### Manual Deployment

1. **Build Go Backend:**
```bash
cd go
CGO_ENABLED=0 go build -o api .
./api
```

2. **Build TypeScript Backend:**
```bash
cd typescript
npm run build
npm start
```

3. **Build React Admin:**
```bash
cd react-admin
npm run build
# Serve dist/ directory with nginx or similar
```

### Environment-Specific Configuration

Create separate `.env` files for different environments:
- `.env.development`
- `.env.staging`
- `.env.production`

### Security Considerations

⚠️ **Before deploying to production:**

1. Change JWT_SECRET to a strong random value
2. Use strong database passwords
3. Enable SSL/TLS for database connections
4. Configure proper CORS origins
5. Use HTTPS for all endpoints
6. Implement rate limiting
7. Set up monitoring and logging
8. Regular security audits
9. Keep dependencies updated

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch: `git checkout -b feature-name`
3. Make your changes
4. Run tests: `npm test` or `go test ./...`
5. Commit: `git commit -am 'Add feature'`
6. Push: `git push origin feature-name`
7. Create a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- [Go](https://golang.org/)
- [TypeScript](https://www.typescriptlang.org/)
- [Express](https://expressjs.com/)
- [React Admin](https://marmelab.com/react-admin/)
- [Playwright](https://playwright.dev/)
- [PostgreSQL](https://www.postgresql.org/)

## 📞 Support

For issues, questions, or contributions, please open an issue on GitHub.

---

**Happy Coding! 🎉**
