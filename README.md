# BC Service Request API

A custom Microsoft Dynamics 365 Business Central extension that exposes service requests through a REST API.

The project is designed as a practical example of building and consuming custom Business Central APIs using AL.

## Features

- Create service requests through the API
- Retrieve all service requests
- Retrieve a specific service request by ID
- Update existing service requests
- Customer validation against the Business Central Customer table
- Priority management
- Status tracking
- Automatic creation timestamp
- Uses `SystemId` as the API record identifier

## Business Scenario

An external application needs to submit and manage service requests inside Microsoft Dynamics 365 Business Central.

Each service request contains information such as:

- Customer
- Title
- Description
- Priority
- Status
- Creation date and time

The external application communicates with Business Central using a custom REST API.

## AL Objects

The extension contains the following objects:

- Service Request table
- Service Request Priority enum
- Service Request Status enum
- Service Request API page
- Service Request list page
- Service Request test codeunit (separate test app)

## Repository Layout

```text
app/    The extension (tables, enums, pages)
test/   The test app
.AL-Go/ and .github/   AL-Go for GitHub build and test workflows
```

Open `al.code-workspace` in VS Code to work on both apps.

## Tests

The `test` app covers the business rules:

- A new request always starts as `Open`
- An unknown customer is rejected, on validation and on insert
- A request without a customer is rejected
- Entry numbers are assigned automatically and are unique
- The status can be updated after creation

The tests assert the specific error text. They run in the AL-Go `CI/CD` and pull request workflows; see the Actions tab for the latest run.

## Service Request Fields

| Field        | Description                           |
| ------------ | ------------------------------------- |
| Entry No.    | Internal sequential number            |
| Customer No. | Business Central customer number      |
| Title        | Short description of the request      |
| Description  | Detailed request description          |
| Priority     | Low, Normal, or High                  |
| Status       | Open, In Progress, or Closed          |
| Created At   | Date and time the request was created |
| SystemId     | Unique API identifier                 |

## API Structure

The custom API uses the following metadata:

```text
Publisher: elomary
Group: service
Version: v1.0
Entity Name: serviceRequest
Entity Set Name: serviceRequests
```

The endpoint follows this structure:

```text
https://api.businesscentral.dynamics.com/v2.0/{tenantId}/{environment}/api/elomary/service/v1.0/companies({companyId})/serviceRequests
```

## Get All Service Requests

```http
GET /companies({companyId})/serviceRequests
```

Example response:

```json
{
  "value": [
    {
      "id": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
      "entryNo": 1,
      "customerNo": "10000",
      "title": "Printer not working",
      "description": "The printer stopped working this morning.",
      "priority": "High",
      "status": "Open",
      "createdAt": "2026-09-29T18:30:00Z"
    }
  ]
}
```

## Get One Service Request

```http
GET /companies({companyId})/serviceRequests({serviceRequestId})
```

## Create a Service Request

```http
POST /companies({companyId})/serviceRequests
```

Example request body:

```json
{
  "customerNo": "10000",
  "title": "Printer not working",
  "description": "The printer stopped working this morning.",
  "priority": "High"
}
```

When a new request is created:

- Status is automatically set to `Open`
- Created At is automatically populated
- Customer No. must exist in Business Central

## Update a Service Request

```http
PATCH /companies({companyId})/serviceRequests({serviceRequestId})
```

Required header:

```http
If-Match: *
```

Example request body:

```json
{
  "status": "In Progress"
}
```

Only the fields that need to change have to be included in the PATCH body.

## Authentication

Business Central Online APIs use Microsoft Entra ID OAuth 2.0 authentication.

Requests should include:

```http
Authorization: Bearer {accessToken}
Content-Type: application/json
```

For PATCH operations:

```http
If-Match: *
```

## Getting the Company ID

The Business Central company ID can be retrieved using the standard API:

```http
GET https://api.businesscentral.dynamics.com/v2.0/{tenantId}/{environment}/api/v2.0/companies
```

The `id` returned for the company is used in the custom API URL.

Example:

```json
{
  "id": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
  "name": "CRONUS International Ltd."
}
```

## Business Rules

The extension applies the following rules:

- A service request must reference an existing Business Central customer
- Invalid customer numbers are rejected
- New requests start with the `Open` status
- Creation date and time are generated automatically
- API records are identified using `SystemId`

## Technologies

- Microsoft Dynamics 365 Business Central
- AL Language
- Business Central REST APIs
- Microsoft Entra ID
- OAuth 2.0
- Postman
- AL-Go for GitHub

## Purpose

This project is a small reference implementation of a custom Business Central API.

It demonstrates how to:

- Design a custom Business Central API
- Expose custom tables through API pages
- Work with REST operations
- Handle validation and business logic
- Cover business rules with automated tests in CI
- Integrate Business Central with external applications

## Author

Mohamed El Omary

Business Central Technical Consultant / AL Developer
