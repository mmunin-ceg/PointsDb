import { Entity, PrimaryGeneratedColumn, Column, ManyToOne, JoinColumn } from "typeorm"
import { Project } from "./Project"
import { DataInterface } from "./DataInterface"
import { MapVersion } from "./MapVersion"

@Entity()
export class ProjectMapUsage {
    @PrimaryGeneratedColumn()
    id!: number;

    @ManyToOne(() => Project, project => project.mapUsages)
    @JoinColumn({ name: "project_id" })
    project!: Project;

    @ManyToOne(() => DataInterface)
    @JoinColumn({ name: "interface_id" })
    interface!: DataInterface;

    @ManyToOne(() => MapVersion)
    @JoinColumn({ name: "version_id" })
    version!: MapVersion;

    @Column({ type: "text", nullable: true })
    notes!: string;

    constructor(project: Project, interface_: DataInterface, version: MapVersion, notes: string) {
        this.project = project;
        this.interface = interface_;
        this.version = version;
        this.notes = notes;
    }
}