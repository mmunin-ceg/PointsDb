import express, { Router } from "express"
import { AppDataSource } from "../data-source"
import { MapVersion } from "../entity/MapVersion"

const router = Router()
const repository = AppDataSource.getRepository(MapVersion)

// Get all versions
router.get("/", async (req, res) => {
    try {
        const versions = await repository.find({
            relations: ["interface", "points"]
        })
        res.json(versions)
    } catch (error) {
        res.status(500).json({ message: "Error fetching versions" })
    }
})

// Get single version
router.get("/:id", async (req, res) => {
    try {
        const version = await repository.findOne({
            where: { id: parseInt(req.params.id) },
            relations: ["interface", "points"]
        })
        if (!version) {
            return res.status(404).json({ message: "Version not found" })
        }
        res.json(version)
    } catch (error) {
        res.status(500).json({ message: "Error fetching version" })
    }
})

// Get versions by interface
router.get("/interface/:interfaceId", async (req, res) => {
    try {
        const versions = await repository.find({
            where: { interface: { id: parseInt(req.params.interfaceId) } },
            relations: ["interface", "points"]
        })
        res.json(versions)
    } catch (error) {
        res.status(500).json({ message: "Error fetching versions" })
    }
})

// Create version
router.post("/", async (req, res) => {
    try {
        const version = repository.create(req.body)
        const result = await repository.save(version)
        res.status(201).json(result)
    } catch (error) {
        res.status(500).json({ message: "Error creating version" })
    }
})

// Update version
router.put("/:id", async (req, res) => {
    try {
        const version = await repository.findOneBy({ id: parseInt(req.params.id) })
        if (!version) {
            return res.status(404).json({ message: "Version not found" })
        }
        repository.merge(version, req.body)
        const result = await repository.save(version)
        res.json(result)
    } catch (error) {
        res.status(500).json({ message: "Error updating version" })
    }
})

// Delete version
router.delete("/:id", async (req, res) => {
    try {
        const result = await repository.delete(req.params.id)
        if (result.affected === 0) {
            return res.status(404).json({ message: "Version not found" })
        }
        res.status(204).send()
    } catch (error) {
        res.status(500).json({ message: "Error deleting version" })
    }
})

export default router