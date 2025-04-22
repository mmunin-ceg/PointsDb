import express, { Router } from "express"
import { AppDataSource } from "../data-source"
import { ApiProvider } from "../entity/ApiProvider"

const router = Router()
const repository = AppDataSource.getRepository(ApiProvider)

// Get all API providers
router.get("/", async (req, res) => {
    try {
        const providers = await repository.find()
        res.json(providers)
    } catch (error) {
        res.status(500).json({ message: "Error fetching providers" })
    }
})

// Get single API provider
router.get("/:id", async (req, res) => {
    try {
        const provider = await repository.findOne({
            where: { id: parseInt(req.params.id) },
            relations: ["dataInterfaces"]
        })
        if (!provider) {
            return res.status(404).json({ message: "Provider not found" })
        }
        res.json(provider)
    } catch (error) {
        res.status(500).json({ message: "Error fetching provider" })
    }
})

// Create new API provider
router.post("/", async (req, res) => {
    try {
        const provider = repository.create(req.body)
        const result = await repository.save(provider)
        res.status(201).json(result)
    } catch (error) {
        res.status(500).json({ message: "Error creating provider" })
    }
})

// Update API provider
router.put("/:id", async (req, res) => {
    try {
        const provider = await repository.findOneBy({ id: parseInt(req.params.id) })
        if (!provider) {
            return res.status(404).json({ message: "Provider not found" })
        }
        repository.merge(provider, req.body)
        const result = await repository.save(provider)
        res.json(result)
    } catch (error) {
        res.status(500).json({ message: "Error updating provider" })
    }
})

// Delete API provider
router.delete("/:id", async (req, res) => {
    try {
        const result = await repository.delete(req.params.id)
        if (result.affected === 0) {
            return res.status(404).json({ message: "Provider not found" })
        }
        res.status(204).send()
    } catch (error) {
        res.status(500).json({ message: "Error deleting provider" })
    }
})

export default router