-- 1. Source of the API (vendor or internal)
CREATE TABLE api_provider (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL UNIQUE,                    -- e.g., 'GroundWork', 'CEG', 'Sungrow', etc.
    is_internal BOOLEAN DEFAULT FALSE
);

-- 2. A data link interface (e.g., Met Tower, Sungrow SG4400, PPC to Ignition)
CREATE TABLE data_interface (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL unique,                    -- e.g., 'Zenith Met Tower', 'PPC to Ignition – SG3600', etc.
    protocol TEXT CHECK (protocol IN ('Modbus', 'DNP3', 'SEL', 'Other')),
    provider_id INTEGER NOT NULL REFERENCES api_provider(id),
    is_internal BOOLEAN DEFAULT FALSE,
    description TEXT
);

-- 3. Each version of a data map (e.g., v1.02, v1.23, etc.)
CREATE TABLE map_version (
    id SERIAL PRIMARY KEY,
    interface_id INTEGER NOT NULL REFERENCES data_interface(id) ON DELETE CASCADE,
    version TEXT NOT NULL,
    release_date DATE,
    changelog TEXT,
    UNIQUE(interface_id, version)
);

-- 4. Points in a map version (CEG format compatible)
CREATE TABLE map_point (
    id SERIAL PRIMARY KEY,
    version_id INTEGER NOT NULL REFERENCES map_version(id) ON DELETE CASCADE,
    point_name TEXT NOT NULL, 
    object_name TEXT NOT NULL,               -- e.g., 'Input Register', 'Analog Output', etc.
    register TEXT NOT NULL,         -- e.g., 0, 1, 2, etc.
    data_type TEXT NOT NULL,               -- 'FLOAT32', 'BITFIELD', etc.
    bit_offset TEXT,
    units TEXT,
    scale REAL,
    alarm_state TEXT,
    on_state TEXT,
    off_state TEXT,
    alarm_limits TEXT,
    alarm_profile TEXT,
    enumeration_table TEXT,
    comments TEXT
);

-- 5. Projects or sites using specific map versions
CREATE TABLE project (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    location TEXT,
    notes TEXT
);

CREATE TABLE project_map_usage (
    id SERIAL PRIMARY KEY,
    project_id INTEGER NOT NULL REFERENCES project(id),
    interface_id INTEGER NOT NULL REFERENCES data_interface(id),
    version_id INTEGER NOT NULL REFERENCES map_version(id),
    notes TEXT
);
