import { Entity, PrimaryGeneratedColumn, Column, OneToMany } from "typeorm"
import { IsNotEmpty, IsString, IsOptional, MaxLength } from "class-validator"
import { ProjectMapUsage } from "./ProjectMapUsage"

@Entity()
export class Project {
    @PrimaryGeneratedColumn()
    id!: number;

    @Column("text")
    @IsString()
    @IsNotEmpty({ message: 'Project name is required' })
    @MaxLength(200, { message: 'Project name must not exceed 200 characters' })
    name!: string;

    @Column({ type: "text", nullable: true })
    @IsString()
    @IsOptional()
    @MaxLength(500, { message: 'Location must not exceed 500 characters' })
    location!: string;

    @Column({ type: "text", nullable: true })
    @IsString()
    @IsOptional()
    @MaxLength(1000, { message: 'Notes must not exceed 1000 characters' })
    notes!: string;

    @OneToMany(() => ProjectMapUsage, usage => usage.project)
    mapUsages!: ProjectMapUsage[];

    constructor(name: string, location: string, notes: string) {
        this.name = name;
        this.location = location;
        this.notes = notes;
    }
}