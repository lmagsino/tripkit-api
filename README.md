# TripKit API

> Backend API for a travel companion application

[![Rails](https://img.shields.io/badge/Rails-7.0+-red.svg)](https://rubyonrails.org/)
[![PostgreSQL](https://img.shields.io/badge/PostgreSQL-14+-blue.svg)](https://www.postgresql.org/)

🚧 **Status:** In Development

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

## Features

- Multi-currency expense tracking
- Equal and custom split amounts
- Real-time settlement calculations
- Daily itinerary organization
- Document uploads and sharing
- Trip invite codes

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

- ✅ Project setup
- 🔄 Database schema
- 📋 Authentication
- 📋 API endpoints
- 📋 Mobile app

Target: December 2025
