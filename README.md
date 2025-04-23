# PointsDb

A full-stack application for managing internal and third-party Modbus and DNP3 point mappings.

## Features

- Management of API providers (vendors and internal sources)
- Data interface tracking with protocol specifications
- Version control for data maps
- Detailed point mapping configuration
- Project-specific implementation tracking
- Full REST API backend
- React-based frontend interface

## Tech Stack

- **Frontend:**
  - React
  - TypeScript
  - Vite
  - CSS

- **Backend:**
  - Node.js
  - TypeScript
  - TypeORM
  - PostgreSQL

## Getting Started

### Prerequisites

- Docker Desktop for windows (WSL2), Docker for linux

### Installation

1. Clone the repository
2. Start the services using Docker Compose:
   ```bash
   docker compose up -d
   ```
3. navigate to http://localhost:80

This will build both the frontend and backend services, and start them along with the PostgreSQL database. The web interface is on port 80

## Database Schema

The application uses a PostgreSQL database with the following main tables:

- **api_provider**: Tracks sources of APIs (vendors or internal)
- **data_interface**: Defines data link interfaces (e.g., Met Tower, Sungrow SG4400)
- **map_version**: Manages versions of data maps
- **map_point**: Stores individual points in a map version
- **project**: Tracks projects or sites
- **project_map_usage**: Links projects to specific map versions
