import { useState } from 'react'
import { useQuery, useMutation, useQueryClient } from '@tanstack/react-query'
import {
  Dialog,
  DialogTitle,
  DialogContent,
  TextField,
  DialogActions,
  Button,
  MenuItem
} from '@mui/material'
import { TableLayout } from './shared/TableLayout'
import {
  getMapVersions,
  getDataInterfaces,
  createMapVersion,
  updateMapVersion,
  deleteMapVersion
} from '../services/api'
import { MapVersion, DataInterface } from '../types'

export const MapVersions = () => {
  const queryClient = useQueryClient()
  const [open, setOpen] = useState(false)
  const [editVersion, setEditVersion] = useState<MapVersion | null>(null)
  const [formData, setFormData] = useState({
    interface_id: '',
    version: '',
    release_date: '',
    changelog: ''
  })

  const { data: versions = [] } = useQuery<MapVersion[]>({
    queryKey: ['versions'],
    queryFn: async () => {
      const response = await getMapVersions()
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

  const createMutation = useMutation({
    mutationFn: createMapVersion,
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['versions'] })
      handleClose()
    }
  })

  const updateMutation = useMutation({
    mutationFn: ({ id, data }: { id: number; data: Partial<MapVersion> }) =>
      updateMapVersion(id, data),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['versions'] })
      handleClose()
    }
  })

  const deleteMutation = useMutation({
    mutationFn: deleteMapVersion,
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['versions'] })
    }
  })

  const handleOpen = () => {
    setOpen(true)
  }

  const handleClose = () => {
    setOpen(false)
    setEditVersion(null)
    setFormData({
      interface_id: '',
      version: '',
      release_date: '',
      changelog: ''
    })
  }

  const handleEdit = (version: MapVersion) => {
    setEditVersion(version)
    setFormData({
      interface_id: version.interface.id.toString(),
      version: version.version,
      release_date: version.release_date ? new Date(version.release_date).toISOString().split('T')[0] : '',
      changelog: version.changelog || ''
    })
    setOpen(true)
  }

  const handleSubmit = async (event: React.FormEvent<HTMLFormElement>) => {
    event.preventDefault()
    const formData = new FormData(event.currentTarget)
    const submitData = {
      interface_id: Number(formData.get('interface_id')),
      version: formData.get('version') as string,
      release_date: new Date(formData.get('release_date') as string),
      changelog: formData.get('changelog') as string
    }

    if (editVersion) {
      updateMutation.mutate({
        id: editVersion.id,
        data: submitData
      })
    } else {
      createMutation.mutate(submitData)
    }
  }

  const columns = [
    {
      id: 'interface',
      label: 'Interface',
      minWidth: 170,
      sortable: true,
      format: (value: DataInterface) => value.name
    },
    { id: 'version', label: 'Version', minWidth: 100, sortable: true },
    {
      id: 'release_date',
      label: 'Release Date',
      minWidth: 130,
      sortable: true,
      format: (value: string) =>
        value ? new Date(value).toLocaleDateString() : ''
    },
    { id: 'changelog', label: 'Changelog', minWidth: 200, sortable: true }
  ]

  return (
    <>
      <TableLayout
        title="Map Versions"
        columns={columns}
        data={versions}
        onAdd={handleOpen}
        onEdit={handleEdit}
        onDelete={(version) => deleteMutation.mutate(version.id)}
      />

      <Dialog open={open} onClose={handleClose}>
        <form onSubmit={handleSubmit}>
          <DialogTitle>
            {editVersion ? 'Edit Version' : 'New Version'}
          </DialogTitle>
          <DialogContent>
            <TextField
              select
              margin="dense"
              label="Interface"
              fullWidth
              name="interface_id"
              value={formData.interface_id}
              onChange={(e) =>
                setFormData({ ...formData, interface_id: e.target.value })
              }
            >
              {interfaces.map((interface_) => (
                <MenuItem key={interface_.id} value={interface_.id.toString()}>
                  {interface_.name}
                </MenuItem>
              ))}
            </TextField>
            <TextField
              autoFocus
              margin="dense"
              label="Version"
              fullWidth
              name="version"
              value={formData.version}
              onChange={(e) => setFormData({ ...formData, version: e.target.value })}
            />
            <TextField
              margin="dense"
              label="Release Date"
              type="date"
              fullWidth
              name="release_date"
              InputLabelProps={{
                shrink: true
              }}
              value={formData.release_date}
              onChange={(e) =>
                setFormData({ ...formData, release_date: e.target.value })
              }
            />
            <TextField
              margin="dense"
              label="Changelog"
              fullWidth
              multiline
              rows={4}
              name="changelog"
              value={formData.changelog}
              onChange={(e) =>
                setFormData({ ...formData, changelog: e.target.value })
              }
            />
          </DialogContent>
          <DialogActions>
            <Button onClick={handleClose}>Cancel</Button>
            <Button
              type="submit"
              variant="contained"
              disabled={!formData.interface_id || !formData.version}
            >
              {editVersion ? 'Update' : 'Create'}
            </Button>
          </DialogActions>
        </form>
      </Dialog>
    </>
  )
}