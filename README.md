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

### api_provider
Tracks sources of APIs (vendors or internal)
- **id**: Primary key
- **name**: Unique provider name (text)
- **is_internal**: Boolean flag for internal/external provider
- **dataInterfaces**: One-to-many relationship with data_interface table

### data_interface
Defines data link interfaces (e.g., Met Tower, Sungrow SG4400)
- **id**: Primary key
- **name**: Unique interface name (text, max 200 chars)
- **protocol**: Enum ("Modbus", "DNP3", "SEL", "Other")
- **provider_id**: Foreign key to api_provider
- **is_internal**: Boolean flag
- **description**: Optional description (text, max 1000 chars)

### map_version
Manages versions of data maps
- **id**: Primary key
- **interface_id**: Foreign key to data_interface
- **version**: Version identifier (text)
- **release_date**: Optional release date
- **changelog**: Optional changelog text
- **points**: One-to-many relationship with map_point table

### map_point
Stores individual points in a map version
- **id**: Primary key
- **version_id**: Foreign key to map_version
- **point_name**: Point identifier (text, max 200 chars)
- **object_name**: Object name (text)
- **register**: Register address (text)
- **data_type**: Data type (text)
- **bit_offset**: Optional bit offset (text)
- **units**: Optional units (text)
- **scale**: Optional scaling factor (real number)
- **alarm_state**: Optional alarm state (text)
- **on_state**: Optional on state (text)
- **off_state**: Optional off state (text)
- **alarm_limits**: Optional alarm limits (text)
- **alarm_profile**: Optional alarm profile (text)
- **enumeration_table**: Optional enumeration table (text)
- **comments**: Optional comments (text)

### project
Tracks projects or sites
- **id**: Primary key
- **name**: Project name (text, max 200 chars)
- **location**: Optional location (text, max 500 chars)
- **notes**: Optional notes (text, max 1000 chars)
- **mapUsages**: One-to-many relationship with project_map_usage table

### project_map_usage
Links projects to specific map versions
- **id**: Primary key
- **project_id**: Foreign key to project
- **interface_id**: Foreign key to data_interface
- **version_id**: Foreign key to map_version
- **notes**: Optional notes (text)
