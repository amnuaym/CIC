package service

import (
	"context"

	"github.com/amnuaym/cic/go/internal/adapter/repository"
	"github.com/google/uuid"
)

type AuditService interface {
	Log(ctx context.Context, entityID uuid.UUID, entityType, action, performedBy, changes, ip string)
}

type auditService struct {
	repo *repository.AuditRepository // Direct usage for now, or define interface in ports
}

func NewAuditService(repo *repository.AuditRepository) *auditService {
	return &auditService{repo: repo}
}

func (s *auditService) Log(ctx context.Context, entityID uuid.UUID, entityType, action, performedBy, changes, ip string) {
	// Async logging
	go func() {
		// Create a new context or use background since original might be cancelled
		log := &repository.AuditLog{
			EntityID:    entityID,
			EntityType:  entityType,
			Action:      action,
			PerformedBy: performedBy,
			Changes:     changes,
			IPAddress:   ip,
		}
		_ = s.repo.Create(context.Background(), log)
	}()
}
