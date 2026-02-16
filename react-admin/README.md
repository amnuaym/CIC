# React Admin Dashboard

React Admin-based dashboard for managing backend data.

## Features

- User-friendly admin interface
- Authentication integration with backend API
- CRUD operations for Posts and Users
- Material-UI design
- TypeScript support
- Built with Vite for fast development

## Setup

### Prerequisites

- Node.js 18+
- npm or yarn
- Running backend API (TypeScript or Go)

### Installation

1. Install dependencies:
```bash
npm install
```

2. Set up environment variables:
```bash
cp .env.example .env
# Edit .env with your API URL
```

3. Run the application:
```bash
# Development mode
npm run dev

# Build for production
npm run build

# Preview production build
npm run preview
```

### Running with Docker

```bash
# From the root directory
docker-compose up react-admin
```

## Configuration

### Environment Variables

Create a `.env` file in the `react-admin` directory:

```
VITE_API_URL=http://localhost:3000
```

This URL should point to your backend API (TypeScript or Go).

## Features

### Authentication

The dashboard uses JWT authentication with the backend API. Users need to log in with their credentials before accessing the admin panel.

### Resources

#### Posts
- List all posts with pagination
- Create new posts
- Edit existing posts
- View post details
- Filter by status (draft, published, archived)

#### Users
- List all users
- View user details
- See user activity status
- View OAuth provider information

## Project Structure

```
react-admin/
├── src/
│   ├── resources/         # Resource components
│   │   ├── posts.tsx
│   │   └── users.tsx
│   ├── App.tsx            # Main application component
│   ├── authProvider.ts    # Authentication logic
│   ├── dataProvider.ts    # Data fetching logic
│   ├── index.tsx          # Application entry point
│   └── vite-env.d.ts      # TypeScript definitions
├── public/                # Static assets
├── index.html             # HTML template
├── package.json
├── tsconfig.json
├── vite.config.ts
└── Dockerfile
```

## Development

### Adding New Resources

1. Create a new resource file in `src/resources/`:
```typescript
// src/resources/myresource.tsx
import { List, Datagrid, TextField } from 'react-admin';

export const MyResourceList = () => (
  <List>
    <Datagrid rowClick="edit">
      <TextField source="id" />
      <TextField source="name" />
    </Datagrid>
  </List>
);
```

2. Register the resource in `src/App.tsx`:
```typescript
<Resource
  name="myresource"
  list={MyResourceList}
  icon={MyIcon}
/>
```

### Customizing the Theme

React Admin uses Material-UI. You can customize the theme by passing a `theme` prop to the `Admin` component in `App.tsx`.

### API Integration

The data provider in `src/dataProvider.ts` handles all API communication. Customize it to match your backend API structure.

## Building for Production

```bash
npm run build
```

This creates an optimized production build in the `dist` directory.

## Docker Deployment

The Dockerfile uses a multi-stage build:
1. Build the React application
2. Serve it with nginx

```bash
docker build -t react-admin .
docker run -p 3001:80 react-admin
```

## Troubleshooting

### CORS Issues

If you encounter CORS errors, ensure your backend API has CORS enabled for the React Admin origin:

```typescript
// TypeScript backend
app.use(cors({
  origin: 'http://localhost:3001',
  credentials: true,
}));
```

```go
// Go backend
c := cors.New(cors.Options{
    AllowedOrigins: []string{"http://localhost:3001"},
    AllowCredentials: true,
})
```

### Authentication Issues

Ensure the backend API is running and the `VITE_API_URL` environment variable is set correctly.

## License

See LICENSE file in the root directory.
