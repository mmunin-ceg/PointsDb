import { useState } from 'react'
import { useQuery, useMutation, useQueryClient } from '@tanstack/react-query'
import { Dialog, DialogTitle, DialogContent, TextField, DialogActions, Button, Switch, FormControlLabel } from '@mui/material'
import { TableLayout } from './shared/TableLayout'
import { getApiProviders, createApiProvider, updateApiProvider, deleteApiProvider } from '../services/api'
import { ApiProvider } from '../types'

export const ApiProviders = () => {
  const queryClient = useQueryClient()
  const [open, setOpen] = useState(false)
  const [editProvider, setEditProvider] = useState<ApiProvider | null>(null)
  const [formData, setFormData] = useState({
    name: '',
    is_internal: false
  })

  const { data: providers = [] } = useQuery<ApiProvider[]>({
    queryKey: ['providers'],
    queryFn: async () => {
      const response = await getApiProviders()
      return response.data
    }
  })

  const createMutation = useMutation({
    mutationFn: createApiProvider,
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['providers'] })
      handleClose()
    }
  })

  const updateMutation = useMutation({
    mutationFn: ({ id, data }: { id: number; data: Partial<ApiProvider> }) =>
      updateApiProvider(id, data),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['providers'] })
      handleClose()
    }
  })

  const deleteMutation = useMutation({
    mutationFn: deleteApiProvider,
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['providers'] })
    }
  })

  const handleOpen = () => {
    setOpen(true)
  }

  const handleClose = () => {
    setOpen(false)
    setEditProvider(null)
    setFormData({ name: '', is_internal: false })
  }

  const handleEdit = (provider: ApiProvider) => {
    setEditProvider(provider)
    setFormData({
      name: provider.name,
      is_internal: provider.is_internal
    })
    setOpen(true)
  }

  const handleSubmit = () => {
    if (editProvider) {
      updateMutation.mutate({
        id: editProvider.id,
        data: formData
      })
    } else {
      createMutation.mutate(formData)
    }
  }

  const columns = [
    { id: 'name', label: 'Name', minWidth: 170, sortable: true },
    {
      id: 'is_internal',
      label: 'Internal',
      minWidth: 100,
      sortable: true,
      format: (value: boolean) => (value ? 'Yes' : 'No')
    }
  ]

  return (
    <>
      <TableLayout
        title="API Providers"
        columns={columns}
        data={providers}
        onAdd={handleOpen}
        onEdit={handleEdit}
        onDelete={(provider) => deleteMutation.mutate(provider.id)}
      />

      <Dialog open={open} onClose={handleClose}>
        <DialogTitle>{editProvider ? 'Edit Provider' : 'New Provider'}</DialogTitle>
        <DialogContent>
          <TextField
            autoFocus
            margin="dense"
            label="Name"
            fullWidth
            value={formData.name}
            onChange={(e) => setFormData({ ...formData, name: e.target.value })}
          />
          <FormControlLabel
            control={
              <Switch
                checked={formData.is_internal}
                onChange={(e) => setFormData({ ...formData, is_internal: e.target.checked })}
              />
            }
            label="Internal Provider"
          />
        </DialogContent>
        <DialogActions>
          <Button onClick={handleClose}>Cancel</Button>
          <Button onClick={handleSubmit} variant="contained">
            {editProvider ? 'Update' : 'Create'}
          </Button>
        </DialogActions>
      </Dialog>
    </>
  )
}