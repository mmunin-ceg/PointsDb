import express, { Router, Request, Response, NextFunction } from "express"
import { AppDataSource } from "../data-source"
import { ApiProvider } from "../entity/ApiProvider"

const router = Router()
const repository = AppDataSource.getRepository(ApiProvider)

interface RouteParams {
    id: string;
}

// Get all API providers
const getAllProviders = async (_req: Request, res: Response, next: NextFunction): Promise<void> => {
    try {
        const providers = await repository.find()
        res.json(providers)
    } catch (error) {
        next(error)
    }
}

// Get single API provider
const getProvider = async (req: Request<RouteParams>, res: Response, next: NextFunction): Promise<void> => {
    try {
        if (!req.params.id) {
            res.status(400).json({ message: "Provider ID is required" })
            return
        }
        const provider = await repository.findOne({
            where: { id: parseInt(req.params.id) },
            relations: ["dataInterfaces"]
        })
        if (!provider) {
            res.status(404).json({ message: "Provider not found" })
            return
        }
        res.json(provider)
    } catch (error) {
        next(error)
    }
}

// Create new API provider
const createProvider = async (req: Request, res: Response, next: NextFunction): Promise<void> => {
    try {
        const provider = repository.create(req.body)
        const result = await repository.save(provider)
        res.status(201).json(result)
    } catch (error) {
        next(error)
    }
}

// Update API provider
const updateProvider = async (req: Request<RouteParams>, res: Response, next: NextFunction): Promise<void> => {
    try {
        if (!req.params.id) {
            res.status(400).json({ message: "Provider ID is required" })
            return
        }
        const provider = await repository.findOneBy({ id: parseInt(req.params.id) })
        if (!provider) {
            res.status(404).json({ message: "Provider not found" })
            return
        }
        repository.merge(provider, req.body)
        const result = await repository.save(provider)
        res.json(result)
    } catch (error) {
        next(error)
    }
}

// Delete API provider
const deleteProvider = async (req: Request<RouteParams>, res: Response, next: NextFunction): Promise<void> => {
    try {
        if (!req.params.id) {
            res.status(400).json({ message: "Provider ID is required" })
            return
        }
        const result = await repository.delete(req.params.id)
        if (result.affected === 0) {
            res.status(404).json({ message: "Provider not found" })
            return
        }
        res.status(204).send()
    } catch (error) {
        next(error)
    }
}

// Route handlers
router.get("/", getAllProviders)
router.get("/:id", getProvider)
router.post("/", express.json(), createProvider)
router.put("/:id", express.json(), updateProvider)
router.delete("/:id", deleteProvider)

export default router