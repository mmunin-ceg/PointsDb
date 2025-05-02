import express, { Router, Request, Response, NextFunction } from "express"
import { AppDataSource } from "../data-source"
import { DataInterface } from "../entity/DataInterface"

const router = Router()
const repository = AppDataSource.getRepository(DataInterface)

interface RouteParams {
    id: string;
}

interface CreateInterfaceBody {
    name: string;
    protocol: string;
    provider_id: number;
    is_internal: boolean;
    description?: string;
}

// Get all interfaces
const getAllInterfaces = async (_req: Request, res: Response, next: NextFunction): Promise<void> => {
    try {
        const interfaces = await repository.find({
            relations: ["provider", "mapVersions"]
        })
        res.json(interfaces)
    } catch (error) {
        next(error)
    }
}

// Get single interface
const getInterface = async (req: Request<RouteParams>, res: Response, next: NextFunction): Promise<void> => {
    try {
        if (!req.params.id) {
            res.status(400).json({ message: "Interface ID is required" })
            return
        }
        const interface_ = await repository.findOne({
            where: { id: parseInt(req.params.id) },
            relations: ["provider", "mapVersions"]
        })
        if (!interface_) {
            res.status(404).json({ message: "Interface not found" })
            return
        }
        res.json(interface_)
    } catch (error) {
        next(error)
    }
}

// Create interface
const createInterface = async (req: Request<{}, any, CreateInterfaceBody>, res: Response, next: NextFunction): Promise<void> => {
    try {
        const { provider_id, ...rest } = req.body
        const provider = await AppDataSource.getRepository("ApiProvider").findOneBy({ id: provider_id })
        
        if (!provider) {
            res.status(400).json({ message: "Provider not found" })
            return
        }

        const interface_ = repository.create({ ...rest, provider })
        const result = await repository.save(interface_)
        res.status(201).json(result)
    } catch (error) {
        next(error)
    }
}

// Update interface
const updateInterface = async (req: Request<RouteParams, any, Partial<CreateInterfaceBody>>, res: Response, next: NextFunction): Promise<void> => {
    try {
        if (!req.params.id) {
            res.status(400).json({ message: "Interface ID is required" })
            return
        }
        const interface_ = await repository.findOneBy({ id: parseInt(req.params.id) })
        if (!interface_) {
            res.status(404).json({ message: "Interface not found" })
            return
        }

        const { provider_id, ...rest } = req.body
        if (provider_id) {
            const provider = await AppDataSource.getRepository("ApiProvider").findOneBy({ id: provider_id })
            if (!provider) {
                res.status(400).json({ message: "Provider not found" })
                return
            }
            repository.merge(interface_, { ...rest, provider })
        } else {
            repository.merge(interface_, rest)
        }

        const result = await repository.save(interface_)
        res.json(result)
    } catch (error) {
        next(error)
    }
}

// Delete interface
const deleteInterface = async (req: Request<RouteParams>, res: Response, next: NextFunction): Promise<void> => {
    try {
        if (!req.params.id) {
            res.status(400).json({ message: "Interface ID is required" })
            return
        }
        const result = await repository.delete(req.params.id)
        if (result.affected === 0) {
            res.status(404).json({ message: "Interface not found" })
            return
        }
        res.status(204).send()
    } catch (error) {
        next(error)
    }
}

// Route handlers
router.get("/", getAllInterfaces)
router.get("/:id", getInterface)
router.post("/", express.json(), createInterface)
router.put("/:id", express.json(), updateInterface)
router.delete("/:id", deleteInterface)

export default router