# Backend Template - Project Overview

## Summary

This repository provides a complete, production-ready backend application template supporting both **Go** and **TypeScript** backends, with PostgreSQL database, React Admin dashboard, comprehensive authentication, and complete testing infrastructure.

## What's Included

### 1. Backend APIs

#### Go API (Port 8080)
- **Framework**: Gorilla Mux
- **Language**: Go 1.21+
- **Features**:
  - RESTful API endpoints
  - JWT authentication
  - API Key authentication
  - PostgreSQL connection with connection pooling
  - Password hashing with bcrypt
  - CORS support
  - Comprehensive error handling
  - Unit tests with high coverage

**Files**: 14 Go files including handlers, auth, middleware, models, and tests

#### TypeScript API (Port 3000)
- **Framework**: Express.js
- **Language**: TypeScript 5.3+
- **Features**:
  - RESTful API endpoints
  - JWT authentication
  - API Key authentication
  - PostgreSQL connection with pg library
  - Password hashing with bcrypt
  - Security headers with Helmet
  - CORS support
  - Full TypeScript type safety
  - Unit tests with Jest

**Files**: 14 TypeScript files including controllers, routes, middleware, and tests

### 2. Admin Dashboard

#### React Admin (Port 3001)
- **Framework**: React Admin 4.16+
- **Build Tool**: Vite
- **Features**:
  - Material-UI design system
  - Authentication integration
  - Posts management (CRUD)
  - Users management (Read)
  - Data provider for backend integration
  - Responsive design
  - Production build with nginx

**Files**: 11 files including components, providers, and configuration

### 3. Database

#### PostgreSQL 15
- **Schema**: Comprehensive database schema with:
  - Users table with OAuth support
  - Roles and permissions
  - API keys for authentication
  - Sessions management
  - Posts (example content table)
  - Proper indexes and foreign keys
  
**Files**: 1 SQL initialization script with complete schema

### 4. Testing

#### Unit Tests
- **Go**: 12 test cases covering auth and API handlers
- **TypeScript**: Jest-based tests for auth utilities and API endpoints

#### End-to-End Tests
- **Framework**: Playwright
- **Coverage**:
  - API health checks (both Go and TypeScript)
  - Authentication flows (register, login)
  - Protected endpoints
  - Admin dashboard UI
  - Cross-browser testing (Chrome, Firefox, Safari)

**Files**: 2 test suites with comprehensive scenarios

### 5. DevOps

#### Docker Support
- **docker-compose.yml**: Complete orchestration for all services
- **Dockerfiles**: Optimized multi-stage builds for:
  - Go API (scratch-based, minimal size)
  - TypeScript API (Node Alpine)
  - React Admin (nginx Alpine)
  
#### CI/CD Pipeline
- **GitHub Actions**: Complete workflow including:
  - Go tests and build
  - TypeScript tests, linting, and build
  - React Admin build
  - E2E tests with service orchestration
  - Docker image building
  - Parallel job execution

**Files**: 1 comprehensive CI/CD workflow

### 6. Documentation

- **Main README**: Complete setup and usage guide
- **Component READMEs**: Detailed docs for each component (4 files)
- **Contributing Guide**: Comprehensive contribution guidelines
- **API Documentation**: Full endpoint documentation
- **Environment Examples**: Configuration templates

**Files**: 6 documentation files

### 7. Scripts & Tools

- **Quick Start Script**: Interactive setup script (`start.sh`)
- **Database Init**: PostgreSQL schema initialization
- **Environment Templates**: `.env.example` files

## File Statistics

- **Total Files**: 55+ source files
- **Go Files**: 14 (including 2 test files)
- **TypeScript/TSX Files**: 25 (including 2 test files)
- **Configuration Files**: 10 (package.json, tsconfig.json, etc.)
- **Documentation Files**: 6 (README.md, CONTRIBUTING.md, etc.)

## Code Quality

### Go Backend
- ✅ All tests passing (12/12)
- ✅ Proper error handling
- ✅ Clean package structure
- ✅ No external dependencies in core logic

### TypeScript Backend
- ✅ Full TypeScript strict mode
- ✅ Comprehensive type definitions
- ✅ Jest test framework configured
- ✅ ESLint configuration

### React Admin
- ✅ TypeScript support
- ✅ Material-UI components
- ✅ Vite for fast builds
- ✅ Production-ready configuration

## Authentication & Security

### Multiple Authentication Methods
1. **JWT Tokens**: For web/mobile applications
2. **API Keys**: For service-to-service communication
3. **OAuth**: Placeholder structure for Google OAuth

### Security Features
- Password hashing with bcrypt (10 rounds)
- JWT with expiration (24 hours)
- CORS configuration
- Helmet security headers (TypeScript)
- SQL injection prevention with parameterized queries
- Environment-based secrets
- API key hashing for storage

## API Endpoints

### Public Endpoints
- `GET /health` - Health check
- `POST /api/auth/register` - User registration
- `POST /api/auth/login` - User login
- `GET /api/auth/oauth/google` - OAuth initiation
- `GET /api/auth/oauth/callback` - OAuth callback

### Protected Endpoints (JWT)
- `GET /api/users/me` - Get current user
- `GET /api/posts` - List posts
- `POST /api/posts` - Create post
- `GET /api/posts/:id` - Get post
- `PUT /api/posts/:id` - Update post
- `DELETE /api/posts/:id` - Delete post

### API Key Endpoints
- `GET /api/v1/posts` - List posts (with API key)

## Database Schema

### Tables
1. **users** - User accounts with OAuth support
2. **roles** - User roles (admin, user)
3. **user_roles** - User-role relationships
4. **api_keys** - API keys for authentication
5. **sessions** - User sessions
6. **posts** - Example content table

### Features
- UUID primary keys
- Proper foreign key constraints
- Indexes on frequently queried columns
- Timestamps (created_at, updated_at)
- Default values and constraints

## Quick Start Commands

### Using Docker (Recommended)
```bash
./start.sh
# or
docker-compose up
```

### Manual Setup
```bash
# Go Backend
cd go && go run main.go

# TypeScript Backend
cd typescript && npm install && npm run dev

# React Admin
cd react-admin && npm install && npm run dev

# E2E Tests
cd e2e-tests && npm install && npm test
```

## Environment Configuration

All services use environment variables from `.env` file:
- Database credentials
- API ports
- JWT secrets
- OAuth credentials
- API URLs

Template provided in `.env.example`

## Testing Commands

```bash
# Go tests
cd go && go test ./...

# TypeScript tests
cd typescript && npm test

# E2E tests
cd e2e-tests && npm test

# All tests in CI/CD
# See .github/workflows/ci-cd.yml
```

## Production Readiness

### ✅ Ready for Production
- Multi-stage Docker builds
- Environment-based configuration
- Security best practices
- Comprehensive error handling
- Logging support
- Health check endpoints
- Graceful shutdown

### ⚠️ Before Production
- Change default JWT_SECRET
- Use strong database passwords
- Enable SSL/TLS for database
- Configure proper CORS origins
- Set up monitoring and logging
- Implement rate limiting
- Regular security audits

## Technology Stack

| Component | Technology | Version |
|-----------|-----------|---------|
| Go Backend | Go | 1.21+ |
| TypeScript Backend | Node.js | 18+ |
| Frontend | React | 18+ |
| Admin UI | React Admin | 4.16+ |
| Database | PostgreSQL | 15+ |
| Testing | Playwright | 1.41+ |
| Testing | Jest | 29+ |
| Container | Docker | 20.10+ |
| Orchestration | Docker Compose | 2.0+ |
| CI/CD | GitHub Actions | - |

## Project Structure Highlights

```
BE-Template/
├── go/                     # Go backend (14 files)
│   ├── internal/          # Internal packages
│   │   ├── api/          # HTTP handlers
│   │   ├── auth/         # Authentication logic
│   │   ├── database/     # DB connection
│   │   ├── middleware/   # HTTP middleware
│   │   └── models/       # Data models
│   └── main.go           # Entry point
├── typescript/            # TypeScript backend (14 files)
│   ├── src/
│   │   ├── config/       # Configuration
│   │   ├── controllers/  # Request handlers
│   │   ├── middleware/   # Express middleware
│   │   ├── routes/       # API routes
│   │   ├── types/        # Type definitions
│   │   └── utils/        # Utilities
│   └── __tests__/        # Unit tests
├── react-admin/           # React Admin (11 files)
│   └── src/
│       ├── resources/    # CRUD resources
│       ├── App.tsx       # Main app
│       ├── authProvider.ts
│       └── dataProvider.ts
├── e2e-tests/            # E2E tests (2 suites)
│   └── tests/
├── scripts/              # SQL scripts
├── .github/workflows/    # CI/CD
├── docker-compose.yml    # Orchestration
├── start.sh              # Quick start
└── Documentation (6 files)
```

## Key Features Summary

1. ✅ **Dual Backend Support**: Choose Go or TypeScript
2. ✅ **Complete Auth System**: JWT, API Keys, OAuth structure
3. ✅ **Admin Dashboard**: React Admin with full CRUD
4. ✅ **PostgreSQL**: Complete schema with migrations
5. ✅ **Testing**: Unit tests and E2E tests
6. ✅ **Docker**: Complete containerization
7. ✅ **CI/CD**: GitHub Actions pipeline
8. ✅ **Documentation**: Comprehensive guides
9. ✅ **Security**: Best practices implemented
10. ✅ **Production-Ready**: Optimized builds

## Next Steps for Users

1. **Clone and Setup**
   ```bash
   git clone https://github.com/amnuaym/BE-Template.git
   cd BE-Template
   ./start.sh
   ```

2. **Customize**
   - Update branding and names
   - Modify database schema
   - Add your business logic
   - Configure OAuth providers

3. **Develop**
   - Add new API endpoints
   - Create new React Admin resources
   - Extend authentication
   - Add new features

4. **Deploy**
   - Build Docker images
   - Deploy to cloud provider
   - Configure production environment
   - Set up monitoring

## License

MIT License - See LICENSE file

## Support

For issues, questions, or contributions, please open an issue on GitHub.

---

**This template provides everything you need to start building a production-ready backend application!** 🚀
