Business Requirements Document

Project Name: Customer Information Center (CIC)

1. Project Overview

The Customer Information Center (CIC) is a central backend system designed to be the "Single Source of Truth" for all customer information. It will store data for both individual people and business companies. The system will safely share this data with other internal company systems and external mobile/web applications.

2. Functional Requirements

These are the specific tasks and actions the system must be able to perform.

2.1 Managing Customer Data

Create Profiles: Users must be able to create profiles for regular people (First Name, Last Name, Birthdate, Nationality) and business companies (Company Name, Registration Date, Tax ID).

Update and Move: The system must allow updates to customer information (like a name change) and support moving customers between different internal branches or groups.

Flexible ID Cards: The system must allow one customer to have many different types of ID cards saved (e.g., a Passport, a Driver's License, and a National ID). It must record the ID type, the number, and the issuing country.

Global Addresses: The system must store multiple addresses (Home, Work, Mailing). The address format must adapt based on the country (e.g., asking for a "State" and "Zip Code" for the US, or "Province" and "District" for Thailand).

Contact Info: The system must store multiple phone numbers and email addresses per customer.

2.2 Search and Relationships

Search: Users must be able to find a customer quickly by searching their name, ID number, or phone number.

Connections: The system must show links between people and companies. For example, it should show that "John Doe" is a "Director" of "ABC Company."

2.3 Business Profile and Value

Membership Tiers: The system must track the customer's loyalty level (e.g., Gold, Silver) and when that status expires.

Account Status: The system must track if the customer is Active, Inactive, Suspended, or Blacklisted.

Financial Summary: The system will store a summary of the customer's total value to the company (e.g., Total lifetime value, total money in accounts). Note: The system will only store summaries, not a list of every single purchase.

2.4 Privacy and Compliance (PDPA)

Managing Consent: The system must record what the customer has agreed to (e.g., "Agreed to marketing emails") and track if they withdraw that permission.

Data Export: The system must have a button to export all data we have on a customer so we can give it to them if they ask.

The "Right to be Forgotten" (Anonymization Rules):
If a customer asks us to delete their data, the system must follow these strict steps:

Check for active business: The system must check if the customer owes us money or has active services. If yes, the request is rejected.

Scramble personal details: If the request is approved, the system must NOT completely delete the record. Instead, it must replace their real name, phone, and IDs with scrambled, anonymous text (e.g., "Deleted_User_123").

Keep financial totals: The system must keep the customer's past financial totals linked to the scrambled ID. This ensures the company's past accounting reports stay accurate.

2.5 Security and Tracking (Audit Logs)

Access Control: Internal systems will connect using secure digital certificates. Staff and external apps will log in using a standard secure username/password system.

Strict Audit Trail: Every single time data is added, changed, or deleted, the system must write it down in a secure log. This log must include:

Who made the change.

The exact date and time.

What the old information was, and what the new information is.

The computer IP address where the request came from.

3. Non-Functional Requirements

These are the rules for how fast, safe, and reliable the system needs to be.

3.1 Speed and Reliability

Fast Responses: When a user searches for a customer, the system must reply in less than 200 milliseconds.

Always Online (99.9% Uptime): The system will run on multiple servers at the same time. If one crashes, the others will instantly take over so the system never goes down.

Disaster Backup: The database must automatically back itself up every 6 hours to a separate location.

Traffic Limits: To prevent the system from crashing due to too much traffic, the "front door" of the system will block users who send more than 1,000 requests per minute.

3.2 Global Support

Languages: The database must support all world languages (so it can save names written in Thai, Japanese, English, etc.).

Time Zones: All dates and times must be saved in a standard global time (UTC) but shown to the user in their local time zone.

3.3 System Maintenance

Central Logs: If an error happens, the system will send an error report to a central dashboard so the IT team can fix it without having to log into the main servers.

Health Checks: The system will have a simple status page that constantly checks if the database is running properly.

4. Development Guidelines

How the engineering team should build the system.

Design First: The team must write the "API rules" (how systems talk to each other) before writing any actual code.

Clean Code: The rules of the business must be written separately from the code that saves data to the database. This makes it easier to upgrade parts of the system later.

Never Trust Input: The system must double-check every piece of data typed in by a user to make sure it is safe and formatted correctly before saving it.

5. Technology Choices

Main Programming Language: Go (Golang) - Chosen because it is incredibly fast and handles heavy traffic very well.

Database: PostgreSQL - Chosen because it can handle strict data (like a Tax ID) and flexible data (like foreign addresses) at the same time.

Login System: Keycloak - A free, secure system for handling user logins.

Staff Dashboard: React Admin (using TypeScript) - A quick way to build a secure, reliable dashboard for staff without starting from scratch.
