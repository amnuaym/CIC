package repository

import (
	"context"
	"database/sql"
	"time"

	"github.com/google/uuid"
)

type AuditLog struct {
	ID          uuid.UUID
	EntityID    uuid.UUID
	EntityType  string
	Action      string
	PerformedBy string
	Timestamp   time.Time
	Changes     string
	IPAddress   string
}

type AuditRepository struct {
	db *sql.DB
}

func NewAuditRepository(db *sql.DB) *AuditRepository {
	return &AuditRepository{db: db}
}

func (r *AuditRepository) Create(ctx context.Context, log *AuditLog) error {
	query := `
		INSERT INTO audit_logs (entity_id, entity_type, action, performed_by, changes, ip_address)
		VALUES ($1, $2, $3, $4, $5, $6)
		RETURNING id, timestamp
	`
	return r.db.QueryRowContext(ctx, query,
		log.EntityID, log.EntityType, log.Action, log.PerformedBy, log.Changes, log.IPAddress,
	).Scan(&log.ID, &log.Timestamp)
}
