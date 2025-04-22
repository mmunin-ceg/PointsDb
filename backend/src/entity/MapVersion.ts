import { Entity, PrimaryGeneratedColumn, Column, ManyToOne, OneToMany, JoinColumn } from "typeorm"
import { DataInterface } from "./DataInterface"
import { MapPoint } from "./MapPoint"

@Entity()
export class MapVersion {
    @PrimaryGeneratedColumn()
    id!: number;

    @ManyToOne(() => DataInterface, dataInterface => dataInterface.mapVersions, {
        onDelete: "CASCADE"
    })
    @JoinColumn({ name: "interface_id" })
    interface!: DataInterface;

    @Column("text")
    version!: string;

    @Column({ type: "date", nullable: true })
    release_date!: Date;

    @Column({ type: "text", nullable: true })
    changelog!: string;

    @OneToMany(() => MapPoint, mapPoint => mapPoint.version)
    points!: MapPoint[];

    constructor(
        interface_: DataInterface,
        version: string,
        release_date: Date,
        changelog: string
    ) {
        this.interface = interface_;
        this.version = version;
        this.release_date = release_date;
        this.changelog = changelog;
    }
}