package repository

import (
	"context"
	"database/sql"
	"errors"

	"github.com/amnuaym/cic/go/internal/core/domain"
	"github.com/google/uuid"
)

type customerRepository struct {
	db *sql.DB
}

func NewCustomerRepository(db *sql.DB) *customerRepository {
	return &customerRepository{db: db}
}

func (r *customerRepository) Create(ctx context.Context, c *domain.Customer) error {
	query := `
		INSERT INTO customers (
			type, first_name, last_name, title, date_of_birth, nationality,
			company_name, registration_date, industry_code,
			status, membership_tier, points_balance, clv, portfolio_size,
			last_transaction_date, preferred_channel, is_high_value
		) VALUES (
			$1, $2, $3, $4, $5, $6,
			$7, $8, $9,
			$10, $11, $12, $13, $14,
			$15, $16, $17
		) RETURNING id, created_at, updated_at
	`
	// Handle nullable fields / zero values if necessary
	err := r.db.QueryRowContext(ctx, query,
		c.Type, c.FirstName, c.LastName, c.Title, c.DateOfBirth, c.Nationality,
		c.CompanyName, c.RegistrationDate, c.IndustryCode,
		c.Status, c.MembershipTier, c.PointsBalance, c.CLV, c.PortfolioSize,
		c.LastTransactionDate, c.PreferredChannel, c.IsHighValue,
	).Scan(&c.ID, &c.CreatedAt, &c.UpdatedAt)

	return err
}

func (r *customerRepository) GetByID(ctx context.Context, id uuid.UUID) (*domain.Customer, error) {
	query := `
		SELECT id, type, first_name, last_name, title, date_of_birth, nationality,
		       company_name, registration_date, industry_code,
		       status, membership_tier, points_balance, clv, portfolio_size,
		       last_transaction_date, preferred_channel, is_high_value,
		       created_at, updated_at, deleted_at
		FROM customers
		WHERE id = $1 AND deleted_at IS NULL
	`
	c := &domain.Customer{}
	var firstName, lastName, title, nationality sql.NullString
	var companyName, industryCode sql.NullString
	var status, membershipTier, preferredChannel sql.NullString
	var pointsBalance, clv, portfolioSize sql.NullFloat64
	var isHighValue sql.NullBool
	var dob, regDate, lastTx sql.NullTime

	err := r.db.QueryRowContext(ctx, query, id).Scan(
		&c.ID, &c.Type, &firstName, &lastName, &title, &dob, &nationality,
		&companyName, &regDate, &industryCode,
		&status, &membershipTier, &pointsBalance, &clv, &portfolioSize,
		&lastTx, &preferredChannel, &isHighValue,
		&c.CreatedAt, &c.UpdatedAt, &c.DeletedAt,
	)
	if err == sql.ErrNoRows {
		return nil, errors.New("customer not found")
	}
	if err != nil {
		return nil, err
	}

	c.FirstName = firstName.String
	c.LastName = lastName.String
	c.Title = title.String
	c.Nationality = nationality.String
	c.CompanyName = companyName.String
	c.IndustryCode = industryCode.String
	c.Status = domain.CustomerStatus(status.String)
	c.MembershipTier = membershipTier.String
	c.PreferredChannel = preferredChannel.String
	c.PointsBalance = pointsBalance.Float64
	c.CLV = clv.Float64
	c.PortfolioSize = portfolioSize.Float64
	c.IsHighValue = isHighValue.Bool

	if dob.Valid {
		c.DateOfBirth = dob.Time
	}
	if regDate.Valid {
		c.RegistrationDate = regDate.Time
	}
	if lastTx.Valid {
		c.LastTransactionDate = &lastTx.Time
	}

	return c, nil
}

func (r *customerRepository) Update(ctx context.Context, c *domain.Customer) error {
	query := `
		UPDATE customers SET
			first_name=$1, last_name=$2, title=$3, date_of_birth=$4, nationality=$5,
			company_name=$6, registration_date=$7, industry_code=$8,
			status=$9, membership_tier=$10, points_balance=$11, clv=$12, portfolio_size=$13,
			last_transaction_date=$14, preferred_channel=$15, is_high_value=$16,
			updated_at=NOW()
		WHERE id=$17 AND deleted_at IS NULL
	`
	_, err := r.db.ExecContext(ctx, query,
		c.FirstName, c.LastName, c.Title, c.DateOfBirth, c.Nationality,
		c.CompanyName, c.RegistrationDate, c.IndustryCode,
		c.Status, c.MembershipTier, c.PointsBalance, c.CLV, c.PortfolioSize,
		c.LastTransactionDate, c.PreferredChannel, c.IsHighValue,
		c.ID,
	)
	return err
}

func (r *customerRepository) Delete(ctx context.Context, id, userID uuid.UUID) error {
	// Soft Delete
	query := `UPDATE customers SET deleted_at=NOW(), deleted_by=$2 WHERE id=$1`
	_, err := r.db.ExecContext(ctx, query, id, userID)
	return err
}

func (r *customerRepository) List(ctx context.Context, limit, offset int) ([]*domain.Customer, error) {
	query := `
		SELECT id, type, first_name, last_name, company_name, status, created_at, deleted_at, deleted_by
		FROM customers
		WHERE deleted_at IS NULL
		ORDER BY created_at DESC
		LIMIT $1 OFFSET $2
	`
	rows, err := r.db.QueryContext(ctx, query, limit, offset)
	if err != nil {
		return nil, err
	}
	defer rows.Close()

	var customers []*domain.Customer
	for rows.Next() {
		c := &domain.Customer{}
		var firstName, lastName, companyName sql.NullString
		var deletedBy sql.NullString
		if err := rows.Scan(&c.ID, &c.Type, &firstName, &lastName, &companyName, &c.Status, &c.CreatedAt, &c.DeletedAt, &deletedBy); err != nil {
			return nil, err
		}
		c.FirstName = firstName.String
		c.LastName = lastName.String
		c.CompanyName = companyName.String
		if deletedBy.Valid {
			uid, _ := uuid.Parse(deletedBy.String)
			c.DeletedBy = &uid
		}
		customers = append(customers, c)
	}
	return customers, nil
}

func (r *customerRepository) Restore(ctx context.Context, id uuid.UUID) error {
	query := `UPDATE customers SET deleted_at=NULL, deleted_by=NULL WHERE id=$1`
	_, err := r.db.ExecContext(ctx, query, id)
	return err
}

func (r *customerRepository) ListDeleted(ctx context.Context, limit, offset int) ([]*domain.Customer, error) {
	query := `
		SELECT id, type, first_name, last_name, company_name, status, created_at, deleted_at
		FROM customers
		WHERE deleted_at IS NOT NULL
		ORDER BY deleted_at DESC
		LIMIT $1 OFFSET $2
	`
	rows, err := r.db.QueryContext(ctx, query, limit, offset)
	if err != nil {
		return nil, err
	}
	defer rows.Close()

	var customers []*domain.Customer
	for rows.Next() {
		c := &domain.Customer{}
		var firstName, lastName, companyName sql.NullString
		if err := rows.Scan(&c.ID, &c.Type, &firstName, &lastName, &companyName, &c.Status, &c.CreatedAt, &c.DeletedAt); err != nil {
			return nil, err
		}
		c.FirstName = firstName.String
		c.LastName = lastName.String
		c.CompanyName = companyName.String
		customers = append(customers, c)
	}
	return customers, nil
}

func (r *customerRepository) Search(ctx context.Context, queryStr string) ([]*domain.Customer, error) {
	sqlQuery := `
		SELECT id, type, first_name, last_name, company_name, status, created_at, deleted_at
		FROM customers
		WHERE deleted_at IS NULL AND (
			first_name ILIKE '%' || $1 || '%' OR
			last_name ILIKE '%' || $1 || '%' OR
			company_name ILIKE '%' || $1 || '%'
		)
		LIMIT 20
	`
	rows, err := r.db.QueryContext(ctx, sqlQuery, queryStr)
	if err != nil {
		return nil, err
	}
	defer rows.Close()

	var customers []*domain.Customer
	for rows.Next() {
		c := &domain.Customer{}
		var firstName, lastName, companyName sql.NullString
		if err := rows.Scan(&c.ID, &c.Type, &firstName, &lastName, &companyName, &c.Status, &c.CreatedAt, &c.DeletedAt); err != nil {
			return nil, err
		}
		c.FirstName = firstName.String
		c.LastName = lastName.String
		c.CompanyName = companyName.String
		customers = append(customers, c)
	}
	return customers, nil
}
