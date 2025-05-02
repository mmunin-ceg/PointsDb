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
  Typography,
  List,
  ListItem,
  ListItemText,
  IconButton,
  ListItemSecondaryAction,
  Divider,
  Alert,
  Snackbar
} from '@mui/material'
import DeleteIcon from '@mui/icons-material/Delete'
import MapIcon from '@mui/icons-material/Map'
import { TableLayout } from './shared/TableLayout'
import {
  getProjects,
  createProject,
  updateProject,
  deleteProject,
  getDataInterfaces,
  getMapVersionsByInterface,
  addMapUsageToProject,
  removeMapUsageFromProject,
  getProject
} from '../services/api'
import { Project, DataInterface, MapVersion } from '../types'

export const Projects = () => {
  const queryClient = useQueryClient()
  const [open, setOpen] = useState(false)
  const [mapUsageOpen, setMapUsageOpen] = useState(false)
  const [editProject, setEditProject] = useState<Project | null>(null)
  const [selectedProject, setSelectedProject] = useState<Project | null>(null)
  const [error, setError] = useState<string | null>(null)
  const [success, setSuccess] = useState<string | null>(null)
  const [formData, setFormData] = useState({
    name: '',
    location: '',
    notes: ''
  })
  const [mapUsageFormData, setMapUsageFormData] = useState({
    interface_id: '',
    version_id: '',
    notes: ''
  })

  const { data: projects = [] } = useQuery<Project[]>({
    queryKey: ['projects'],
    queryFn: async () => {
      const response = await getProjects()
      return response.data
    }
  })

  const { data: interfaces = [] } = useQuery<DataInterface[]>({
    queryKey: ['interfaces'],
    queryFn: async () => {
      const response = await getDataInterfaces()
      return response.data
    }
  })

  const { data: versions = [] } = useQuery<MapVersion[]>({
    queryKey: ['versions', mapUsageFormData.interface_id],
    queryFn: async () => {
      if (!mapUsageFormData.interface_id) return []
      const response = await getMapVersionsByInterface(parseInt(mapUsageFormData.interface_id))
      return response.data
    },
    enabled: !!mapUsageFormData.interface_id
  })

  const { data: currentProject } = useQuery<Project>({
    queryKey: ['project', selectedProject?.id],
    queryFn: async () => {
      if (!selectedProject?.id) return null;
      const response = await getProject(selectedProject.id);
      return response.data;
    },
    enabled: !!selectedProject?.id
  });

  const createMutation = useMutation({
    mutationFn: createProject,
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['projects'] })
      handleClose()
      setSuccess('Project created successfully')
    },
    onError: (error: Error) => {
      setError(error.message || 'Error creating project')
    }
  })

  const updateMutation = useMutation({
    mutationFn: ({ id, data }: { id: number; data: Partial<Project> }) =>
      updateProject(id, data),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['projects'] })
      handleClose()
      setSuccess('Project updated successfully')
    },
    onError: (error: Error) => {
      setError(error.message || 'Error updating project')
    }
  })

  const deleteMutation = useMutation({
    mutationFn: deleteProject,
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['projects'] })
      setSuccess('Project deleted successfully')
    },
    onError: (error: Error) => {
      setError(error.message || 'Error deleting project')
    }
  })

  const addMapUsageMutation = useMutation({
    mutationFn: ({ projectId, data }: { projectId: number; data: any }) =>
      addMapUsageToProject(projectId, data),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['projects'] });
      queryClient.invalidateQueries({ queryKey: ['project', selectedProject?.id] });
      setMapUsageFormData({
        interface_id: '',
        version_id: '',
        notes: ''
      });
      setSuccess('Map version added successfully');
    },
    onError: (error: Error) => {
      setError(error.message || 'Error adding map version');
    }
  })

  const removeMapUsageMutation = useMutation({
    mutationFn: ({ projectId, usageId }: { projectId: number; usageId: number }) =>
      removeMapUsageFromProject(projectId, usageId),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['projects'] });
      queryClient.invalidateQueries({ queryKey: ['project', selectedProject?.id] });
      setSuccess('Map version removed successfully');
    },
    onError: (error: Error) => {
      setError(error.message || 'Error removing map version');
    }
  })

  const handleOpen = () => {
    setOpen(true)
  }

  const handleClose = () => {
    setOpen(false)
    setEditProject(null)
    setFormData({
      name: '',
      location: '',
      notes: ''
    })
    setError(null)
  }

  const handleEdit = (project: Project) => {
    setEditProject(project)
    setFormData({
      name: project.name,
      location: project.location || '',
      notes: project.notes || ''
    })
    setOpen(true)
  }

  const handleSubmit = () => {
    if (editProject) {
      updateMutation.mutate({
        id: editProject.id,
        data: formData
      })
    } else {
      createMutation.mutate(formData)
    }
  }

  const handleMapUsageOpen = (project: Project) => {
    setSelectedProject(project)
    setMapUsageOpen(true)
  }

  const handleMapUsageClose = () => {
    setMapUsageOpen(false)
    setSelectedProject(null)
    setMapUsageFormData({
      interface_id: '',
      version_id: '',
      notes: ''
    })
  }

  const handleMapUsageSubmit = () => {
    if (!selectedProject) return

    addMapUsageMutation.mutate({
      projectId: selectedProject.id,
      data: mapUsageFormData
    })
  }

  const columns = [
    { id: 'name', label: 'Name', minWidth: 170, sortable: true },
    { id: 'location', label: 'Location', minWidth: 130, sortable: true },
    { id: 'notes', label: 'Notes', minWidth: 200, sortable: true },
    {
      id: 'actions',
      label: 'Actions',
      minWidth: 100,
      sortable: false,
      format: (_: any, row: any) => (
        <Box component="span" onClick={(e) => e.stopPropagation()}>
          <Button
            startIcon={<MapIcon />}
            onClick={() => handleMapUsageOpen(row)}
          >
            Map Versions
          </Button>
        </Box>
      )
    }
  ]

  return (
    <Box sx={{ 
      height: 'calc(100vh - 112px)', // Account for AppBar (64px) and padding (48px)
      display: 'flex',
      flexDirection: 'column'
    }}>
      <TableLayout
        title="Projects"
        columns={columns}
        data={projects}
        onAdd={handleOpen}
        onEdit={handleEdit}
        onDelete={(project) => {
          if (window.confirm('Are you sure you want to delete this project?')) {
            deleteMutation.mutate(project.id)
          }
        }}
      />

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

      {/* Project Details Dialog */}
      <Dialog open={open} onClose={handleClose}>
        <DialogTitle>
          {editProject ? 'Edit Project' : 'New Project'}
        </DialogTitle>
        <DialogContent>
          <TextField
            autoFocus
            margin="dense"
            label="Name"
            fullWidth
            value={formData.name}
            onChange={(e) => setFormData({ ...formData, name: e.target.value })}
          />
          <TextField
            margin="dense"
            label="Location"
            fullWidth
            value={formData.location}
            onChange={(e) => setFormData({ ...formData, location: e.target.value })}
          />
          <TextField
            margin="dense"
            label="Notes"
            fullWidth
            multiline
            rows={3}
            value={formData.notes}
            onChange={(e) => setFormData({ ...formData, notes: e.target.value })}
          />
        </DialogContent>
        <DialogActions>
          <Button onClick={handleClose}>Cancel</Button>
          <Button
            onClick={handleSubmit}
            variant="contained"
            disabled={!formData.name}
          >
            {editProject ? 'Update' : 'Create'}
          </Button>
        </DialogActions>
      </Dialog>

      {/* Map Usage Dialog */}
      <Dialog open={mapUsageOpen} onClose={handleMapUsageClose} maxWidth="md" fullWidth>
        <DialogTitle>
          Manage Map Versions - {currentProject?.name || selectedProject?.name}
        </DialogTitle>
        <DialogContent>
          <Box sx={{ mb: 3 }}>
            <Typography variant="h6" gutterBottom>
              Current Map Versions
            </Typography>
            <List>
              {currentProject?.mapUsages?.map((usage) => (
                <ListItem key={usage.id}>
                  <ListItemText
                    primary={`${usage.interface.name} - v${usage.version.version}`}
                    secondary={usage.notes}
                  />
                  <ListItemSecondaryAction>
                    <IconButton
                      edge="end"
                      onClick={() => removeMapUsageMutation.mutate({
                        projectId: currentProject.id,
                        usageId: usage.id
                      })}
                    >
                      <DeleteIcon />
                    </IconButton>
                  </ListItemSecondaryAction>
                </ListItem>
              ))}
            </List>
          </Box>

          <Divider sx={{ my: 2 }} />

          <Typography variant="h6" gutterBottom>
            Add New Map Version
          </Typography>
          <TextField
            select
            margin="dense"
            label="Interface"
            fullWidth
            value={mapUsageFormData.interface_id}
            onChange={(e) =>
              setMapUsageFormData({
                ...mapUsageFormData,
                interface_id: e.target.value,
                version_id: ''
              })
            }
          >
            {interfaces.map((interface_) => (
              <MenuItem key={interface_.id} value={interface_.id.toString()}>
                {interface_.name}
              </MenuItem>
            ))}
          </TextField>
          <TextField
            select
            margin="dense"
            label="Version"
            fullWidth
            value={mapUsageFormData.version_id}
            onChange={(e) =>
              setMapUsageFormData({
                ...mapUsageFormData,
                version_id: e.target.value
              })
            }
            disabled={!mapUsageFormData.interface_id}
          >
            {versions.map((version) => (
              <MenuItem key={version.id} value={version.id.toString()}>
                v{version.version}
              </MenuItem>
            ))}
          </TextField>
          <TextField
            margin="dense"
            label="Notes"
            fullWidth
            multiline
            rows={2}
            value={mapUsageFormData.notes}
            onChange={(e) =>
              setMapUsageFormData({
                ...mapUsageFormData,
                notes: e.target.value
              })
            }
          />
        </DialogContent>
        <DialogActions>
          <Button onClick={handleMapUsageClose}>Close</Button>
          <Button
            onClick={handleMapUsageSubmit}
            variant="contained"
            disabled={!mapUsageFormData.interface_id || !mapUsageFormData.version_id}
          >
            Add Version
          </Button>
        </DialogActions>
      </Dialog>
    </Box>
  )
}