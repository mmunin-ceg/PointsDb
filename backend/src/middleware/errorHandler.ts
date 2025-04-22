import { Request, Response, NextFunction } from 'express'
import { ValidationError } from 'class-validator'
import { QueryFailedError } from 'typeorm'

export const errorHandler = (
    error: Error,
    req: Request,
    res: Response,
    next: NextFunction
) => {
    console.error('Error:', error)

    if (error instanceof Array && error[0] instanceof ValidationError) {
        return res.status(400).json({
            message: 'Validation failed',
            errors: error.map(err => ({
                property: err.property,
                constraints: err.constraints
            }))
        })
    }

    if (error instanceof QueryFailedError) {
        // Handle database errors
        if (error.message.includes('unique constraint')) {
            return res.status(409).json({
                message: 'A record with this value already exists'
            })
        }
        return res.status(500).json({
            message: 'Database error occurred'
        })
    }

    // Default error
    res.status(500).json({
        message: 'Internal server error',
        error: process.env.NODE_ENV === 'development' ? error.message : undefined
    })
}