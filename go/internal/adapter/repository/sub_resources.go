package repository

import (
	"context"
	"database/sql"

	"github.com/amnuaym/cic/go/internal/core/domain"
	"github.com/google/uuid"
)

// --- Address Repository ---

type addressRepository struct {
	db *sql.DB
}

func NewAddressRepository(db *sql.DB) *addressRepository {
	return &addressRepository{db: db}
}

func (r *addressRepository) Create(ctx context.Context, a *domain.Address) error {
	query := `
		INSERT INTO addresses (
			customer_id, type, address_line1, address_line2,
			city, state, district, sub_district, zip_code, country
		) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10)
		RETURNING id, created_at, updated_at
	`
	return r.db.QueryRowContext(ctx, query,
		a.CustomerID, a.Type, a.AddressLine1, a.AddressLine2,
		a.City, a.State, a.District, a.SubDistrict, a.ZipCode, a.Country,
	).Scan(&a.ID, &a.CreatedAt, &a.UpdatedAt)
}

func (r *addressRepository) ListByCustomerID(ctx context.Context, customerID uuid.UUID) ([]*domain.Address, error) {
	query := `SELECT * FROM addresses WHERE customer_id = $1`
	rows, err := r.db.QueryContext(ctx, query, customerID)
	if err != nil {
		return nil, err
	}
	defer rows.Close()

	var addresses []*domain.Address
	for rows.Next() {
		a := &domain.Address{}
		if err := rows.Scan(
			&a.ID, &a.CustomerID, &a.Type,
			&a.AddressLine1, &a.AddressLine2, &a.City, &a.State, &a.District, &a.SubDistrict, &a.ZipCode, &a.Country,
			&a.CreatedAt, &a.UpdatedAt,
		); err != nil {
			return nil, err
		}
		addresses = append(addresses, a)
	}
	return addresses, nil
}

func (r *addressRepository) Delete(ctx context.Context, id uuid.UUID) error {
	_, err := r.db.ExecContext(ctx, "DELETE FROM addresses WHERE id = $1", id)
	return err
}

// --- Identity Repository ---

type identityRepository struct {
	db *sql.DB
}

func NewIdentityRepository(db *sql.DB) *identityRepository {
	return &identityRepository{db: db}
}

func (r *identityRepository) Create(ctx context.Context, i *domain.Identity) error {
	query := `
		INSERT INTO identities (
			customer_id, type, number, issuance_country, expiry_date
		) VALUES ($1, $2, $3, $4, $5)
		RETURNING id, created_at, updated_at
	`
	var expiry sql.NullTime
	if !i.ExpiryDate.IsZero() {
		expiry.Time = i.ExpiryDate
		expiry.Valid = true
	}
	
	err := r.db.QueryRowContext(ctx, query,
		i.CustomerID, i.Type, i.Number, i.IssuanceCountry, expiry,
	).Scan(&i.ID, &i.CreatedAt, &i.UpdatedAt)
	
	if err == nil && expiry.Valid {
		i.ExpiryDate = expiry.Time
	}
	return err
}

func (r *identityRepository) ListByCustomerID(ctx context.Context, customerID uuid.UUID) ([]*domain.Identity, error) {
	query := `SELECT * FROM identities WHERE customer_id = $1`
	rows, err := r.db.QueryContext(ctx, query, customerID)
	if err != nil {
		return nil, err
	}
	defer rows.Close()

	var identities []*domain.Identity
	for rows.Next() {
		i := &domain.Identity{}
		var expiry sql.NullTime
		if err := rows.Scan(
			&i.ID, &i.CustomerID, &i.Type, &i.Number, &i.IssuanceCountry, &expiry,
			&i.CreatedAt, &i.UpdatedAt,
		); err != nil {
			return nil, err
		}
		if expiry.Valid {
			i.ExpiryDate = expiry.Time
		}
		identities = append(identities, i)
	}
	return identities, nil
}

func (r *identityRepository) GetByNumber(ctx context.Context, number string) (*domain.Identity, error) {
	query := `SELECT * FROM identities WHERE number = $1`
	i := &domain.Identity{}
	var expiry sql.NullTime
	err := r.db.QueryRowContext(ctx, query, number).Scan(
		&i.ID, &i.CustomerID, &i.Type, &i.Number, &i.IssuanceCountry, &expiry,
		&i.CreatedAt, &i.UpdatedAt,
	)
	if err != nil {
		return nil, err
	}
	if expiry.Valid {
		i.ExpiryDate = expiry.Time
	}
	return i, nil
}

func (r *identityRepository) Delete(ctx context.Context, id uuid.UUID) error {
	_, err := r.db.ExecContext(ctx, "DELETE FROM identities WHERE id = $1", id)
	return err
}

// --- Relationship Repository ---

type relationshipRepository struct {
	db *sql.DB
}

func NewRelationshipRepository(db *sql.DB) *relationshipRepository {
	return &relationshipRepository{db: db}
}

func (r *relationshipRepository) Create(ctx context.Context, rel *domain.Relationship) error {
	query := `
		INSERT INTO relationships (from_customer_id, to_customer_id, role)
		VALUES ($1, $2, $3)
		RETURNING id, created_at
	`
	return r.db.QueryRowContext(ctx, query,
		rel.FromCustomerID, rel.ToCustomerID, rel.Role,
	).Scan(&rel.ID, &rel.CreatedAt)
}

func (r *relationshipRepository) ListByCustomerID(ctx context.Context, customerID uuid.UUID) ([]*domain.Relationship, error) {
	query := `
		SELECT * FROM relationships 
		WHERE from_customer_id = $1 OR to_customer_id = $1
	`
	rows, err := r.db.QueryContext(ctx, query, customerID)
	if err != nil {
		return nil, err
	}
	defer rows.Close()

	var rels []*domain.Relationship
	for rows.Next() {
		rel := &domain.Relationship{}
		if err := rows.Scan(&rel.ID, &rel.FromCustomerID, &rel.ToCustomerID, &rel.Role, &rel.CreatedAt); err != nil {
			return nil, err
		}
		rels = append(rels, rel)
	}
	return rels, nil
}

func (r *relationshipRepository) Delete(ctx context.Context, id uuid.UUID) error {
	_, err := r.db.ExecContext(ctx, "DELETE FROM relationships WHERE id = $1", id)
	return err
}

// --- Consent Repository ---

type consentRepository struct {
	db *sql.DB
}

func NewConsentRepository(db *sql.DB) *consentRepository {
	return &consentRepository{db: db}
}

func (r *consentRepository) Create(ctx context.Context, c *domain.Consent) error {
	query := `
		INSERT INTO consents (customer_id, topic, version, is_granted)
		VALUES ($1, $2, $3, $4)
		RETURNING id, timestamp, created_at
	`
	return r.db.QueryRowContext(ctx, query,
		c.CustomerID, c.Topic, c.Version, c.IsGranted,
	).Scan(&c.ID, &c.Timestamp, &c.CreatedAt)
}

func (r *consentRepository) ListByCustomerID(ctx context.Context, customerID uuid.UUID) ([]*domain.Consent, error) {
	query := `SELECT * FROM consents WHERE customer_id = $1 ORDER BY timestamp DESC`
	rows, err := r.db.QueryContext(ctx, query, customerID)
	if err != nil {
		return nil, err
	}
	defer rows.Close()

	var consents []*domain.Consent
	for rows.Next() {
		c := &domain.Consent{}
		if err := rows.Scan(&c.ID, &c.CustomerID, &c.Topic, &c.Version, &c.IsGranted, &c.Timestamp, &c.CreatedAt); err != nil {
			return nil, err
		}
		consents = append(consents, c)
	}
	return consents, nil
}
