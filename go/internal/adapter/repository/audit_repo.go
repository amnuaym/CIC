package repository

import (
	"context"
	"database/sql"
	"fmt"
	"strings"
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

func (r *AuditRepository) List(ctx context.Context, limit, offset int, action string, entityID string) ([]*AuditLog, error) {
	query := `SELECT id, entity_id, entity_type, action, performed_by, timestamp, changes, ip_address
		FROM audit_logs`
	var conditions []string
	var args []interface{}
	argIdx := 1

	if action != "" {
		conditions = append(conditions, fmt.Sprintf("action = $%d", argIdx))
		args = append(args, action)
		argIdx++
	}
	if entityID != "" {
		conditions = append(conditions, fmt.Sprintf("entity_id = $%d", argIdx))
		args = append(args, entityID)
		argIdx++
	}

	if len(conditions) > 0 {
		query += " WHERE " + strings.Join(conditions, " AND ")
	}

	query += fmt.Sprintf(" ORDER BY timestamp DESC LIMIT $%d OFFSET $%d", argIdx, argIdx+1)
	args = append(args, limit, offset)

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
