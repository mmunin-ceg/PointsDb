import "reflect-metadata"
import express from 'express'
import cors from 'cors'
import helmet from 'helmet'
import { AppDataSource } from "./data-source"
import apiProviderRouter from "./routes/apiProvider"
import dataInterfaceRouter from "./routes/dataInterface"
import mapVersionRouter from "./routes/mapVersion"
import mapPointRouter from "./routes/mapPoint"
import projectRouter from "./routes/project"
import { errorHandler } from './middleware/errorHandler'

const app = express()

// Security middleware
app.use(helmet())
app.use(cors({
  origin: process.env.CORS_ORIGIN || 'http://localhost:80',
  methods: ['GET', 'POST', 'PUT', 'DELETE'],
  allowedHeaders: ['Content-Type', 'Authorization']
}))

app.use(express.json())

// Register routes
app.use('/api-providers', apiProviderRouter)
app.use('/data-interfaces', dataInterfaceRouter)
app.use('/map-versions', mapVersionRouter)
app.use('/map-points', mapPointRouter)
app.use('/projects', projectRouter)


// Initialize database connection
AppDataSource.initialize()
  .then(() => {
    console.log("Data Source has been initialized!")
    const port = process.env.PORT || 3000
    app.listen(port, () => {
      console.log(`Server is running on port ${port}`)
    })
  })
  .catch((err) => {
    console.error("Error during Data Source initialization:", err)
  })