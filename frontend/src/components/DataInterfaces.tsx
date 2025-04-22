import { useState } from 'react'
import { useQuery, useMutation, useQueryClient } from '@tanstack/react-query'
import {
  Dialog,
  DialogTitle,
  DialogContent,
  TextField,
  DialogActions,
  Button,
  Switch,
  FormControlLabel,
  MenuItem
} from '@mui/material'
import { TableLayout } from './shared/TableLayout'
import {
  getDataInterfaces,
  createDataInterface,
  updateDataInterface,
  deleteDataInterface,
  getApiProviders
} from '../services/api'
import { DataInterface, ApiProvider } from '../types'

const PROTOCOLS = ['Modbus', 'DNP3', 'SEL', 'Other']

type Protocol = "Modbus" | "DNP3" | "SEL" | "Other";

export const DataInterfaces = () => {
  const queryClient = useQueryClient()
  const [open, setOpen] = useState(false)
  const [editInterface, setEditInterface] = useState<DataInterface | null>(null)
  const [formData, setFormData] = useState({
    name: '',
    protocol: 'Modbus',
    provider_id: '',
    is_internal: false,
    description: ''
  })

  const { data: interfaces = [] } = useQuery<DataInterface[]>({
    queryKey: ['interfaces'],
    queryFn: async () => {
      const response = await getDataInterfaces()
      return response.data
    }
  })

  const { data: providers = [] } = useQuery<ApiProvider[]>({
    queryKey: ['providers'],
    queryFn: async () => {
      const response = await getApiProviders()
      return response.data
    }
  })

  const createMutation = useMutation({
    mutationFn: createDataInterface,
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['interfaces'] })
      handleClose()
    }
  })

  const updateMutation = useMutation({
    mutationFn: ({ id, data }: { id: number; data: Partial<DataInterface> }) =>
      updateDataInterface(id, data),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['interfaces'] })
      handleClose()
    }
  })

  const deleteMutation = useMutation({
    mutationFn: deleteDataInterface,
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['interfaces'] })
    }
  })

  const handleOpen = () => {
    setOpen(true)
  }

  const handleClose = () => {
    setOpen(false)
    setEditInterface(null)
    setFormData({
      name: '',
      protocol: 'Modbus',
      provider_id: '',
      is_internal: false,
      description: ''
    })
  }

  const handleEdit = (interface_: DataInterface) => {
    setEditInterface(interface_)
    setFormData({
      name: interface_.name,
      protocol: interface_.protocol,
      provider_id: interface_.provider.id.toString(),
      is_internal: interface_.is_internal,
      description: interface_.description || ''
    })
    setOpen(true)
  }

  const handleSubmit = async (event: React.FormEvent<HTMLFormElement>) => {
    event.preventDefault();
    const formData = new FormData(event.currentTarget);
    const submitData = {
        provider_id: Number(formData.get('provider_id')),
        name: formData.get('name') as string,
        protocol: formData.get('protocol') as Protocol,
        is_internal: Boolean(formData.get('is_internal')),
        description: formData.get('description') as string
    };

    if (editInterface) {
      updateMutation.mutate({
        id: editInterface.id,
        data: submitData
      })
    } else {
      createMutation.mutate(submitData)
    }
  }

  const columns = [
    { id: 'name', label: 'Name', minWidth: 170 },
    { id: 'protocol', label: 'Protocol', minWidth: 100 },
    {
      id: 'provider',
      label: 'Provider',
      minWidth: 130,
      format: (value: ApiProvider) => value.name
    },
    {
      id: 'is_internal',
      label: 'Internal',
      minWidth: 100,
      format: (value: boolean) => (value ? 'Yes' : 'No')
    },
    { id: 'description', label: 'Description', minWidth: 200 }
  ]

  return (
    <>
      <TableLayout
        title="Data Interfaces"
        columns={columns}
        data={interfaces}
        onAdd={handleOpen}
        onEdit={handleEdit}
        onDelete={(interface_) => deleteMutation.mutate(interface_.id)}
      />

      <Dialog open={open} onClose={handleClose}>
        <form onSubmit={handleSubmit}>
          <DialogTitle>
            {editInterface ? 'Edit Interface' : 'New Interface'}
          </DialogTitle>
          <DialogContent>
            <TextField
              autoFocus
              margin="dense"
              name="name"
              label="Name"
              fullWidth
              value={formData.name}
              onChange={(e) => setFormData({ ...formData, name: e.target.value })}
            />
            <TextField
              select
              margin="dense"
              name="protocol"
              label="Protocol"
              fullWidth
              value={formData.protocol}
              onChange={(e) => setFormData({ ...formData, protocol: e.target.value })}
            >
              {PROTOCOLS.map((protocol) => (
                <MenuItem key={protocol} value={protocol}>
                  {protocol}
                </MenuItem>
              ))}
            </TextField>
            <TextField
              select
              margin="dense"
              name="provider_id"
              label="Provider"
              fullWidth
              value={formData.provider_id}
              onChange={(e) =>
                setFormData({ ...formData, provider_id: e.target.value })
              }
            >
              {providers.map((provider) => (
                <MenuItem key={provider.id} value={provider.id.toString()}>
                  {provider.name}
                </MenuItem>
              ))}
            </TextField>
            <FormControlLabel
              control={
                <Switch
                  name="is_internal"
                  checked={formData.is_internal}
                  onChange={(e) =>
                    setFormData({ ...formData, is_internal: e.target.checked })
                  }
                />
              }
              label="Internal Interface"
            />
            <TextField
              margin="dense"
              name="description"
              label="Description"
              fullWidth
              multiline
              rows={3}
              value={formData.description}
              onChange={(e) =>
                setFormData({ ...formData, description: e.target.value })
              }
            />
          </DialogContent>
          <DialogActions>
            <Button onClick={handleClose}>Cancel</Button>
            <Button
              type="submit"
              variant="contained"
              disabled={!formData.name || !formData.provider_id}
            >
              {editInterface ? 'Update' : 'Create'}
            </Button>
          </DialogActions>
        </form>
      </Dialog>
    </>
  )
}