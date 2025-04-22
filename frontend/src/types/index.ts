export interface ApiProvider {
    id: number
    name: string
    is_internal: boolean
    dataInterfaces?: DataInterface[]
}

export interface DataInterface {
    id: number
    name: string
    protocol: 'Modbus' | 'DNP3' | 'SEL' | 'Other'
    provider: ApiProvider
    is_internal: boolean
    description?: string
    mapVersions?: MapVersion[]
}

export interface MapVersion {
    id: number
    interface: DataInterface
    version: string
    release_date?: Date
    changelog?: string
    points?: MapPoint[]
}

export interface MapPoint {
    id: number
    version: MapVersion
    point_name: string
    object_name: string
    register: string
    data_type: string
    bit_offset?: string
    units?: string
    scale?: number
    alarm_state?: string
    on_state?: string
    off_state?: string
    alarm_limits?: string
    alarm_profile?: string
    enumeration_table?: string
    comments?: string
}

export interface Project {
    id: number
    name: string
    location?: string
    notes?: string
    mapUsages?: ProjectMapUsage[]
}

export interface ProjectMapUsage {
    id: number
    project: Project
    interface: DataInterface
    version: MapVersion
    notes?: string
}