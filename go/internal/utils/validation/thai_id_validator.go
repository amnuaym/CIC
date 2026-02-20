package validation

import (
	"errors"
	"regexp"
	"strconv"
)

// ValidateThaiID checks if the given string is a valid 13-digit Thai National ID.
// It verifies the format (numeric, length 13) and the checksum digit.
func ValidateThaiID(id string) error {
	// 1. Check format (13 digits)
	if match, _ := regexp.MatchString(`^\d{13}$`, id); !match {
		return errors.New("invalid format: must be 13 digits")
	}

	// 2. Calculate Checksum using Mod 11 algorithm
	// Step 1: Multiply each of the first 12 digits by its weight (13 down to 2)
	sum := 0
	for i := 0; i < 12; i++ {
		digit, _ := strconv.Atoi(string(id[i]))
		weight := 13 - i
		sum += digit * weight
	}

	// Step 2: Calculate mod 11 of the sum
	mod := sum % 11

	// Step 3: Subtract from 11 to get the check digit
	checkDigit := (11 - mod) % 10

	// Step 4: Compare with the 13th digit
	lastDigit, _ := strconv.Atoi(string(id[12]))
	if checkDigit != lastDigit {
		return errors.New("invalid checksum")
	}

	return nil
}
