import { Entity, PrimaryGeneratedColumn, Column, ManyToOne, OneToMany, JoinColumn } from "typeorm"
import { IsNotEmpty, IsString, IsBoolean, IsIn, IsOptional, MaxLength } from "class-validator"
import { ApiProvider } from "./ApiProvider"
import { MapVersion } from "./MapVersion"

const VALID_PROTOCOLS = ["Modbus", "DNP3", "SEL", "Other"]

@Entity()
export class DataInterface {
    @PrimaryGeneratedColumn()
    id!: number

    @Column({ type: "text", unique: true })
    @IsString()
    @IsNotEmpty({ message: 'Interface name is required' })
    @MaxLength(200, { message: 'Interface name must not exceed 200 characters' })
    name: string

    @Column({ type: "text", 
        enum: ["Modbus", "DNP3", "SEL", "Other"]
    })
    @IsString()
    @IsNotEmpty({ message: 'Protocol is required' })
    @IsIn(VALID_PROTOCOLS, { message: 'Invalid protocol type' })
    protocol: string

    @ManyToOne(() => ApiProvider, provider => provider.dataInterfaces)
    @JoinColumn({ name: "provider_id" })
    @IsNotEmpty({ message: 'Provider is required' })
    provider: ApiProvider

    @Column({ default: false })
    @IsBoolean()
    is_internal: boolean

    @Column({ type: "text", nullable: true })
    @IsString()
    @IsOptional()
    @MaxLength(1000, { message: 'Description must not exceed 1000 characters' })
    description: string

    @OneToMany(() => MapVersion, mapVersion => mapVersion.interface)
    mapVersions!: MapVersion[]

    constructor(name: string, protocol: string, provider: ApiProvider, is_internal: boolean, description: string) {
        this.name = name;
        this.protocol = protocol;
        this.provider = provider;
        this.is_internal = is_internal;
        this.description = description;
    }
}