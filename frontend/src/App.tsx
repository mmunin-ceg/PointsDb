import { BrowserRouter, Routes, Route, Link } from 'react-router-dom'
import { QueryClient, QueryClientProvider } from '@tanstack/react-query'
import {
  AppBar,
  Box,
  CssBaseline,
  Drawer,
  List,
  ListItem,
  ListItemIcon,
  ListItemText,
  ThemeProvider,
  Toolbar,
  Typography,
  createTheme
} from '@mui/material'
import {
  Api as ApiIcon,
  Router as RouterIcon,
  Code as CodeIcon,
  AccountTree as AccountTreeIcon,
  Business as BusinessIcon
} from '@mui/icons-material'
import { ApiProviders } from './components/ApiProviders'
import { DataInterfaces } from './components/DataInterfaces'
import { MapVersions } from './components/MapVersions'
import { MapPoints } from './components/MapPoints'
import { Projects } from './components/Projects'

const drawerWidth = 240
const queryClient = new QueryClient()
const theme = createTheme()

const menuItems = [
  { text: 'API Providers', icon: <ApiIcon />, path: '/' },
  { text: 'Data Interfaces', icon: <RouterIcon />, path: '/interfaces' },
  { text: 'Map Versions', icon: <CodeIcon />, path: '/versions' },
  { text: 'Map Points', icon: <AccountTreeIcon />, path: '/points' },
  { text: 'Projects', icon: <BusinessIcon />, path: '/projects' }
]

function App() {
  return (
    <QueryClientProvider client={queryClient}>
      <ThemeProvider theme={theme}>
        <BrowserRouter>
          <Box sx={{ display: 'flex' }}>
            <CssBaseline />
            
            <AppBar position="fixed" sx={{ zIndex: (theme) => theme.zIndex.drawer + 1 }}>
              <Toolbar>
                <Typography variant="h6" noWrap component="div">
                  Points Database Manager
                </Typography>
              </Toolbar>
            </AppBar>

            <Drawer
              variant="permanent"
              sx={{
                width: drawerWidth,
                flexShrink: 0,
                '& .MuiDrawer-paper': {
                  width: drawerWidth,
                  boxSizing: 'border-box'
                }
              }}
            >
              <Toolbar />
              <Box sx={{ overflow: 'auto' }}>
                <List>
                  {menuItems.map((item) => (
                    <ListItem key={item.text} component={Link} to={item.path}>
                      <ListItemIcon>{item.icon}</ListItemIcon>
                      <ListItemText primary={item.text} />
                    </ListItem>
                  ))}
                </List>
              </Box>
            </Drawer>

            <Box component="main" sx={{ flexGrow: 1, p: 3 }}>
              <Toolbar />
              <Routes>
                <Route path="/" element={<ApiProviders />} />
                <Route path="/interfaces" element={<DataInterfaces />} />
                <Route path="/versions" element={<MapVersions />} />
                <Route path="/points" element={<MapPoints />} />
                <Route path="/projects" element={<Projects />} />
              </Routes>
            </Box>
          </Box>
        </BrowserRouter>
      </ThemeProvider>
    </QueryClientProvider>
  )
}

export default App
