# Contributing to Customer Information Center (CIC)

Thank you for your interest in contributing to the Customer Information Center (CIC) project! This document provides guidelines and instructions for contributing.

## Table of Contents

- [Code of Conduct](#code-of-conduct)
- [Getting Started](#getting-started)
- [How to Contribute](#how-to-contribute)
- [Development Workflow](#development-workflow)
- [Coding Standards](#coding-standards)
- [Testing Guidelines](#testing-guidelines)
- [Pull Request Process](#pull-request-process)
- [Reporting Issues](#reporting-issues)

## Code of Conduct

This project adheres to a code of conduct that we expect all contributors to follow. Please be respectful and constructive in all interactions.

## Getting Started

1. **Fork the repository** on GitHub
2. **Clone your fork** locally:
   ```bash
   git clone https://github.com/YOUR_USERNAME/CIC.git
   cd CIC
   ```
3. **Add upstream remote**:
   ```bash
   git remote add upstream https://github.com/amnuaym/CIC.git
   ```
4. **Set up your development environment**:
   ```bash
   ./start.sh
   ```

## How to Contribute

### Types of Contributions

- **Bug fixes**: Fix issues in existing code
- **Features**: Add new functionality
- **Documentation**: Improve or add documentation
- **Tests**: Add or improve test coverage
- **Refactoring**: Improve code quality without changing functionality

### Before You Start

1. Check existing [issues](https://github.com/amnuaym/CIC/issues) and [pull requests](https://github.com/amnuaym/CIC/pulls)
2. Create or comment on an issue to discuss your planned changes
3. Wait for feedback before starting major work

## Development Workflow

### 1. Create a Branch

```bash
git checkout -b feature/your-feature-name
# or
git checkout -b fix/your-bug-fix
```

Branch naming conventions:
- `feature/` - New features
- `fix/` - Bug fixes
- `docs/` - Documentation changes
- `test/` - Test additions or changes
- `refactor/` - Code refactoring

### 2. Make Your Changes

- Write clean, maintainable code
- Follow existing code style and patterns
- Add tests for new functionality
- Update documentation as needed

### 3. Test Your Changes

**Go Backend:**
```bash
cd go
go test ./...
go test -cover ./...
```

**TypeScript Backend:**
```bash
cd typescript
npm test
npm run lint
```

**React Admin:**
```bash
cd react-admin
npm run build
```

**E2E Tests:**
```bash
cd e2e-tests
npm test
```

### 4. Commit Your Changes

Write clear, concise commit messages:

```bash
git add .
git commit -m "Add feature: brief description"
```

Good commit message examples:
- `Add JWT authentication for Go API`
- `Fix: Correct password hashing in TypeScript backend`
- `Docs: Update README with installation steps`
- `Test: Add unit tests for auth module`

### 5. Keep Your Fork Updated

```bash
git fetch upstream
git rebase upstream/main
```

### 6. Push Your Changes

```bash
git push origin feature/your-feature-name
```

## Coding Standards

### Go

- Follow [Effective Go](https://golang.org/doc/effective_go.html)
- Run `go fmt` before committing
- Add comments for exported functions
- Keep functions small and focused
- Handle errors explicitly

Example:
```go
// GetUserByID retrieves a user by their unique identifier
func GetUserByID(db *sql.DB, id string) (*User, error) {
    var user User
    err := db.QueryRow("SELECT id, username FROM users WHERE id = $1", id).Scan(&user.ID, &user.Username)
    if err != nil {
        return nil, fmt.Errorf("failed to get user: %w", err)
    }
    return &user, nil
}
```

### TypeScript

- Follow TypeScript best practices
- Use TypeScript strict mode
- Define interfaces for all data structures
- Use async/await for asynchronous code
- Add JSDoc comments for functions

Example:
```typescript
/**
 * Retrieves a user by their unique identifier
 */
export const getUserById = async (id: string): Promise<User> => {
  const result = await query('SELECT id, username FROM users WHERE id = $1', [id]);
  if (result.rows.length === 0) {
    throw new Error('User not found');
  }
  return result.rows[0];
};
```

### React/TypeScript

- Use functional components with hooks
- Define prop types with TypeScript interfaces
- Keep components small and reusable
- Use meaningful component names

Example:
```typescript
interface PostListProps {
  userId?: string;
}

export const PostList: React.FC<PostListProps> = ({ userId }) => {
  // Component implementation
};
```

## Testing Guidelines

### Unit Tests

- Test all new functions and methods
- Aim for >80% code coverage
- Use descriptive test names
- Test both success and error cases

**Go Test Example:**
```go
func TestHashPassword(t *testing.T) {
    password := "test_password"
    hash, err := HashPassword(password)
    
    if err != nil {
        t.Fatalf("Expected no error, got %v", err)
    }
    
    if hash == password {
        t.Fatal("Hash should not equal password")
    }
}
```

**TypeScript Test Example:**
```typescript
describe('hashPassword', () => {
  it('should hash a password', async () => {
    const password = 'test_password';
    const hash = await hashPassword(password);
    
    expect(hash).toBeDefined();
    expect(hash).not.toBe(password);
  });
});
```

### Integration Tests

- Test API endpoints end-to-end
- Test authentication flows
- Test database interactions

### E2E Tests

- Test critical user journeys
- Test across different browsers
- Include both success and failure scenarios

## Pull Request Process

### 1. Before Submitting

- [ ] Code follows project style guidelines
- [ ] All tests pass locally
- [ ] New tests added for new functionality
- [ ] Documentation updated
- [ ] Commit messages are clear
- [ ] Branch is up-to-date with main

### 2. Creating the PR

1. Go to your fork on GitHub
2. Click "New Pull Request"
3. Select your branch
4. Fill in the PR template with:
   - Description of changes
   - Related issue number
   - Testing performed
   - Screenshots (if UI changes)

### 3. PR Title Format

```
[Type] Brief description
```

Examples:
- `[Feature] Add OAuth authentication`
- `[Fix] Correct database connection pooling`
- `[Docs] Update installation instructions`
- `[Test] Add E2E tests for admin dashboard`

### 4. After Submission

- Respond to review comments promptly
- Make requested changes in new commits
- Request re-review when ready
- Keep PR focused (avoid scope creep)

### 5. PR Checklist

Your PR should include:
- [ ] Clear description of changes
- [ ] Link to related issue
- [ ] Tests that verify the changes
- [ ] Updated documentation
- [ ] No merge conflicts
- [ ] CI/CD checks passing

## Reporting Issues

### Bug Reports

When reporting bugs, include:

1. **Description**: Clear description of the bug
2. **Steps to Reproduce**: Step-by-step instructions
3. **Expected Behavior**: What should happen
4. **Actual Behavior**: What actually happens
5. **Environment**: OS, versions, etc.
6. **Screenshots**: If applicable
7. **Logs**: Relevant error messages

Example:
```markdown
## Bug Description
TypeScript API returns 500 error when creating a post

## Steps to Reproduce
1. Start TypeScript API with `npm run dev`
2. Login with valid credentials
3. POST to `/api/posts` with valid data
4. Observe 500 error response

## Expected Behavior
Post should be created successfully with 201 status

## Actual Behavior
Returns 500 Internal Server Error

## Environment
- OS: Ubuntu 22.04
- Node.js: v18.12.0
- PostgreSQL: 15.1

## Error Logs
```
Error: Cannot read property 'id' of undefined
    at createPost (controllers/post.controller.ts:42)
```
```

### Feature Requests

When requesting features, include:

1. **Description**: What feature you'd like
2. **Use Case**: Why this feature is needed
3. **Proposed Solution**: How it might work
4. **Alternatives**: Other solutions considered
5. **Additional Context**: Any other relevant information

## Questions?

If you have questions about contributing:

1. Check existing documentation
2. Search closed issues
3. Ask in an issue or discussion
4. Contact maintainers

## License

By contributing to this project, you agree that your contributions will be licensed under the GNU General Public License v3.0.

---

Thank you for contributing to Customer Information Center (CIC)! 🛡️
