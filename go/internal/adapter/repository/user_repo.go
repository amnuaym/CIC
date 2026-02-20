package repository

import (
	"context"
	"database/sql"

	"github.com/amnuaym/cic/go/internal/core/ports"
	"github.com/amnuaym/cic/go/internal/models"
	"github.com/google/uuid"
)

type userRepository struct {
	db *sql.DB
}

func NewUserRepository(db *sql.DB) ports.UserRepository {
	return &userRepository{db: db}
}

func (r *userRepository) GetByID(ctx context.Context, id uuid.UUID) (*models.User, error) {
	query := `
		SELECT id, email, username, is_active, created_at, updated_at, role, supervisor_id
		FROM users
		WHERE id = $1
	`
	var user models.User
	err := r.db.QueryRowContext(ctx, query, id).Scan(
		&user.ID, &user.Email, &user.Username, &user.IsActive, &user.CreatedAt, &user.UpdatedAt, &user.Role, &user.SupervisorID,
	)
	if err != nil {
		return nil, err
	}
	return &user, nil
}
