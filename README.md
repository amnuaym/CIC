# Customer Information Center (CIC) API

A comprehensive Customer Information Center (CIC) API built with **Go** and **TypeScript**, featuring PostgreSQL database, React Admin dashboard, and complete testing infrastructure. The CIC API provides robust customer data management with support for personal and juristic customers, PDPA compliance, and relationship tracking.

## 🚀 Features

### Customer Management
- **Dual Customer Types**
  - Personal customers with individual details
  - Juristic customers for business entities
- **Customer Lifecycle Management**
  - Create, read, update customers
  - Search and filter capabilities
  - Customer anonymization (PDPA right to be forgotten)
  - Status tracking (Active, Inactive, Suspended, Deceased, Blacklisted)

### Sub-Resources
- **Addresses**: Registered, mailing, and headquarters addresses
- **Identity Documents**: National ID, Passport, Tax ID with expiry tracking
- **Relationships**: Link customers (e.g., Director, Shareholder, Authorized Person)
- **PDPA Consents**: Version-controlled consent management

### Technical Features
- **Multiple Backend Options**
  - Go backend with Gorilla Mux and hexagonal architecture
  - TypeScript backend with Express
- **Database**
  - PostgreSQL with normalized schema
  - Audit trail for compliance
  - Connection pooling and transactions
- **Authentication**
  - JWT token authentication
  - API Key authentication
  - OAuth support (Google, Keycloak integration)
  - Password hashing with bcrypt
- **Admin Dashboard**
  - React Admin with Material-UI
  - Customer CRUD operations with sub-resources
  - User and post management
  - Authentication integration
- **API Documentation**
  - Swagger/OpenAPI documentation at `/swagger/`
- **Testing**
  - Unit tests for both backends
  - End-to-end tests with Playwright
- **DevOps**
  - Docker and Docker Compose setup
  - Nginx reverse proxy
  - Multi-stage Docker builds
- **Security & Compliance**
  - PDPA compliance with anonymization
  - CORS configuration
  - Secure password storage
  - Environment-based configuration

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
git clone https://github.com/amnuaym/CIC.git
cd CIC
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
- PostgreSQL database on port 5432 (if running locally)
- Go API on port 8080
- (Optional) TypeScript API (manual setup, not started by docker-compose; see ./typescript/README.md)
- React Admin on port 3000 (via nginx on port 80)
- Keycloak on port 8081 (for OAuth)
- Nginx reverse proxy on port 80

### Manual Setup

See individual README files in each directory:
- [Go Backend](./go/README.md)
- [TypeScript Backend](./typescript/README.md)
- [React Admin](./react-admin/README.md)
- [E2E Tests](./e2e-tests/README.md)

## 📁 Project Structure

```
CIC/
├── .github/
│   └── workflows/           # GitHub Actions CI/CD workflows
├── documentation/
│   ├── project_overview.md  # Detailed project documentation
│   └── user_journey.md      # API usage examples and scenarios
├── go/                      # Go backend application (CIC API)
│   ├── docs/                # Swagger documentation
│   ├── internal/
│   │   ├── adapter/
│   │   │   ├── handler/     # HTTP handlers (customer, etc.)
│   │   │   └── repository/  # Database repositories
│   │   ├── api/             # Legacy API handlers
│   │   ├── auth/            # Authentication logic
│   │   ├── core/
│   │   │   ├── domain/      # Domain models (Customer, Address, etc.)
│   │   │   ├── ports/       # Service & repository interfaces
│   │   │   └── service/     # Business logic services
│   │   ├── database/        # Database connection
│   │   ├── middleware/      # HTTP middleware
│   │   └── models/          # Data models
│   ├── main.go              # Entry point
│   ├── Dockerfile
│   └── README.md
├── typescript/              # TypeScript backend application (optional)
│   ├── src/
│   │   ├── config/          # Configuration
│   │   ├── controllers/     # Request handlers
│   │   ├── middleware/      # Express middleware
│   │   ├── routes/          # API routes
│   │   ├── types/           # TypeScript types
│   │   └── utils/           # Utility functions
│   ├── __tests__/           # Unit tests
│   ├── Dockerfile
│   └── README.md
├── react-admin/             # React Admin dashboard
│   ├── src/
│   │   ├── resources/
│   │   │   ├── customers/   # Customer management UI
│   │   │   │   └── components/  # Address, Identity, Relationship, Consent components
│   │   │   ├── posts.tsx    # Posts resource
│   │   │   └── users.tsx    # Users resource
│   │   ├── App.tsx          # Main app
│   │   ├── authProvider.ts  # Auth logic
│   │   └── dataProvider.ts  # Data fetching
│   ├── Dockerfile
│   └── README.md
├── e2e-tests/               # End-to-end tests
│   ├── tests/
│   │   ├── api.spec.ts      # API tests
│   │   └── admin.spec.ts    # UI tests
│   ├── playwright.config.ts
│   └── README.md
├── nginx/
│   └── nginx.conf           # Nginx reverse proxy configuration
├── scripts/
│   ├── init-db.sql          # Database initialization
│   ├── setup_db.bat         # Windows DB setup
│   └── test_journey.ps1     # Automated API testing script
├── docker-compose.yml       # Docker Compose configuration
├── start.sh                 # Quick start script
├── .env.example             # Environment variables template
├── CONTRIBUTING.md          # Contribution guidelines
└── README.md                # This file
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
git clone https://github.com/amnuaym/CIC.git
cd CIC

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
createdb cic
psql cic < scripts/init-db.sql
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
# Go API with Nginx
docker-compose up cic-api nginx

# React Admin with Nginx
docker-compose up react-admin nginx

# With Keycloak for OAuth testing
docker-compose up cic-api react-admin keycloak nginx
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
docker-compose logs -f cic-api
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

Full API documentation is available via Swagger UI at `http://localhost:8080/swagger/` when the Go API is running.

### Quick Reference

For detailed examples and complete user journey scenarios, see [User Journey Documentation](./documentation/user_journey.md).

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

### CIC Customer Endpoints

All customer endpoints are under `/api/v1` prefix.

#### Create Customer
```http
POST /api/v1/customers
Content-Type: application/json

{
  "type": "PERSONAL",
  "first_name": "John",
  "last_name": "Doe",
  "title": "Mr.",
  "status": "ACTIVE",
  "date_of_birth": "1990-01-01T00:00:00Z",
  "nationality": "Thai"
}
```

#### Add Customer Address
```http
POST /api/v1/customers/{id}/addresses
Content-Type: application/json

{
  "type": "Registered",
  "address_line1": "123 Main Street",
  "city": "Bangkok",
  "zip_code": "10110",
  "country": "Thailand"
}
```

#### Add Identity Document
```http
POST /api/v1/customers/{id}/identities
Content-Type: application/json

{
  "type": "National ID",
  "number": "1-2345-67890-12-3",
  "issuance_country": "Thailand",
  "expiry_date": "2030-12-31T00:00:00Z"
}
```

#### Manage PDPA Consent
```http
POST /api/v1/customers/{id}/consents
Content-Type: application/json

{
  "topic": "Marketing",
  "version": "1.0",
  "is_granted": true
}
```

#### Anonymize Customer (PDPA Right to be Forgotten)
```http
POST /api/v1/customers/{id}/anonymize
```

### Available Endpoints

| Method | Endpoint | Description |
|--------|----------|-------------|
| **Health & Auth** |
| GET | /health | Health check |
| POST | /api/auth/register | Register new user |
| POST | /api/auth/login | Login user |
| GET | /api/auth/oauth/google | OAuth Google login |
| GET | /api/auth/oauth/callback | OAuth callback |
| **User Management** |
| GET | /api/users/me | Get current user (JWT) |
| **Legacy Posts** |
| GET | /api/posts | List all posts (JWT) |
| POST | /api/posts | Create new post (JWT) |
| GET | /api/posts/:id | Get specific post (JWT) |
| PUT | /api/posts/:id | Update post (JWT) |
| DELETE | /api/posts/:id | Delete post (JWT) |
| GET | /api/v1/posts | List posts (API Key) |
| **CIC Customers** |
| POST | /api/v1/customers | Create customer |
| GET | /api/v1/customers/search | Search customers |
| GET | /api/v1/customers/{id} | Get customer |
| PATCH/PUT | /api/v1/customers/{id} | Update customer |
| POST | /api/v1/customers/{id}/anonymize | Anonymize customer (PDPA) |
| **Customer Sub-Resources** |
| POST | /api/v1/customers/{id}/addresses | Add address |
| GET | /api/v1/customers/{id}/addresses | Get addresses |
| POST | /api/v1/customers/{id}/identities | Add identity |
| GET | /api/v1/customers/{id}/identities | Get identities |
| POST | /api/v1/customers/{id}/relationships | Add relationship |
| GET | /api/v1/customers/{id}/relationships | Get relationships |
| POST | /api/v1/customers/{id}/consents | Manage consent |
| GET | /api/v1/customers/{id}/consents | Get consents |

## ⚙️ Configuration

### Environment Variables

Copy `.env.example` to `.env` and configure:

```bash
# Database
POSTGRES_USER=postgres
POSTGRES_PASSWORD=your-secure-password
POSTGRES_DB=cic
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
OAUTH_PROVIDER=google

# React Admin
REACT_APP_API_URL=http://localhost:3000
# Or for Docker setup with Nginx:
VITE_API_URL=http://localhost:80/api/v1
```

### Database Schema

The database schema is automatically initialized from `scripts/init-db.sql`:

#### Authentication & User Management
- `users` - User accounts with OAuth support
- `roles` - User roles (admin, user)
- `user_roles` - User-role relationships
- `api_keys` - API keys for authentication
- `sessions` - User sessions
- `posts` - Example content table (legacy)

#### CIC Domain (Managed in Go application)
- `customers` - Personal and juristic customer records
- `addresses` - Customer addresses (registered, mailing, HQ)
- `identities` - Identity documents (National ID, Passport, Tax ID)
- `relationships` - Customer relationships (Director, Shareholder, etc.)
- `consents` - PDPA consent records
- `audit_log` - Audit trail for compliance

> **Note**: CIC domain tables are created and managed by the Go application using its repository layer, not in `init-db.sql`.

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
CGO_ENABLED=0 go build -o cic-api .
./cic-api
```

2. **Build React Admin:**
```bash
cd react-admin
npm run build
# Serve dist/ directory with nginx or similar
```

3. **Optional - Build TypeScript Backend:**
```bash
cd typescript
npm run build
npm start
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
10. Review PDPA compliance requirements
11. Configure proper audit logging
12. Secure customer data at rest and in transit

## 🤝 Contributing

We welcome contributions! Please see our [Contributing Guidelines](CONTRIBUTING.md) for detailed information.

Quick steps:
1. Fork the repository
2. Create a feature branch: `git checkout -b feature-name`
3. Make your changes
4. Run tests: `go test ./...` (Go) or `npm test` (TypeScript/React)
5. Commit: `git commit -am 'Add feature'`
6. Push: `git push origin feature-name`
7. Create a Pull Request

## 📄 License

This project is licensed under the GNU General Public License v3.0 - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

### Technologies
- [Go](https://golang.org/) - Primary backend language
- [Gorilla Mux](https://github.com/gorilla/mux) - HTTP routing
- [PostgreSQL](https://www.postgresql.org/) - Database
- [React Admin](https://marmelab.com/react-admin/) - Admin dashboard framework
- [Material-UI](https://mui.com/) - UI components
- [TypeScript](https://www.typescriptlang.org/) - Type-safe development
- [Express](https://expressjs.com/) - Alternative backend framework
- [Playwright](https://playwright.dev/) - E2E testing
- [Swagger/OpenAPI](https://swagger.io/) - API documentation
- [Docker](https://www.docker.com/) - Containerization
- [Nginx](https://nginx.org/) - Reverse proxy

### Architecture
- Hexagonal Architecture (Ports & Adapters) pattern
- PDPA compliance considerations

## 📞 Support

For issues, questions, or contributions:
- Open an issue on [GitHub Issues](https://github.com/amnuaym/CIC/issues)
- Refer to [documentation](./documentation/) for detailed guides
- Check [User Journey](./documentation/user_journey.md) for API usage examples

## 📚 Additional Resources

- [Project Overview](./documentation/project_overview.md) - Detailed project documentation
- [User Journey](./documentation/user_journey.md) - Complete API usage scenarios
- [Contributing Guidelines](./CONTRIBUTING.md) - How to contribute
- [Swagger API Docs](http://localhost:8080/swagger/) - Interactive API documentation (when running)

---

**Customer Information Center (CIC) - Secure, compliant customer data management 🛡️**
