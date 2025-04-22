import psycopg2
from psycopg2.extras import execute_values
from openpyxl import load_workbook
import openpyxl

# === Configuration ===
EXCEL_PATH = "PPC Solar Master Points List.xlsx"
PG_CONN_INFO = {
    "dbname": "points",
    "user": "mmunin",
    "password": "Password1!",
    "host": "localhost",
    "port": 5432,
}
DEFAULT_PROVIDER = "CEG"
DEFAULT_PROTOCOL = "Modbus"
DEFAULT_VERSION = "unversioned"  # fallback

# Expected column mapping (case-insensitive match)
EXPECTED_COLUMNS = [
    "List Index", "Availability", "Object", "Point Description", "Data Type",
    "DNP index", "Bit", "Alarm State", "On (1) State", "Off (0) State", "Units",
    "Scalar", "Analog Alarm Limits", "Alarm Profile", "Historian Profile",
    "HMI Category", "RTAC Point Name", "Enumeration Table", "Comments"
]

# === Helper: Normalize Excel column names ===
def normalize(header):
    if header is None:
        return ""
    return header.strip().lower().replace('\n', ' ').replace('"', '').strip()

# === PostgreSQL connection ===
conn = psycopg2.connect(**PG_CONN_INFO)
cur = conn.cursor()

# Ensure provider exists
cur.execute("""
    INSERT INTO api_provider (name, is_internal)
    VALUES (%s, true)
    ON CONFLICT (name) DO NOTHING
""", (DEFAULT_PROVIDER,))
conn.commit()

# === Load Excel workbook ===
wb = load_workbook(EXCEL_PATH, data_only=True, read_only=False)
skip = False
for sheet in wb.worksheets:
    if sheet.title == "PPC to Ignition - SG3600":
        skip = False
    if skip:
        continue
        
    print(f"Processing sheet: {sheet.title}")
    if sheet.title == "Data Flows":
        print("  Skipped: 'Data Flows' sheet.")
        continue
    if not sheet._tables:
        print(f"  Skipped: no Excel tables found on this sheet.")
        continue
    
    table = next(iter(sheet.tables.values()))  # Only consider the first table per sheet
    ref = table.ref
    min_col, min_row, max_col, max_row = openpyxl.utils.range_boundaries(ref)
    print(f"  Table range: {min_row}-{max_row}, {min_col}-{max_col}")
    headers = [sheet.cell(row=min_row, column=c).value for c in range(min_col, max_col + 1)]
    headers_norm = [normalize(h) if h else "" for h in headers]
    col_map = {h: i+1 for i, h in enumerate(headers_norm)}
    provider = input("Enter the provider name: ").strip()
    protocol = input("Enter the protocol name: ").strip()
    interface_name = sheet.title.strip()
    version = DEFAULT_VERSION


    # If provider does not exist, insert it
    cur.execute("""
        INSERT INTO api_provider (name, is_internal)
        VALUES (%s, true)
        ON CONFLICT (name) DO NOTHING
        RETURNING id
    """, (provider,))
    if cur.rowcount == 0:
        cur.execute("SELECT id FROM api_provider WHERE name = %s", (provider,))
        provider_id = cur.fetchone()[0]
    else:
        provider_id = cur.fetchone()[0]
    print(f"  Provider ID: {provider_id}")
    # Insert interface
    cur.execute("""
        INSERT INTO data_interface (name, protocol, provider_id, is_internal)
        VALUES (%s, %s, %s, true)
        ON CONFLICT (name) DO UPDATE SET protocol = EXCLUDED.protocol
        RETURNING id
    """, (interface_name, protocol or DEFAULT_PROTOCOL, provider_id))
    conn.commit()
    interface_id = cur.fetchone()
    if not interface_id:
        cur.execute("SELECT id FROM data_interface WHERE name = %s", (interface_name,))
        interface_id = cur.fetchone()
    interface_id = interface_id[0]

    # Insert map_version
    cur.execute("""
        INSERT INTO map_version (interface_id, version)
        VALUES (%s, %s)
        ON CONFLICT (interface_id, version) DO NOTHING
        RETURNING id
    """, (interface_id, version))
    if cur.rowcount == 0:
        cur.execute("""
            SELECT id FROM map_version
            WHERE interface_id = %s AND version = %s
        """, (interface_id, version))
    version_id = cur.fetchone()[0]

    # Collect row data
    rows = []
    
    for r in range(min_row + 1, max_row + 1):
        point_name = sheet.cell(row=r, column=col_map['point description']).value 
        if "modbus table" in col_map:
            object_name = sheet.cell(row=r, column=col_map['modbus table']).value
        elif "object" in col_map:
            object_name = sheet.cell(row=r, column=col_map['object']).value 
        if "modbus register" in col_map:
            register = sheet.cell(row=r, column=col_map['modbus register']).value 
        elif "dnp index" in col_map:
            register = sheet.cell(row=r, column=col_map['dnp index']).value
        elif "modbusregister" in col_map:
            register = sheet.cell(row=r, column=col_map['modbusregister']).value
        else:
            register = None        
        data_type = sheet.cell(row=r, column=col_map['data type']).value
        if "bit" in col_map:
            bit_offset = sheet.cell(row=r, column=col_map['bit']).value
        elif "modbus bit" in col_map:
            bit_offset = sheet.cell(row=r, column=col_map['modbus bit']).value
        
        units = sheet.cell(row=r, column=col_map['units']).value 
        scale = sheet.cell(row=r, column=col_map['scalar']).value
        alarm_state = sheet.cell(row=r, column=col_map['alarm state']).value
        on_state = sheet.cell(row=r, column=col_map['on (1) state']).value
        off_state = sheet.cell(row=r, column=col_map['off (0) state']).value
        alarm_limits = sheet.cell(row=r, column=col_map['analog alarm limits']).value
        alarm_profile = sheet.cell(row=r, column=col_map['alarm profile']).value
        enumeration_table = sheet.cell(row=r, column=col_map['enumeration table']).comment
        if enumeration_table is None:
            enumeration_table = sheet.cell(row=r, column=col_map['enumeration table']).value
        else:
            enumeration_table = enumeration_table.text
        comments = sheet.cell(row=r, column=col_map['comments']).value


 

        if not point_name or not data_type:
            continue  # skip empty/incomplete rows

        sql = """
            INSERT into map_point (
                point_name, object_name, data_type, register, bit_offset, units,
                scale, alarm_state, on_state, off_state, alarm_limits,
                alarm_profile, enumeration_table, comments,
                version_id
            ) VALUES (
                %s, %s, %s, %s, %s, %s,
                %s, %s, %s, %s, %s,
                %s, %s, %s, %s
            )"""
        cur.execute(sql, (
            point_name, object_name, data_type, register, bit_offset, units,
            scale, alarm_state, on_state, off_state, alarm_limits,
            alarm_profile, enumeration_table, comments, 
            version_id
        ))
    conn.commit()
    print(f"  Imported {len(rows)} rows from table: {table.name}")

cur.close()
conn.close()
print("✅ Import complete.")
