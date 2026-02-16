# TypeScript Backend API

TypeScript/Express-based REST API server with PostgreSQL database support.

## Features

- RESTful API endpoints with Express
- PostgreSQL database integration
- JWT authentication
- API Key authentication
- OAuth support (Google example)
- Password hashing with bcrypt
- CORS and Helmet security
- TypeScript for type safety
- Unit tests with Jest
- Hot reload for development

## Setup

### Prerequisites

- Node.js 18+ 
- npm or yarn
- PostgreSQL database

### Installation

1. Install dependencies:
```bash
npm install
```

2. Set up environment variables (copy from root `.env.example`):
```bash
cp ../.env.example ../.env
# Edit .env with your configuration
```

3. Run the application:
```bash
# Development with hot reload
npm run dev

# Build for production
npm run build

# Run production build
npm start
```

### Running with Docker

```bash
# From the root directory
docker-compose up ts-api
```

## Running Tests

```bash
# Run all tests
npm test

# Run tests in watch mode
npm run test:watch

# Run tests with coverage
npm run test:coverage
```

## Linting

```bash
# Check for linting errors
npm run lint

# Fix linting errors automatically
npm run lint:fix
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
- `GET /api/posts/:id` - Get a specific post
- `PUT /api/posts/:id` - Update a post
- `DELETE /api/posts/:id` - Delete a post

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
typescript/
├── src/
│   ├── config/            # Configuration files
│   │   └── database.ts
│   ├── controllers/       # Request handlers
│   │   ├── auth.controller.ts
│   │   ├── post.controller.ts
│   │   └── user.controller.ts
│   ├── middleware/        # Express middleware
│   │   └── auth.ts
│   ├── routes/            # API routes
│   │   ├── auth.routes.ts
│   │   ├── post.routes.ts
│   │   └── user.routes.ts
│   ├── types/             # TypeScript type definitions
│   │   └── index.ts
│   ├── utils/             # Utility functions
│   │   └── auth.ts
│   └── index.ts           # Application entry point
├── __tests__/             # Test files
│   ├── auth.test.ts
│   └── api.test.ts
├── package.json
├── tsconfig.json
├── jest.config.js
└── Dockerfile
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
| PORT | Server port | 3000 |
| TS_API_PORT | TypeScript API port | 3000 |
| JWT_SECRET | JWT signing secret | your-secret-key-change-in-production |
| OAUTH_CLIENT_ID | OAuth client ID | - |
| OAUTH_CLIENT_SECRET | OAuth client secret | - |
| OAUTH_REDIRECT_URL | OAuth redirect URL | - |

## Development

### Adding New Endpoints

1. Create controller function in `src/controllers/`
2. Create route in `src/routes/`
3. Register route in `src/index.ts`
4. Add tests in `__tests__/`

### Adding New Models

1. Define TypeScript interface in `src/types/index.ts`
2. Create corresponding database table in `scripts/init-db.sql`

## License

See LICENSE file in the root directory.
