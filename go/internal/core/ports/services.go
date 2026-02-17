package ports

import (
	"context"

	"github.com/amnuaym/cic/go/internal/core/domain"
	"github.com/google/uuid"
)

type CustomerService interface {
	CreateCustomer(ctx context.Context, customer *domain.Customer) error
	GetCustomer(ctx context.Context, id uuid.UUID) (*domain.Customer, error)
	UpdateCustomer(ctx context.Context, customer *domain.Customer) error
	DeleteCustomer(ctx context.Context, id uuid.UUID) error
	SearchCustomers(ctx context.Context, query string) ([]*domain.Customer, error)
	AnonymizeCustomer(ctx context.Context, id uuid.UUID) error

	AddAddress(ctx context.Context, address *domain.Address) error
	GetAddresses(ctx context.Context, customerID uuid.UUID) ([]*domain.Address, error)
	RemoveAddress(ctx context.Context, addressID uuid.UUID) error

	AddIdentity(ctx context.Context, identity *domain.Identity) error
	GetIdentities(ctx context.Context, customerID uuid.UUID) ([]*domain.Identity, error)
	RemoveIdentity(ctx context.Context, identityID uuid.UUID) error

	AddRelationship(ctx context.Context, rel *domain.Relationship) error
	GetRelationships(ctx context.Context, customerID uuid.UUID) ([]*domain.Relationship, error)
	RemoveRelationship(ctx context.Context, relID uuid.UUID) error

	ManageConsent(ctx context.Context, consent *domain.Consent) error
	GetConsents(ctx context.Context, customerID uuid.UUID) ([]*domain.Consent, error)
}
