# Go Backend API

Go-based REST API server with PostgreSQL database support.

## Features

- RESTful API endpoints
- PostgreSQL database integration
- JWT authentication
- API Key authentication
- OAuth support (Google example)
- Password hashing with bcrypt
- CORS support
- Unit tests

## Setup

### Prerequisites

- Go 1.21 or higher
- PostgreSQL database

### Installation

1. Install dependencies:
```bash
go mod download
```

2. Set up environment variables (copy from root `.env.example`):
```bash
cp ../.env.example ../.env
# Edit .env with your configuration
```

3. Run the application:
```bash
go run main.go
```

### Running with Docker

```bash
# From the root directory
docker-compose up go-api
```

## Running Tests

```bash
# Run all tests
go test ./...

# Run tests with coverage
go test -cover ./...

# Run tests with verbose output
go test -v ./...
```

## API Endpoints

### Public Endpoints

- `GET /health` - Health check
- `POST /api/auth/login` - User login
- `POST /api/auth/register` - User registration
- `GET /api/auth/oauth/google` - OAuth with Google
- `GET /api/auth/oauth/callback` - OAuth callback

### Protected Endpoints (JWT)

- `GET /api/users/me` - Get current user
- `GET /api/posts` - List all posts
- `POST /api/posts` - Create a new post
- `GET /api/posts/{id}` - Get a specific post
- `PUT /api/posts/{id}` - Update a post
- `DELETE /api/posts/{id}` - Delete a post

### API Key Protected Endpoints

- `GET /api/v1/posts` - List all posts (requires X-API-Key header)

## Authentication

### JWT Authentication

Include the JWT token in the Authorization header:
```
Authorization: Bearer <token>
```

### API Key Authentication

Include the API key in the X-API-Key header:
```
X-API-Key: <api-key>
```

## Project Structure

```
go/
├── main.go                 # Application entry point
├── internal/
│   ├── api/               # API handlers
│   │   ├── handlers.go
│   │   └── handlers_test.go
│   ├── auth/              # Authentication logic
│   │   ├── auth.go
│   │   └── auth_test.go
│   ├── database/          # Database connection
│   │   └── db.go
│   ├── middleware/        # HTTP middleware
│   │   └── middleware.go
│   └── models/            # Data models
│       └── models.go
├── go.mod                 # Go module definition
├── go.sum                 # Go module checksums
└── Dockerfile             # Docker configuration
```

## Environment Variables

| Variable | Description | Default |
|----------|-------------|---------|
| DATABASE_URL | PostgreSQL connection string | - |
| POSTGRES_USER | Database user | admin |
| POSTGRES_PASSWORD | Database password | admin123 |
| POSTGRES_HOST | Database host | localhost |
| POSTGRES_PORT | Database port | 5432 |
| POSTGRES_DB | Database name | template_db |
| PORT | Server port | 8080 |
| JWT_SECRET | JWT signing secret | your-secret-key-change-in-production |
| OAUTH_CLIENT_ID | OAuth client ID | - |
| OAUTH_CLIENT_SECRET | OAuth client secret | - |
| OAUTH_REDIRECT_URL | OAuth redirect URL | - |

## Development

### Adding New Endpoints

1. Add handler function in `internal/api/handlers.go`
2. Register route in `SetupRoutes` function
3. Add tests in `internal/api/handlers_test.go`

### Adding New Models

1. Define model struct in `internal/models/models.go`
2. Create corresponding database table in `scripts/init-db.sql`

## License

See LICENSE file in the root directory.
