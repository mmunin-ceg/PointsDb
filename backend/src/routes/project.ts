import express, { Router, Request, Response, NextFunction } from "express"
import { AppDataSource } from "../data-source"
import { Project } from "../entity/Project"
import { ProjectMapUsage } from "../entity/ProjectMapUsage"
import { DataInterface } from "../entity/DataInterface"
import { MapVersion } from "../entity/MapVersion"

const router = Router()
const projectRepository = AppDataSource.getRepository(Project)
const usageRepository = AppDataSource.getRepository(ProjectMapUsage)
const interfaceRepository = AppDataSource.getRepository(DataInterface)
const versionRepository = AppDataSource.getRepository(MapVersion)

interface RouteParams {
    id: string;
    usageId: string;
}

interface CreateProjectBody {
    name: string;
    location?: string;
    notes?: string;
}

interface CreateMapUsageBody {
    interface_id: number;
    version_id: number;
    notes?: string;
}

// Get all projects
const getAllProjects = async (_req: Request, res: Response, next: NextFunction): Promise<void> => {
    try {
        const projects = await projectRepository.find({
            relations: ["mapUsages", "mapUsages.interface", "mapUsages.version"]
        })
        res.json(projects)
    } catch (error) {
        next(error)
    }
}

// Get single project
const getProject = async (req: Request<RouteParams>, res: Response, next: NextFunction): Promise<void> => {
    try {
        if (!req.params.id) {
            res.status(400).json({ message: "Project ID is required" })
            return
        }
        const project = await projectRepository.findOne({
            where: { id: parseInt(req.params.id) },
            relations: ["mapUsages", "mapUsages.interface", "mapUsages.version"]
        })
        if (!project) {
            res.status(404).json({ message: "Project not found" })
            return
        }
        res.json(project)
    } catch (error) {
        next(error)
    }
}

// Get project map usages
const getProjectMapUsages = async (req: Request<RouteParams>, res: Response, next: NextFunction): Promise<void> => {
    try {
        if (!req.params.id) {
            res.status(400).json({ message: "Project ID is required" })
            return
        }
        const project = await projectRepository.findOne({
            where: { id: parseInt(req.params.id) },
            relations: ["mapUsages", "mapUsages.interface", "mapUsages.version"]
        })
        if (!project) {
            res.status(404).json({ message: "Project not found" })
            return
        }
        res.json(project.mapUsages)
    } catch (error) {
        next(error)
    }
}

// Create project
const createProject = async (req: Request<{}, any, CreateProjectBody>, res: Response, next: NextFunction): Promise<void> => {
    try {
        const project = projectRepository.create(req.body)
        const result = await projectRepository.save(project)
        res.status(201).json(result)
    } catch (error) {
        next(error)
    }
}

// Add map usage to project
const addMapUsage = async (req: Request<RouteParams, any, CreateMapUsageBody>, res: Response, next: NextFunction): Promise<void> => {
    try {
        if (!req.params.id) {
            res.status(400).json({ message: "Project ID is required" })
            return
        }

        const { interface_id, version_id, notes } = req.body
        
        // Get project
        const project = await projectRepository.findOneBy({ id: parseInt(req.params.id) })
        if (!project) {
            res.status(404).json({ message: "Project not found" })
            return
        }

        // Get interface
        const interface_ = await interfaceRepository.findOneBy({ id: interface_id })
        if (!interface_) {
            res.status(404).json({ message: "Interface not found" })
            return
        }

        // Get version
        const version = await versionRepository.findOneBy({ id: version_id })
        if (!version) {
            res.status(404).json({ message: "Version not found" })
            return
        }

        // Create usage with explicit relations
        const usage = usageRepository.create({
            project,
            interface: interface_,
            version,
            notes
        })

        const result = await usageRepository.save(usage)
        
        // Load relations for response
        const savedUsage = await usageRepository.findOne({
            where: { id: result.id },
            relations: ["interface", "version"]
        })
        
        res.status(201).json(savedUsage)
    } catch (error) {
        next(error)
    }
}

// Update project
const updateProject = async (req: Request<RouteParams, any, Partial<CreateProjectBody>>, res: Response, next: NextFunction): Promise<void> => {
    try {
        if (!req.params.id) {
            res.status(400).json({ message: "Project ID is required" })
            return
        }
        const project = await projectRepository.findOneBy({ id: parseInt(req.params.id) })
        if (!project) {
            res.status(404).json({ message: "Project not found" })
            return
        }
        projectRepository.merge(project, req.body)
        const result = await projectRepository.save(project)
        res.json(result)
    } catch (error) {
        next(error)
    }
}

// Delete project
const deleteProject = async (req: Request<RouteParams>, res: Response, next: NextFunction): Promise<void> => {
    try {
        if (!req.params.id) {
            res.status(400).json({ message: "Project ID is required" })
            return
        }
        const result = await projectRepository.delete(req.params.id)
        if (result.affected === 0) {
            res.status(404).json({ message: "Project not found" })
            return
        }
        res.status(204).send()
    } catch (error) {
        next(error)
    }
}

// Delete map usage
const deleteMapUsage = async (req: Request<RouteParams>, res: Response, next: NextFunction): Promise<void> => {
    try {
        if (!req.params.usageId) {
            res.status(400).json({ message: "Usage ID is required" })
            return
        }
        const result = await usageRepository.delete(req.params.usageId)
        if (result.affected === 0) {
            res.status(404).json({ message: "Map usage not found" })
            return
        }
        res.status(204).send()
    } catch (error) {
        next(error)
    }
}

// Route handlers
router.get("/", getAllProjects)
router.get("/:id", getProject)
router.get("/:id/map-usages", getProjectMapUsages)
router.post("/", express.json(), createProject)
router.post("/:id/map-usages", express.json(), addMapUsage)
router.put("/:id", express.json(), updateProject)
router.delete("/:id", deleteProject)
router.delete("/:id/map-usages/:usageId", deleteMapUsage)

export default router