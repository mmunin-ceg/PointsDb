import express, { Router } from "express"
import { validate } from "class-validator"
import ExcelJS from 'exceljs'
import { AppDataSource } from "../data-source"
import { MapPoint } from "../entity/MapPoint"

const router = Router()
const repository = AppDataSource.getRepository(MapPoint)

// Get all points
router.get("/", async (req, res) => {
    try {
        const points = await repository.find({
            relations: ["version"]
        })
        res.json(points)
    } catch (error) {
        res.status(500).json({ message: "Error fetching points" })
    }
})

// Get points by version
router.get("/version/:versionId", async (req, res) => {
    try {
        const points = await repository.find({
            where: { version: { id: parseInt(req.params.versionId) } },
            relations: ["version"]
        })
        res.json(points)
    } catch (error) {
        res.status(500).json({ message: "Error fetching points" })
    }
})

// Get single point
router.get("/:id", async (req, res) => {
    try {
        const point = await repository.findOne({
            where: { id: parseInt(req.params.id) },
            relations: ["version"]
        })
        if (!point) {
            return res.status(404).json({ message: "Point not found" })
        }
        res.json(point)
    } catch (error) {
        res.status(500).json({ message: "Error fetching point" })
    }
})

// Create point with validation
router.post("/", async (req, res) => {
    try {
        const point = repository.create(req.body)
        
        // Validate the entity
        const errors = await validate(point)
        if (errors.length > 0) {
            return res.status(400).json({
                message: "Validation failed",
                errors: errors.map(error => ({
                    property: error.property,
                    constraints: error.constraints
                }))
            })
        }

        const result = await repository.save(point)
        res.status(201).json(result)
    } catch (error: any) {
        res.status(500).json({ 
            message: "Error creating point",
            error: error.message
        })
    }
})

// Bulk create points with validation
router.post("/bulk", async (req, res) => {
    try {
        const points = repository.create(req.body)
        
        // Validate all points
        const validationPromises = Array.isArray(points) 
            ? points.map(point => validate(point))
            : [validate(points)]
            
        const validationResults = await Promise.all(validationPromises)
        const errors = validationResults.flatMap((result, index) => 
            result.map(error => ({
                point: index,
                property: error.property,
                constraints: error.constraints
            }))
        )

        if (errors.length > 0) {
            return res.status(400).json({
                message: "Validation failed",
                errors
            })
        }

        const result = await repository.save(points)
        res.status(201).json(result)
    } catch (error: any) {
        res.status(500).json({ 
            message: "Error creating points",
            error: error.message
        })
    }
})

// Update point with validation
router.put("/:id", async (req, res) => {
    try {
        const point = await repository.findOneBy({ id: parseInt(req.params.id) })
        if (!point) {
            return res.status(404).json({ message: "Point not found" })
        }

        repository.merge(point, req.body)
        
        // Validate the updated entity
        const errors = await validate(point)
        if (errors.length > 0) {
            return res.status(400).json({
                message: "Validation failed",
                errors: errors.map(error => ({
                    property: error.property,
                    constraints: error.constraints
                }))
            })
        }

        const result = await repository.save(point)
        res.json(result)
    } catch (error: any) {
        res.status(500).json({ 
            message: "Error updating point",
            error: error.message
        })
    }
})

// Delete point
router.delete("/:id", async (req, res) => {
    try {
        const result = await repository.delete(req.params.id)
        if (result.affected === 0) {
            return res.status(404).json({ message: "Point not found" })
        }
        res.status(204).send()
    } catch (error) {
        res.status(500).json({ message: "Error deleting point" })
    }
})

// Delete all points for a version
router.delete("/version/:versionId", async (req, res) => {
    try {
        const result = await repository.delete({ 
            version: { id: parseInt(req.params.versionId) } 
        })
        res.status(204).send()
    } catch (error) {
        res.status(500).json({ message: "Error deleting points" })
    }
})

// Export points as Excel
router.get("/version/:versionId/export", async (req, res) => {
    try {
        const points = await repository.find({
            where: { version: { id: parseInt(req.params.versionId) } },
            relations: ["version"]
        })

        // Create workbook and worksheet
        const wb = new ExcelJS.Workbook()
        const ws = wb.addWorksheet('Points')

        // Add headers
        const headers = [
            'point_name',
            'object_name',
            'register',
            'data_type',
            'bit_offset',
            'units',
            'scale',
            'alarm_state',
            'on_state',
            'off_state',
            'alarm_limits',
            'alarm_profile',
            'enumeration_table',
            'comments'
        ]
        ws.addRow(headers)

        // Add data rows
        points.forEach(point => {
            ws.addRow([
                point.point_name,
                point.object_name,
                point.register,
                point.data_type,
                point.bit_offset || '',
                point.units || '',
                point.scale || '',
                point.alarm_state || '',
                point.on_state || '',
                point.off_state || '',
                point.alarm_limits || '',
                point.alarm_profile || '',
                point.enumeration_table || '',
                point.comments || ''
            ])
        })

        // Generate Excel file
        const buffer = await wb.xlsx.writeBuffer()
        
        res.setHeader('Content-Type', 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet')
        res.setHeader('Content-Disposition', `attachment; filename="map_points_${req.params.versionId}.xlsx"`)
        res.send(buffer)
    } catch (error) {
        res.status(500).json({ message: "Error exporting points" })
    }
})

// Replace all points for a version
router.post("/version/:versionId/replace", async (req, res) => {
    const queryRunner = AppDataSource.createQueryRunner()
    await queryRunner.connect()
    await queryRunner.startTransaction()

    try {
        // Delete existing points
        await queryRunner.manager.delete(MapPoint, { 
            version: { id: parseInt(req.params.versionId) } 
        })

        // Create new points with validation
        const points = queryRunner.manager.create(MapPoint, req.body)
        
        // Validate all points
        const validationPromises = Array.isArray(points) 
            ? points.map(point => validate(point))
            : [validate(points)]
            
        const validationResults = await Promise.all(validationPromises)
        const errors = validationResults.flatMap((result, index) => 
            result.map(error => ({
                point: index,
                property: error.property,
                constraints: error.constraints
            }))
        )

        if (errors.length > 0) {
            await queryRunner.rollbackTransaction()
            return res.status(400).json({
                message: "Validation failed",
                errors
            })
        }

        // Save new points
        const result = await queryRunner.manager.save(points)
        
        await queryRunner.commitTransaction()
        res.status(201).json(result)
    } catch (error: any) {
        await queryRunner.rollbackTransaction()
        res.status(500).json({ 
            message: "Error replacing points",
            error: error.message
        })
    } finally {
        await queryRunner.release()
    }
})

export default router