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

func (r *AuditRepository) List(ctx context.Context, limit, offset int, action string) ([]*AuditLog, error) {
	var query string
	var args []interface{}

	if action != "" {
		query = `SELECT id, entity_id, entity_type, action, performed_by, timestamp, changes, ip_address
			FROM audit_logs WHERE action = $1 ORDER BY timestamp DESC LIMIT $2 OFFSET $3`
		args = []interface{}{action, limit, offset}
	} else {
		query = `SELECT id, entity_id, entity_type, action, performed_by, timestamp, changes, ip_address
			FROM audit_logs ORDER BY timestamp DESC LIMIT $1 OFFSET $2`
		args = []interface{}{limit, offset}
	}

	rows, err := r.db.QueryContext(ctx, query, args...)
	if err != nil {
		return nil, err
	}
	defer rows.Close()

	var logs []*AuditLog
	for rows.Next() {
		l := &AuditLog{}
		err := rows.Scan(&l.ID, &l.EntityID, &l.EntityType, &l.Action, &l.PerformedBy, &l.Timestamp, &l.Changes, &l.IPAddress)
		if err != nil {
			return nil, err
		}
		logs = append(logs, l)
	}
	return logs, nil
}

func (r *AuditRepository) GetByID(ctx context.Context, id uuid.UUID) (*AuditLog, error) {
	query := `SELECT id, entity_id, entity_type, action, performed_by, timestamp, changes, ip_address
		FROM audit_logs WHERE id = $1`
	l := &AuditLog{}
	err := r.db.QueryRowContext(ctx, query, id).Scan(
		&l.ID, &l.EntityID, &l.EntityType, &l.Action, &l.PerformedBy, &l.Timestamp, &l.Changes, &l.IPAddress,
	)
	if err != nil {
		return nil, err
	}
	return l, nil
}
