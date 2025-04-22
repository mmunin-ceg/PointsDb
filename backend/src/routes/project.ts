import express, { Router } from "express"
import { AppDataSource } from "../data-source"
import { Project } from "../entity/Project"
import { ProjectMapUsage } from "../entity/ProjectMapUsage"

const router = Router()
const projectRepository = AppDataSource.getRepository(Project)
const usageRepository = AppDataSource.getRepository(ProjectMapUsage)

// Get all projects
router.get("/", async (req, res) => {
    try {
        const projects = await projectRepository.find({
            relations: ["mapUsages", "mapUsages.interface", "mapUsages.version"]
        })
        res.json(projects)
    } catch (error) {
        res.status(500).json({ message: "Error fetching projects" })
    }
})

// Get single project
router.get("/:id", async (req, res) => {
    try {
        const project = await projectRepository.findOne({
            where: { id: parseInt(req.params.id) },
            relations: ["mapUsages", "mapUsages.interface", "mapUsages.version"]
        })
        if (!project) {
            return res.status(404).json({ message: "Project not found" })
        }
        res.json(project)
    } catch (error) {
        res.status(500).json({ message: "Error fetching project" })
    }
})

// Get project map usages
router.get("/:id/map-usages", async (req, res) => {
    try {
        const project = await projectRepository.findOne({
            where: { id: parseInt(req.params.id) },
            relations: ["mapUsages", "mapUsages.interface", "mapUsages.version"]
        })
        if (!project) {
            return res.status(404).json({ message: "Project not found" })
        }
        res.json(project.mapUsages)
    } catch (error) {
        res.status(500).json({ message: "Error fetching project map usages" })
    }
})

// Create project
router.post("/", async (req, res) => {
    try {
        const project = projectRepository.create(req.body)
        const result = await projectRepository.save(project)
        res.status(201).json(result)
    } catch (error) {
        res.status(500).json({ message: "Error creating project" })
    }
})

// Add map usage to project
router.post("/:id/map-usages", async (req, res) => {
    try {
        const project = await projectRepository.findOneBy({ id: parseInt(req.params.id) })
        if (!project) {
            return res.status(404).json({ message: "Project not found" })
        }
        const usage = usageRepository.create({
            ...req.body,
            project
        })
        const result = await usageRepository.save(usage)
        res.status(201).json(result)
    } catch (error) {
        res.status(500).json({ message: "Error adding map usage" })
    }
})

// Update project
router.put("/:id", async (req, res) => {
    try {
        const project = await projectRepository.findOneBy({ id: parseInt(req.params.id) })
        if (!project) {
            return res.status(404).json({ message: "Project not found" })
        }
        projectRepository.merge(project, req.body)
        const result = await projectRepository.save(project)
        res.json(result)
    } catch (error) {
        res.status(500).json({ message: "Error updating project" })
    }
})

// Delete project
router.delete("/:id", async (req, res) => {
    try {
        const result = await projectRepository.delete(req.params.id)
        if (result.affected === 0) {
            return res.status(404).json({ message: "Project not found" })
        }
        res.status(204).send()
    } catch (error) {
        res.status(500).json({ message: "Error deleting project" })
    }
})

// Delete map usage
router.delete("/:id/map-usages/:usageId", async (req, res) => {
    try {
        const result = await usageRepository.delete(req.params.usageId)
        if (result.affected === 0) {
            return res.status(404).json({ message: "Map usage not found" })
        }
        res.status(204).send()
    } catch (error) {
        res.status(500).json({ message: "Error removing map usage" })
    }
})

export default router