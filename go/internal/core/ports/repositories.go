package ports

import (
	"context"

	"github.com/amnuaym/cic/go/internal/core/domain"
	"github.com/google/uuid"
)

type CustomerRepository interface {
	Create(ctx context.Context, customer *domain.Customer) error
	GetByID(ctx context.Context, id uuid.UUID) (*domain.Customer, error)
	Update(ctx context.Context, customer *domain.Customer) error
	Delete(ctx context.Context, id uuid.UUID) error // Soft delete
	List(ctx context.Context, limit, offset int) ([]*domain.Customer, error)
	Search(ctx context.Context, query string) ([]*domain.Customer, error)
}

type AddressRepository interface {
	Create(ctx context.Context, address *domain.Address) error
	ListByCustomerID(ctx context.Context, customerID uuid.UUID) ([]*domain.Address, error)
	Delete(ctx context.Context, id uuid.UUID) error
}

type IdentityRepository interface {
	Create(ctx context.Context, identity *domain.Identity) error
	ListByCustomerID(ctx context.Context, customerID uuid.UUID) ([]*domain.Identity, error)
	GetByNumber(ctx context.Context, number string) (*domain.Identity, error)
	Delete(ctx context.Context, id uuid.UUID) error
}

type RelationshipRepository interface {
	Create(ctx context.Context, rel *domain.Relationship) error
	ListByCustomerID(ctx context.Context, customerID uuid.UUID) ([]*domain.Relationship, error)
	Delete(ctx context.Context, id uuid.UUID) error
}

type ConsentRepository interface {
	Create(ctx context.Context, consent *domain.Consent) error
	ListByCustomerID(ctx context.Context, customerID uuid.UUID) ([]*domain.Consent, error)
}
