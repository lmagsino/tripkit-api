# TripKit API

> Backend API for a travel companion application

[![Rails](https://img.shields.io/badge/Rails-7.0+-red.svg)](https://rubyonrails.org/)
[![PostgreSQL](https://img.shields.io/badge/PostgreSQL-14+-blue.svg)](https://www.postgresql.org/)

---

## About

TripKit is a travel companion app for group trips, helping travelers manage expenses, itineraries, and documents in one place.

**Core Features:**

- 💰 **Expense Tracking** - Log expenses with automatic splitting and settlement
- 📅 **Itinerary Management** - Organize daily activities and schedules
- 📎 **Document Storage** - Keep travel documents accessible to the group

Designed for multi-day group trips with multi-currency support and real-time collaboration.

---

## Tech Stack

- Ruby on Rails 7+ (API mode)
- PostgreSQL
- JWT Authentication
- Active Storage (file uploads)
- React Native mobile app (in development)

---

## API Endpoints

### Authentication
- `POST /api/v1/auth/signup` - Create new user
- `POST /api/v1/auth/login` - Login and get JWT token

### Trips
- `GET /api/v1/trips` - List user's trips
- `POST /api/v1/trips` - Create new trip
- `GET /api/v1/trips/:id` - Get trip details
- `PATCH /api/v1/trips/:id` - Update trip
- `DELETE /api/v1/trips/:id` - Delete trip
- `POST /api/v1/trips/join` - Join trip with invite code
- `GET /api/v1/trips/:id/settlement` - Calculate who owes whom

### Expenses
- `GET /api/v1/trips/:trip_id/expenses` - List trip expenses
- `POST /api/v1/trips/:trip_id/expenses` - Create expense with auto-split
- `GET /api/v1/trips/:trip_id/expenses/:id` - Get expense details
- `PATCH /api/v1/trips/:trip_id/expenses/:id` - Update expense
- `DELETE /api/v1/trips/:trip_id/expenses/:id` - Delete expense

### Itinerary
- `GET /api/v1/trips/:trip_id/itinerary_items` - List itinerary items
- `POST /api/v1/trips/:trip_id/itinerary_items` - Create itinerary item
- `GET /api/v1/trips/:trip_id/itinerary_items/:id` - Get item details
- `PATCH /api/v1/trips/:trip_id/itinerary_items/:id` - Update item
- `DELETE /api/v1/trips/:trip_id/itinerary_items/:id` - Delete item

### Documents
- `GET /api/v1/trips/:trip_id/documents` - List documents
- `POST /api/v1/trips/:trip_id/documents` - Upload document
- `GET /api/v1/trips/:trip_id/documents/:id` - Get document details
- `DELETE /api/v1/trips/:trip_id/documents/:id` - Delete document

---

## Features

- Multi-currency expense tracking with active currency switching
- Equal and custom split amounts
- Automatic settlement calculations with debt simplification
- Daily itinerary organization with time slots
- Document uploads and sharing with Active Storage
- Trip sharing via unique invite codes
- JWT-based authentication

---

## Setup

```bash
# Install dependencies
bundle install

# Setup database
rails db:create
rails db:migrate

# Start server
rails server
```

API runs on `http://localhost:3000`

---

## Development Status

**Backend API:** ✅ Complete

- ✅ Database models and associations
- ✅ JWT authentication
- ✅ All CRUD endpoints
- ✅ Settlement calculation algorithm
- ✅ File upload support

**Mobile App:** 🔄 In Progress

- 📋 React Native setup
- 📋 Authentication screens
- 📋 Trip management UI
- 📋 Expense tracking UI
- 📋 Itinerary UI
- 📋 Document management UI

**Target completion:** December 2025
