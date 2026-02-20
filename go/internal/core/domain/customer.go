package domain

import (
	"time"

	"github.com/google/uuid"
)

type CustomerType string

const (
	TypePersonal CustomerType = "PERSONAL"
	TypeJuristic CustomerType = "JURISTIC"
)

type CustomerStatus string

const (
	StatusActive     CustomerStatus = "ACTIVE"
	StatusInactive   CustomerStatus = "INACTIVE"
	StatusSuspended  CustomerStatus = "SUSPENDED"
	StatusDeceased   CustomerStatus = "DECEASED"
	StatusBlacklist  CustomerStatus = "BLACKLISTED"
)

type Customer struct {
	ID   uuid.UUID    `json:"id"`
	Type CustomerType `json:"type"`

	// Personal Fields
	FirstName   string    `json:"first_name,omitempty"`
	LastName    string    `json:"last_name,omitempty"`
	Title       string    `json:"title,omitempty"`
	DateOfBirth time.Time `json:"date_of_birth,omitempty"`
	Nationality string    `json:"nationality,omitempty"`

	// Juristic Fields
	CompanyName      string    `json:"company_name,omitempty"`
	RegistrationDate time.Time `json:"registration_date,omitempty"`
	IndustryCode     string    `json:"industry_code,omitempty"`

	// Business Profile
	Status              CustomerStatus `json:"status"`
	MembershipTier      string         `json:"membership_tier"`
	PointsBalance       float64        `json:"points_balance"`
	CLV                 float64        `json:"clv"`
	PortfolioSize       float64        `json:"portfolio_size"`
	LastTransactionDate *time.Time     `json:"last_transaction_date"`
	PreferredChannel    string         `json:"preferred_channel"`
	IsHighValue         bool           `json:"is_high_value"`

	CreatedAt time.Time  `json:"created_at"`
	UpdatedAt time.Time  `json:"updated_at"`
	DeletedAt *time.Time `json:"deleted_at,omitempty"`
	DeletedBy *uuid.UUID `json:"deleted_by,omitempty"`
}

type Address struct {
	ID         uuid.UUID `json:"id"`
	CustomerID uuid.UUID `json:"customer_id"`
	Type       string    `json:"type"` // Registered, Mailing, HQ

	AddressLine1 string `json:"address_line1"`
	AddressLine2 string `json:"address_line2"`
	City         string `json:"city"`
	State        string `json:"state"`
	District     string `json:"district"`
	SubDistrict  string `json:"sub_district"`
	ZipCode      string `json:"zip_code"`
	Country      string `json:"country"`

	CreatedAt time.Time `json:"created_at"`
	UpdatedAt time.Time `json:"updated_at"`
}

type Identity struct {
	ID              uuid.UUID `json:"id"`
	CustomerID      uuid.UUID `json:"customer_id"`
	Type            string    `json:"type"` // Passport, National ID, Tax ID
	Number          string    `json:"number"`
	IssuanceCountry string    `json:"issuance_country"`
	ExpiryDate      time.Time `json:"expiry_date"`

	CreatedAt time.Time `json:"created_at"`
	UpdatedAt time.Time `json:"updated_at"`
}

type Relationship struct {
	ID             uuid.UUID `json:"id"`
	FromCustomerID uuid.UUID `json:"from_customer_id"`
	ToCustomerID   uuid.UUID `json:"to_customer_id"`
	Role           string    `json:"role"`

	CreatedAt time.Time `json:"created_at"`
}

type Consent struct {
	ID         uuid.UUID `json:"id"`
	CustomerID uuid.UUID `json:"customer_id"`
	Topic      string    `json:"topic"`
	Version    string    `json:"version"`
	IsGranted  bool      `json:"is_granted"`
	Timestamp  time.Time `json:"timestamp"`

	CreatedAt time.Time `json:"created_at"`
}
