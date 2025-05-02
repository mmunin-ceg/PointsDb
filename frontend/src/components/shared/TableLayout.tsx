import { Box, Paper, Table, TableBody, TableCell, TableContainer, TableHead, TableRow, Typography, Button, IconButton, TableSortLabel } from '@mui/material'
import DeleteIcon from '@mui/icons-material/Delete'
import EditIcon from '@mui/icons-material/Edit'
import { useState } from 'react'

interface Column {
  id: string
  label: string
  minWidth?: number
  format?: (value: any, row?: any) => string | JSX.Element
  sortable?: boolean
}

interface TableLayoutProps {
  title: string
  columns: Column[]
  data: any[]
  onAdd?: () => void
  onEdit?: (row: any) => void
  onDelete?: (row: any) => void
}

type Order = 'asc' | 'desc'

export const TableLayout = ({ title, columns, data, onAdd, onEdit, onDelete }: TableLayoutProps) => {
  const [orderBy, setOrderBy] = useState<string>('')
  const [order, setOrder] = useState<Order>('asc')

  const handleSort = (columnId: string) => {
    const isAsc = orderBy === columnId && order === 'asc'
    setOrder(isAsc ? 'desc' : 'asc')
    setOrderBy(columnId)
  }

  const sortedData = [...data].sort((a, b) => {
    if (!orderBy) return 0

    const getValue = (obj: any, columnId: string) => {
      const column = columns.find(col => col.id === columnId)
      if (column?.format) {
        return column.format(obj[columnId], obj)
      }
      return obj[columnId]
    }

    const aValue = getValue(a, orderBy)
    const bValue = getValue(b, orderBy)

    if (aValue === null) return order === 'asc' ? 1 : -1
    if (bValue === null) return order === 'asc' ? -1 : 1

    if (typeof aValue === 'string') {
      return order === 'asc' 
        ? aValue.localeCompare(bValue)
        : bValue.localeCompare(aValue)
    }

    return order === 'asc' 
      ? (aValue < bValue ? -1 : 1)
      : (bValue < aValue ? -1 : 1)
  })

  return (
    <Box sx={{ 
      display: 'flex', 
      flexDirection: 'column',
      height: '100%',
      width: '100%'
    }}>
      <Box sx={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', mb: 2 }}>
        <Typography variant="h5" component="h2">
          {title}
        </Typography>
        {onAdd && (
          <Button variant="contained" color="primary" onClick={onAdd}>
            Add New
          </Button>
        )}
      </Box>
      <Paper sx={{ flex: 1, width: '100%', overflow: 'hidden', display: 'flex', flexDirection: 'column' }}>
        <TableContainer sx={{ flex: 1 }}>
          <Table stickyHeader size="small">
            <TableHead>
              <TableRow>
                {columns.map((column) => (
                  <TableCell
                    key={column.id}
                    style={{ minWidth: column.minWidth }}
                    sortDirection={orderBy === column.id ? order : false}
                    sx={{ padding: '6px 16px' }}
                  >
                    {column.sortable !== false ? (
                      <TableSortLabel
                        active={orderBy === column.id}
                        direction={orderBy === column.id ? order : 'asc'}
                        onClick={() => handleSort(column.id)}
                      >
                        {column.label}
                      </TableSortLabel>
                    ) : (
                      column.label
                    )}
                  </TableCell>
                ))}
                {(onEdit || onDelete) && <TableCell>Actions</TableCell>}
              </TableRow>
            </TableHead>
            <TableBody>
              {sortedData.map((row, index) => (
                <TableRow hover key={index} sx={{ height: '40px' }}>
                  {columns.map((column) => (
                    <TableCell key={column.id} sx={{ padding: '6px 16px' }}>
                      {column.format ? column.format(row[column.id], row) : row[column.id]}
                    </TableCell>
                  ))}
                  {(onEdit || onDelete) && (
                    <TableCell sx={{ padding: '6px 16px' }}>
                      <Box sx={{ display: 'flex', flexDirection: 'row' }}>
                        {onEdit && (
                          <IconButton onClick={() => onEdit(row)} size="small">
                            <EditIcon />
                          </IconButton>
                        )}
                        {onDelete && (
                          <IconButton onClick={() => onDelete(row)} size="small">
                            <DeleteIcon />
                          </IconButton>
                        )}
                      </Box>
                    </TableCell>
                  )}
                </TableRow>
              ))}
            </TableBody>
          </Table>
        </TableContainer>
      </Paper>
    </Box>
  )
}