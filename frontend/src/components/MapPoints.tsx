import { useState } from 'react'
import { useQuery, useMutation, useQueryClient } from '@tanstack/react-query'
import {
  Dialog,
  DialogTitle,
  DialogContent,
  TextField,
  DialogActions,
  Button,
  MenuItem,
  Box,
  Alert,
  Snackbar
} from '@mui/material'
import CloudUploadIcon from '@mui/icons-material/CloudUpload'
import FileDownloadIcon from '@mui/icons-material/FileDownload'
import { TableLayout } from './shared/TableLayout'
import {
  getMapPoints,
  getMapVersions,
  createMapPoint,
  updateMapPoint,
  deleteMapPoint,
  exportMapPointsCSV
} from '../services/api'
import { MapPoint, MapVersion } from '../types'

const DATA_TYPES = ['FLOAT32', 'BITFIELD', 'INT16', 'UINT16', 'INT32', 'UINT32', 'STRING']

export const MapPoints = () => {
  const queryClient = useQueryClient()
  const [open, setOpen] = useState(false)
  const [editPoint, setEditPoint] = useState<MapPoint | null>(null)
  const [selectedVersion, setSelectedVersion] = useState<string>('')
  const [error, setError] = useState<string | null>(null)
  const [success, setSuccess] = useState<string | null>(null)
  const [formData, setFormData] = useState({
    version_id: '',
    point_name: '',
    object_name: '',
    register: '',
    data_type: '',
    bit_offset: '',
    units: '',
    scale: '',
    alarm_state: '',
    on_state: '',
    off_state: '',
    alarm_limits: '',
    alarm_profile: '',
    enumeration_table: '',
    comments: ''
  })

  const { data: points = [] } = useQuery<MapPoint[]>({
    queryKey: ['points', selectedVersion],
    queryFn: async () => {
      const response = await getMapPoints()
      return response.data.filter((point: MapPoint) => point.version.id.toString() === selectedVersion)
    },
    enabled: !!selectedVersion
  })

  const { data: versions = [] } = useQuery<MapVersion[]>({
    queryKey: ['versions'],
    queryFn: async () => {
      const response = await getMapVersions()
      return response.data
    }
  })

  const createMutation = useMutation({
    mutationFn: createMapPoint,
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['points', selectedVersion] })
      handleClose()
      setSuccess('Point created successfully')
    },
    onError: (error: Error) => {
      setError(error.message || 'Error creating point')
    }
  })

  const updateMutation = useMutation({
    mutationFn: ({ id, data }: { id: number; data: Partial<MapPoint> }) =>
      updateMapPoint(id, data),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['points', selectedVersion] })
      handleClose()
      setSuccess('Point updated successfully')
    },
    onError: (error: Error) => {
      setError(error.message || 'Error updating point')
    }
  })

  const deleteMutation = useMutation({
    mutationFn: deleteMapPoint,
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['points', selectedVersion] })
      setSuccess('Point deleted successfully')
    },
    onError: (error: Error) => {
      setError(error.message || 'Error deleting point')
    }
  })

  const bulkCreateMutation = useMutation({
    mutationFn: (points: Partial<MapPoint>[]) => 
      Promise.all(points.map(point => createMapPoint(point))),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['points', selectedVersion] })
      setSuccess('Points imported successfully')
    },
    onError: (error: Error) => {
      setError(error.message || 'Error importing points')
    }
  })

  const handleOpen = () => {
    setOpen(true)
  }

  const handleClose = () => {
    setOpen(false)
    setEditPoint(null)
    setFormData({
      version_id: selectedVersion,
      point_name: '',
      object_name: '',
      register: '',
      data_type: '',
      bit_offset: '',
      units: '',
      scale: '',
      alarm_state: '',
      on_state: '',
      off_state: '',
      alarm_limits: '',
      alarm_profile: '',
      enumeration_table: '',
      comments: ''
    })
    setError(null)
  }

  const handleEdit = (point: MapPoint) => {
    setEditPoint(point)
    setFormData({
      version_id: point.version.id.toString(),
      point_name: point.point_name,
      object_name: point.object_name,
      register: point.register,
      data_type: point.data_type,
      bit_offset: point.bit_offset || '',
      units: point.units || '',
      scale: point.scale?.toString() || '',
      alarm_state: point.alarm_state || '',
      on_state: point.on_state || '',
      off_state: point.off_state || '',
      alarm_limits: point.alarm_limits || '',
      alarm_profile: point.alarm_profile || '',
      enumeration_table: point.enumeration_table || '',
      comments: point.comments || ''
    })
    setOpen(true)
  }

  const handleSubmit = async (event: React.FormEvent<HTMLFormElement>) => {
    event.preventDefault()
    const formData = new FormData(event.currentTarget)
    const submitData = {
      version_id: Number(formData.get('version_id')),
      scale: formData.get('scale') ? Number(formData.get('scale')) : undefined,
      point_name: formData.get('point_name') as string,
      object_name: formData.get('object_name') as string,
      register: formData.get('register') as string,
      data_type: formData.get('data_type') as string,
      bit_offset: formData.get('bit_offset') as string,
      units: formData.get('units') as string,
      alarm_state: formData.get('alarm_state') as string,
      on_state: formData.get('on_state') as string,
      off_state: formData.get('off_state') as string,
      alarm_limits: formData.get('alarm_limits') as string,
      alarm_profile: formData.get('alarm_profile') as string,
      enumeration_table: formData.get('enumeration_table') as string,
      comments: formData.get('comments') as string
    }

    if (editPoint) {
      updateMutation.mutate({
        id: editPoint.id,
        data: submitData
      })
    } else {
      createMutation.mutate(submitData)
    }
  }

  const handleBulkImport = async (event: React.ChangeEvent<HTMLInputElement>) => {
    const file = event.target.files?.[0]
    if (!file || !selectedVersion) {
      if (!selectedVersion) {
        setError('Please select a map version first')
      }
      return
    }

    const reader = new FileReader()
    reader.onload = async (e) => {
      try {
        const csv = e.target?.result as string
        const lines = csv.split('\n').filter(line => line.trim()) // Remove empty lines
        const headers = lines[0].split(',').map(h => h.trim().toLowerCase())
        
        // Validate required columns
        const requiredColumns = ['point_name', 'object_name', 'register', 'data_type']
        const missingColumns = requiredColumns.filter(col => !headers.includes(col))
        
        if (missingColumns.length > 0) {
          throw new Error(`Missing required columns: ${missingColumns.join(', ')}`)
        }
        
        const points = lines.slice(1).map((line, index) => {
          const values = line.split(',').map(v => v.trim())
          if (values.length !== headers.length) {
            throw new Error(`Invalid number of columns in row ${index + 2}`)
          }

          const point: Record<string, any> = {
            version_id: parseInt(selectedVersion)
          }
          
          headers.forEach((header, index) => {
            if (values[index]) {
              if (header === 'scale') {
                const scale = parseFloat(values[index])
                if (isNaN(scale)) {
                  throw new Error(`Invalid scale value in row ${index + 2}`)
                }
                point[header] = scale
              } else {
                point[header] = values[index]
              }
            }
          })
          
          // Validate required fields
          requiredColumns.forEach(field => {
            if (!point[field]) {
              throw new Error(`Missing ${field} in row ${index + 2}`)
            }
          })
          
          return point
        })
        
        if (points.length === 0) {
          throw new Error('No valid points found in CSV')
        }

        await bulkCreateMutation.mutateAsync(points)
      } catch (error: any) {
        setError(error.message || 'Error importing points')
      }
    }
    reader.onerror = () => {
      setError('Error reading file')
    }
    reader.readAsText(file)
    // Clear the file input for future uploads
    event.target.value = ''
  }

  const handleExport = async () => {
    if (!selectedVersion) {
      setError('Please select a map version first')
      return
    }

    try {
      const response = await exportMapPointsCSV(parseInt(selectedVersion))
      const url = window.URL.createObjectURL(new Blob([response.data]))
      const link = document.createElement('a')
      link.href = url
      link.setAttribute('download', `map_points_${selectedVersion}.csv`)
      document.body.appendChild(link)
      link.click()
      link.remove()
      window.URL.revokeObjectURL(url)
    } catch (error: any) {
      setError(error.message || 'Error exporting points')
    }
  }

  const columns = [
    { id: 'point_name', label: 'Point Name', minWidth: 170 },
    { id: 'object_name', label: 'Object Name', minWidth: 130 },
    { id: 'register', label: 'Register', minWidth: 100 },
    { id: 'data_type', label: 'Data Type', minWidth: 100 },
    { id: 'units', label: 'Units', minWidth: 100 },
    { id: 'scale', label: 'Scale', minWidth: 70 },
    { id: 'comments', label: 'Comments', minWidth: 200 }
  ]

  return (
    <>
      <Box sx={{ width: '100%', padding: 2 }}>
        <Box sx={{ display: 'flex', gap: 2, mb: 2 }}>
          <Box sx={{ flex: '0 0 33.33%' }}>
            <TextField
              select
              fullWidth
              label="Map Version"
              value={selectedVersion}
              onChange={(e) => setSelectedVersion(e.target.value)}
            >
              {versions.map((version) => (
                <MenuItem key={version.id} value={version.id.toString()}>
                  {version.interface.name} - v{version.version}
                </MenuItem>
              ))}
            </TextField>
          </Box>
          <Box sx={{ flex: '1 1 auto', display: 'flex', justifyContent: 'flex-end', gap: 2 }}>
            <input
              accept=".csv"
              style={{ display: 'none' }}
              id="bulk-import"
              type="file"
              onChange={handleBulkImport}
              disabled={!selectedVersion}
            />
            <label htmlFor="bulk-import">
              <Button
                component="span"
                variant="outlined"
                startIcon={<CloudUploadIcon />}
                disabled={!selectedVersion}
              >
                Import CSV
              </Button>
            </label>
            <Button
              variant="outlined"
              startIcon={<FileDownloadIcon />}
              onClick={handleExport}
              disabled={!selectedVersion}
            >
              Export CSV
            </Button>
            <Button
              variant="contained"
              onClick={() => handleOpen()}
              disabled={!selectedVersion}
            >
              Add Point
            </Button>
          </Box>
        </Box>

        <TableLayout
          title="Map Points"
          columns={columns}
          data={points}
          onAdd={undefined}
          onEdit={handleEdit}
          onDelete={(point) => deleteMutation.mutate(point.id)}
        />
      </Box>

      <Snackbar 
        open={!!error} 
        autoHideDuration={6000} 
        onClose={() => setError(null)}
        anchorOrigin={{ vertical: 'top', horizontal: 'center' }}
      >
        <Alert onClose={() => setError(null)} severity="error">
          {error}
        </Alert>
      </Snackbar>

      <Snackbar
        open={!!success}
        autoHideDuration={3000}
        onClose={() => setSuccess(null)}
        anchorOrigin={{ vertical: 'top', horizontal: 'center' }}
      >
        <Alert onClose={() => setSuccess(null)} severity="success">
          {success}
        </Alert>
      </Snackbar>

      <Dialog open={open} onClose={handleClose} maxWidth="md" fullWidth>
        <form onSubmit={handleSubmit}>
          <DialogTitle>
            {editPoint ? 'Edit Point' : 'New Point'}
          </DialogTitle>
          <DialogContent>
            <Box sx={{ display: 'flex', flexWrap: 'wrap', gap: 2, mt: 1 }}>
              <Box sx={{ flex: '0 0 calc(33.33% - 8px)' }}>
                <TextField
                  select
                  fullWidth
                  name="version_id"
                  label="Version"
                  value={formData.version_id}
                  onChange={(e) =>
                    setFormData({ ...formData, version_id: e.target.value })
                  }
                  required
                >
                  {versions.map((version) => (
                    <MenuItem key={version.id} value={version.id.toString()}>
                      {version.interface.name} - {version.version}
                    </MenuItem>
                  ))}
                </TextField>
              </Box>
              <Box sx={{ flex: '0 0 calc(50% - 8px)' }}>
                <TextField
                  autoFocus
                  fullWidth
                  name="point_name"
                  label="Point Name"
                  value={formData.point_name}
                  onChange={(e) => setFormData({ ...formData, point_name: e.target.value })}
                  required
                />
              </Box>
              <Box sx={{ flex: '0 0 calc(50% - 8px)' }}>
                <TextField
                  fullWidth
                  name="object_name"
                  label="Object Name"
                  value={formData.object_name}
                  onChange={(e) => setFormData({ ...formData, object_name: e.target.value })}
                  required
                />
              </Box>
              <Box sx={{ flex: '0 0 calc(50% - 8px)' }}>
                <TextField
                  fullWidth
                  name="register"
                  label="Register"
                  value={formData.register}
                  onChange={(e) => setFormData({ ...formData, register: e.target.value })}
                  required
                />
              </Box>
              <Box sx={{ flex: '0 0 calc(50% - 8px)' }}>
                <TextField
                  select
                  fullWidth
                  name="data_type"
                  label="Data Type"
                  value={formData.data_type}
                  onChange={(e) => setFormData({ ...formData, data_type: e.target.value })}
                  required
                >
                  {DATA_TYPES.map((type) => (
                    <MenuItem key={type} value={type}>
                      {type}
                    </MenuItem>
                  ))}
                </TextField>
              </Box>
              <Box sx={{ flex: '0 0 calc(50% - 8px)' }}>
                <TextField
                  fullWidth
                  name="bit_offset"
                  label="Bit Offset"
                  value={formData.bit_offset}
                  onChange={(e) => setFormData({ ...formData, bit_offset: e.target.value })}
                />
              </Box>
              <Box sx={{ flex: '0 0 calc(50% - 8px)' }}>
                <TextField
                  fullWidth
                  name="units"
                  label="Units"
                  value={formData.units}
                  onChange={(e) => setFormData({ ...formData, units: e.target.value })}
                />
              </Box>
              <Box sx={{ flex: '0 0 calc(50% - 8px)' }}>
                <TextField
                  fullWidth
                  name="scale"
                  label="Scale"
                  type="number"
                  inputProps={{ step: "any" }}
                  value={formData.scale}
                  onChange={(e) => setFormData({ ...formData, scale: e.target.value })}
                />
              </Box>
              <Box sx={{ flex: '0 0 calc(50% - 8px)' }}>
                <TextField
                  fullWidth
                  name="alarm_state"
                  label="Alarm State"
                  value={formData.alarm_state}
                  onChange={(e) => setFormData({ ...formData, alarm_state: e.target.value })}
                />
              </Box>
              <Box sx={{ flex: '0 0 calc(50% - 8px)' }}>
                <TextField
                  fullWidth
                  name="on_state"
                  label="On State"
                  value={formData.on_state}
                  onChange={(e) => setFormData({ ...formData, on_state: e.target.value })}
                />
              </Box>
              <Box sx={{ flex: '0 0 calc(50% - 8px)' }}>
                <TextField
                  fullWidth
                  name="off_state"
                  label="Off State"
                  value={formData.off_state}
                  onChange={(e) => setFormData({ ...formData, off_state: e.target.value })}
                />
              </Box>
              <Box sx={{ flex: '0 0 100%' }}>
                <TextField
                  fullWidth
                  name="alarm_limits"
                  label="Alarm Limits"
                  value={formData.alarm_limits}
                  onChange={(e) => setFormData({ ...formData, alarm_limits: e.target.value })}
                />
              </Box>
              <Box sx={{ flex: '0 0 100%' }}>
                <TextField
                  fullWidth
                  name="alarm_profile"
                  label="Alarm Profile"
                  value={formData.alarm_profile}
                  onChange={(e) => setFormData({ ...formData, alarm_profile: e.target.value })}
                />
              </Box>
              <Box sx={{ flex: '0 0 100%' }}>
                <TextField
                  fullWidth
                  name="enumeration_table"
                  label="Enumeration Table"
                  value={formData.enumeration_table}
                  onChange={(e) => setFormData({ ...formData, enumeration_table: e.target.value })}
                />
              </Box>
              <Box sx={{ flex: '0 0 100%' }}>
                <TextField
                  fullWidth
                  name="comments"
                  label="Comments"
                  multiline
                  rows={3}
                  value={formData.comments}
                  onChange={(e) => setFormData({ ...formData, comments: e.target.value })}
                />
              </Box>
            </Box>
          </DialogContent>
          <DialogActions>
            <Button onClick={handleClose}>Cancel</Button>
            <Button
              type="submit"
              variant="contained"
              disabled={!formData.version_id || !formData.point_name}
            >
              {editPoint ? 'Update' : 'Create'}
            </Button>
          </DialogActions>
        </form>
      </Dialog>
    </>
  )
}