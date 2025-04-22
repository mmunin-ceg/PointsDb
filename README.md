# PointsDb

A full-stack application for managing industrial data point mappings across different protocols, devices, and projects.

## Overview

PointsDb is designed to manage and track data point mappings for industrial automation systems. It provides a centralized repository for:
- API Provider configurations
- Data interface definitions
- Map versions and their points
- Project-specific mapping implementations

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

- **Development:**
  - Docker
  - Docker Compose
  - ESLint

## Getting Started

### Prerequisites

- Docker and Docker Compose
- Node.js
- PostgreSQL

### Installation

1. Clone the repository
2. Start the services using Docker Compose:
   ```bash
   docker-compose up -d
   ```

This will start both the frontend and backend services, along with the PostgreSQL database.

### Development Setup

#### Backend
```bash
cd backend
npm install
npm run dev
```

#### Frontend
```bash
cd frontend
npm install
npm run dev
```

## Database Schema

The application uses a PostgreSQL database with the following main tables:

- **api_provider**: Tracks sources of APIs (vendors or internal)
- **data_interface**: Defines data link interfaces (e.g., Met Tower, Sungrow SG4400)
- **map_version**: Manages versions of data maps
- **map_point**: Stores individual points in a map version
- **project**: Tracks projects or sites
- **project_map_usage**: Links projects to specific map versions

## License

[Add your license here]

## Contributing

[Add contribution guidelines here]