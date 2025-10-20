# TripKit API

> Backend API for a travel companion application

[![Rails](https://img.shields.io/badge/Rails-7.0+-red.svg)](https://rubyonrails.org/)
[![PostgreSQL](https://img.shields.io/badge/PostgreSQL-14+-blue.svg)](https://www.postgresql.org/)

✅ **Status:** Production Ready (v1.0)

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
- React Native mobile app

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

### ✅ Completed (v1.0)

- Multi-currency expense tracking with active currency switching
- Equal and custom split amounts
- Automatic settlement calculations with debt simplification algorithm
- Daily itinerary organization with time slots and locations
- Document uploads and metadata storage with Active Storage
- Trip sharing via unique 6-character invite codes
- JWT-based authentication with secure password hashing
- RESTful API architecture
- CORS enabled for mobile clients
- Comprehensive data validation
- Association-based data modeling

---

## Database Models

**Core Models:**
- `User` - Authentication and profile
- `Trip` - Trip details, dates, currency, invite codes
- `TripMembership` - User-Trip association with roles
- `Expense` - Expense tracking with category and split type
- `ExpenseSplit` - Individual user shares of expenses
- `ItineraryItem` - Daily activities with time and location
- `Document` - Document metadata with Active Storage attachments

---

## Setup

```bash
# Install dependencies
bundle install

# Setup database
rails db:create
rails db:migrate

# (Optional) Load sample data
rails db:seed

# Start server
rails server
```

API runs on `http://localhost:3000`

---

## Testing API

### Example Requests

**Signup:**
```bash
curl -X POST http://localhost:3000/api/v1/auth/signup \
  -H "Content-Type: application/json" \
  -d '{
    "user": {
      "name": "John Doe",
      "email": "john@example.com",
      "password": "password123",
      "password_confirmation": "password123"
    }
  }'
```

**Create Trip:**
```bash
curl -X POST http://localhost:3000/api/v1/trips \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer YOUR_TOKEN" \
  -d '{
    "trip": {
      "name": "Bali Adventure",
      "start_date": "2024-12-29",
      "end_date": "2025-01-05",
      "base_currency": "PHP",
      "total_budget": 50000
    }
  }'
```

---

## Development Status

**v1.0** ✅ (October 2024)
- All core features complete
- Database models and associations
- JWT authentication
- All CRUD endpoints
- Settlement calculation algorithm
- File upload support
- Multi-currency support
- Fully tested and production-ready

---

## Deployment

Ready to deploy to:
- Heroku
- Railway
- Render
- AWS / DigitalOcean

**Environment Variables Needed:**
- `DATABASE_URL` - PostgreSQL connection string
- `SECRET_KEY_BASE` - Rails secret key
- Storage configuration for Active Storage (S3, etc.)

---

## Future Enhancements (v2.0)

- API documentation with Swagger/Postman
- Rate limiting
- API versioning
- Background jobs for notifications
- Performance optimization
- Caching layer (Redis)
- Admin dashboard
- Analytics endpoints

---

**Mobile App:** [github.com/lmagsino/TripKitApp](https://github.com/lmagsino/TripKitApp)

**Version:** 1.0.0  
**Last Updated:** October 2024