import { Entity, PrimaryGeneratedColumn, Column, OneToMany } from "typeorm"
import { DataInterface } from "./DataInterface"

@Entity()
export class ApiProvider {
    @PrimaryGeneratedColumn()
    id!: number;

    @Column({ type: "text", unique: true })
    name!: string;

    @Column({ default: false })
    is_internal!: boolean;

    @OneToMany(() => DataInterface, dataInterface => dataInterface.provider)
    dataInterfaces!: DataInterface[];

    constructor(name: string, is_internal: boolean) {
        this.name = name;
        this.is_internal = is_internal;
    }
}