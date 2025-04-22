import { DataSource } from "typeorm"
import { ApiProvider } from "./entity/ApiProvider"
import { DataInterface } from "./entity/DataInterface"
import { MapVersion } from "./entity/MapVersion"
import { MapPoint } from "./entity/MapPoint"
import { Project } from "./entity/Project"
import { ProjectMapUsage } from "./entity/ProjectMapUsage"

export const AppDataSource = new DataSource({
    type: "postgres",
    host: process.env.POSTGRES_HOST || "localhost",
    port: 5432,
    username: process.env.POSTGRES_USER || "mmunin",
    password: process.env.POSTGRES_PASSWORD || "Password1!",
    database: process.env.POSTGRES_DB || "points",
    synchronize: process.env.NODE_ENV !== "production", // Only sync in development
    logging: true, // Enable detailed logging
    logger: "advanced-console",
    entities: [ApiProvider, DataInterface, MapVersion, MapPoint, Project, ProjectMapUsage],
    migrations: [],
    subscribers: [],
})