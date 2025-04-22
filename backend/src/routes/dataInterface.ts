import express, { Router } from "express"
import { AppDataSource } from "../data-source"
import { DataInterface } from "../entity/DataInterface"

const router = Router()
const repository = AppDataSource.getRepository(DataInterface)

// Get all interfaces
router.get("/", async (req, res) => {
    try {
        const interfaces = await repository.find({
            relations: ["provider", "mapVersions"]
        })
        res.json(interfaces)
    } catch (error) {
        res.status(500).json({ message: "Error fetching interfaces" })
    }
})

// Get single interface
router.get("/:id", async (req, res) => {
    try {
        const interface_ = await repository.findOne({
            where: { id: parseInt(req.params.id) },
            relations: ["provider", "mapVersions"]
        })
        if (!interface_) {
            return res.status(404).json({ message: "Interface not found" })
        }
        res.json(interface_)
    } catch (error) {
        res.status(500).json({ message: "Error fetching interface" })
    }
})

// Create interface
router.post("/", async (req, res) => {
    try {
        const interface_ = repository.create(req.body)
        const result = await repository.save(interface_)
        res.status(201).json(result)
    } catch (error) {
        res.status(500).json({ message: "Error creating interface" })
    }
})

// Update interface
router.put("/:id", async (req, res) => {
    try {
        const interface_ = await repository.findOneBy({ id: parseInt(req.params.id) })
        if (!interface_) {
            return res.status(404).json({ message: "Interface not found" })
        }
        repository.merge(interface_, req.body)
        const result = await repository.save(interface_)
        res.json(result)
    } catch (error) {
        res.status(500).json({ message: "Error updating interface" })
    }
})

// Delete interface
router.delete("/:id", async (req, res) => {
    try {
        const result = await repository.delete(req.params.id)
        if (result.affected === 0) {
            return res.status(404).json({ message: "Interface not found" })
        }
        res.status(204).send()
    } catch (error) {
        res.status(500).json({ message: "Error deleting interface" })
    }
})

export default router