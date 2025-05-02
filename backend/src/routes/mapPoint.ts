import express, { Router, Request, Response, NextFunction } from "express"
import { validate } from "class-validator"
import ExcelJS from 'exceljs'
import { AppDataSource } from "../data-source"
import { MapPoint } from "../entity/MapPoint"

const router = Router()
const repository = AppDataSource.getRepository(MapPoint)

interface RouteParams {
    id: string;
    versionId: string;
}

interface CreatePointBody {
    version_id: number;
    point_name: string;
    object_name: string;
    register: string;
    data_type: string;
    bit_offset?: string;
    units?: string;
    scale?: number;
    alarm_state?: string;
    on_state?: string;
    off_state?: string;
    alarm_limits?: string;
    alarm_profile?: string;
    enumeration_table?: string;
    comments?: string;
}

// Get all points
const getAllPoints = async (_req: Request, res: Response, next: NextFunction): Promise<void> => {
    try {
        const points = await repository.find({
            relations: ["version"]
        })
        res.json(points)
    } catch (error) {
        next(error)
    }
}

// Get points by version
const getPointsByVersion = async (req: Request<{ versionId: string }>, res: Response, next: NextFunction): Promise<void> => {
    try {
        if (!req.params.versionId) {
            res.status(400).json({ message: "Version ID is required" })
            return
        }
        const points = await repository.find({
            where: { version: { id: parseInt(req.params.versionId) } },
            relations: ["version"]
        })
        res.json(points)
    } catch (error) {
        next(error)
    }
}

// Get single point
const getPoint = async (req: Request<{ id: string }>, res: Response, next: NextFunction): Promise<void> => {
    try {
        if (!req.params.id) {
            res.status(400).json({ message: "Point ID is required" })
            return
        }
        const point = await repository.findOne({
            where: { id: parseInt(req.params.id) },
            relations: ["version"]
        })
        if (!point) {
            res.status(404).json({ message: "Point not found" })
            return
        }
        res.json(point)
    } catch (error) {
        next(error)
    }
}

// Create point with validation
const createPoint = async (req: Request<{}, any, CreatePointBody>, res: Response, next: NextFunction): Promise<void> => {
    try {
        const point = repository.create(req.body)
        
        const errors = await validate(point)
        if (errors.length > 0) {
            res.status(400).json({
                message: "Validation failed",
                errors: errors.map(error => ({
                    property: error.property,
                    constraints: error.constraints
                }))
            })
            return
        }

        const result = await repository.save(point)
        res.status(201).json(result)
    } catch (error) {
        next(error)
    }
}

// Bulk create points with validation
const createPoints = async (req: Request<{}, any, CreatePointBody[]>, res: Response, next: NextFunction): Promise<void> => {
    try {
        const points = repository.create(req.body)
        
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
            res.status(400).json({
                message: "Validation failed",
                errors
            })
            return
        }

        const result = await repository.save(points)
        res.status(201).json(result)
    } catch (error) {
        next(error)
    }
}

// Update point with validation
const updatePoint = async (req: Request<{ id: string }, any, Partial<CreatePointBody>>, res: Response, next: NextFunction): Promise<void> => {
    try {
        if (!req.params.id) {
            res.status(400).json({ message: "Point ID is required" })
            return
        }
        const point = await repository.findOneBy({ id: parseInt(req.params.id) })
        if (!point) {
            res.status(404).json({ message: "Point not found" })
            return
        }

        repository.merge(point, req.body)
        
        const errors = await validate(point)
        if (errors.length > 0) {
            res.status(400).json({
                message: "Validation failed",
                errors: errors.map(error => ({
                    property: error.property,
                    constraints: error.constraints
                }))
            })
            return
        }

        const result = await repository.save(point)
        res.json(result)
    } catch (error) {
        next(error)
    }
}

// Delete point
const deletePoint = async (req: Request<{ id: string }>, res: Response, next: NextFunction): Promise<void> => {
    try {
        if (!req.params.id) {
            res.status(400).json({ message: "Point ID is required" })
            return
        }
        const result = await repository.delete(req.params.id)
        if (result.affected === 0) {
            res.status(404).json({ message: "Point not found" })
            return
        }
        res.status(204).send()
    } catch (error) {
        next(error)
    }
}

// Delete all points for a version
const deletePointsByVersion = async (req: Request<{ versionId: string }>, res: Response, next: NextFunction): Promise<void> => {
    try {
        if (!req.params.versionId) {
            res.status(400).json({ message: "Version ID is required" })
            return
        }
        const result = await repository.delete({ 
            version: { id: parseInt(req.params.versionId) } 
        })
        res.status(204).send()
    } catch (error) {
        next(error)
    }
}

// Export points as Excel
const exportPoints = async (req: Request<{ versionId: string }>, res: Response, next: NextFunction): Promise<void> => {
    try {
        if (!req.params.versionId) {
            res.status(400).json({ message: "Version ID is required" })
            return
        }
        const points = await repository.find({
            where: { version: { id: parseInt(req.params.versionId) } },
            relations: ["version"]
        })

        const wb = new ExcelJS.Workbook()
        const ws = wb.addWorksheet('Points')

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

        const buffer = await wb.xlsx.writeBuffer()
        
        res.setHeader('Content-Type', 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet')
        res.setHeader('Content-Disposition', `attachment; filename="map_points_${req.params.versionId}.xlsx"`)
        res.send(buffer)
    } catch (error) {
        next(error)
    }
}

// Replace all points for a version
const replacePoints = async (req: Request<{ versionId: string }, any, CreatePointBody[]>, res: Response, next: NextFunction): Promise<void> => {
    const queryRunner = AppDataSource.createQueryRunner()
    await queryRunner.connect()
    await queryRunner.startTransaction()

    try {
        if (!req.params.versionId) {
            res.status(400).json({ message: "Version ID is required" })
            return
        }

        await queryRunner.manager.delete(MapPoint, { 
            version: { id: parseInt(req.params.versionId) } 
        })

        const points = queryRunner.manager.create(MapPoint, req.body)
        
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
            res.status(400).json({
                message: "Validation failed",
                errors
            })
            return
        }

        const result = await queryRunner.manager.save(points)
        
        await queryRunner.commitTransaction()
        res.status(201).json(result)
    } catch (error) {
        await queryRunner.rollbackTransaction()
        next(error)
    } finally {
        await queryRunner.release()
    }
}

// Route handlers
router.get("/", getAllPoints)
router.get("/version/:versionId", getPointsByVersion)
router.get("/:id", getPoint)
router.post("/", express.json(), createPoint)
router.post("/bulk", express.json(), createPoints)
router.put("/:id", express.json(), updatePoint)
router.delete("/:id", deletePoint)
router.delete("/version/:versionId", deletePointsByVersion)
router.get("/version/:versionId/export", exportPoints)
router.post("/version/:versionId/replace", express.json(), replacePoints)

export default router