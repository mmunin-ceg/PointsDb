import express, { Router, Request, Response, NextFunction } from "express"
import { AppDataSource } from "../data-source"
import { MapVersion } from "../entity/MapVersion"

const router = Router()
const repository = AppDataSource.getRepository(MapVersion)

interface RouteParams {
    id: string;
    interfaceId: string;
}

interface CreateVersionBody {
    interface_id: number;
    version: string;
    release_date?: string;
    changelog?: string;
}

// Get all versions
const getAllVersions = async (_req: Request, res: Response, next: NextFunction): Promise<void> => {
    try {
        const versions = await repository.find({
            relations: ["interface", "points"]
        })
        res.json(versions)
    } catch (error) {
        next(error)
    }
}

// Get single version
const getVersion = async (req: Request<RouteParams>, res: Response, next: NextFunction): Promise<void> => {
    try {
        if (!req.params.id) {
            res.status(400).json({ message: "Version ID is required" })
            return
        }
        const version = await repository.findOne({
            where: { id: parseInt(req.params.id) },
            relations: ["interface", "points"]
        })
        if (!version) {
            res.status(404).json({ message: "Version not found" })
            return
        }
        res.json(version)
    } catch (error) {
        next(error)
    }
}

// Get versions by interface
const getVersionsByInterface = async (req: Request<RouteParams>, res: Response, next: NextFunction): Promise<void> => {
    try {
        if (!req.params.interfaceId) {
            res.status(400).json({ message: "Interface ID is required" })
            return
        }
        const versions = await repository.find({
            where: { interface: { id: parseInt(req.params.interfaceId) } },
            relations: ["interface", "points"]
        })
        res.json(versions)
    } catch (error) {
        next(error)
    }
}

// Create version
const createVersion = async (req: Request<{}, any, CreateVersionBody>, res: Response, next: NextFunction): Promise<void> => {
    try {
        // Create a proper entity object with the interface relation
        const version = repository.create({
            ...req.body,
            interface: { id: req.body.interface_id }
        })
        const saveResult = await repository.save(version)
        const result = Array.isArray(saveResult) ? saveResult[0] : saveResult

        // Return the saved version with its relationships loaded
        const savedVersion = await repository.findOne({
            where: { id: result.id },
            relations: ["interface", "points"]
        })
        res.status(201).json(savedVersion)
    } catch (error) {
        next(error)
    }
}

// Update version
const updateVersion = async (req: Request<RouteParams, any, Partial<CreateVersionBody>>, res: Response, next: NextFunction): Promise<void> => {
    try {
        if (!req.params.id) {
            res.status(400).json({ message: "Version ID is required" })
            return
        }
        const version = await repository.findOneBy({ id: parseInt(req.params.id) })
        if (!version) {
            res.status(404).json({ message: "Version not found" })
            return
        }
        repository.merge(version, req.body)
        const result = await repository.save(version)
        res.json(result)
    } catch (error) {
        next(error)
    }
}

// Delete version
const deleteVersion = async (req: Request<RouteParams>, res: Response, next: NextFunction): Promise<void> => {
    try {
        if (!req.params.id) {
            res.status(400).json({ message: "Version ID is required" })
            return
        }
        const result = await repository.delete(req.params.id)
        if (result.affected === 0) {
            res.status(404).json({ message: "Version not found" })
            return
        }
        res.status(204).send()
    } catch (error) {
        next(error)
    }
}

// Route handlers
router.get("/", getAllVersions)
router.get("/interface/:interfaceId", getVersionsByInterface)
router.get("/:id", getVersion)
router.post("/", express.json(), createVersion)
router.put("/:id", express.json(), updateVersion)
router.delete("/:id", deleteVersion)

export default router