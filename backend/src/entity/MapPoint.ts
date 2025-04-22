import { Entity, PrimaryGeneratedColumn, Column, ManyToOne, JoinColumn } from "typeorm"
import { IsNotEmpty, IsString, IsOptional, IsNumber, MaxLength } from "class-validator"
import { MapVersion } from "./MapVersion"

@Entity()
export class MapPoint {
    @PrimaryGeneratedColumn()
    id!: number

    @ManyToOne(() => MapVersion, mapVersion => mapVersion.points, {
        onDelete: "CASCADE"
    })
    @JoinColumn({ name: "version_id" })
    @IsNotEmpty({ message: 'Version is required' })
    version: MapVersion

    @Column("text")
    @IsString()
    @IsNotEmpty({ message: 'Point name is required' })
    @MaxLength(200, { message: 'Point name must not exceed 200 characters' })
    point_name: string

    @Column("text")
    @IsString()
    @IsNotEmpty({ message: 'Object name is required' })
    object_name: string

    @Column("text")
    @IsString()
    @IsNotEmpty({ message: 'Register is required' })
    register: string

    @Column("text")
    @IsString()
    @IsNotEmpty({ message: 'Data type is required' })
    data_type: string

    @Column({ type: "text", nullable: true })
    @IsString()
    @IsOptional()
    bit_offset: string

    @Column({ type: "text", nullable: true })
    @IsString()
    @IsOptional()
    units: string

    @Column({ type: "real", nullable: true })
    @IsNumber()
    @IsOptional()
    scale: number

    @Column({ type: "text", nullable: true })
    @IsString()
    @IsOptional()
    alarm_state: string

    @Column({ type: "text", nullable: true })
    @IsString()
    @IsOptional()
    on_state: string

    @Column({ type: "text", nullable: true })
    @IsString()
    @IsOptional()
    off_state: string

    @Column({ type: "text", nullable: true })
    @IsString()
    @IsOptional()
    alarm_limits: string

    @Column({ type: "text", nullable: true })
    @IsString()
    @IsOptional()
    alarm_profile: string

    @Column({ type: "text", nullable: true })
    @IsString()
    @IsOptional()
    enumeration_table: string

    @Column({ type: "text", nullable: true })
    @IsString()
    @IsOptional()
    comments: string

    constructor(
        version: MapVersion,
        point_name: string,
        object_name: string,
        register: string,
        data_type: string,
        bit_offset: string,
        units: string,
        scale: number,
        alarm_state: string,
        on_state: string,
        off_state: string,
        alarm_limits: string,
        alarm_profile: string,
        enumeration_table: string,
        comments: string
    ) {
        this.version = version;
        this.point_name = point_name;
        this.object_name = object_name;
        this.register = register;
        this.data_type = data_type;
        this.bit_offset = bit_offset;
        this.units = units;
        this.scale = scale;
        this.alarm_state = alarm_state;
        this.on_state = on_state;
        this.off_state = off_state;
        this.alarm_limits = alarm_limits;
        this.alarm_profile = alarm_profile;
        this.enumeration_table = enumeration_table;
        this.comments = comments;
    }
}