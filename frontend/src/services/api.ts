import axios from 'axios'

const api = axios.create({
    baseURL: '/api'
})

// API Provider endpoints
export const getApiProviders = () => api.get('/api-providers')
export const getApiProvider = (id: number) => api.get(`/api-providers/${id}`)
export const createApiProvider = (data: any) => api.post('/api-providers', data)
export const updateApiProvider = (id: number, data: any) => api.put(`/api-providers/${id}`, data)
export const deleteApiProvider = (id: number) => api.delete(`/api-providers/${id}`)

// Data Interface endpoints
export const getDataInterfaces = () => api.get('/data-interfaces')
export const getDataInterface = (id: number) => api.get(`/data-interfaces/${id}`)
export const createDataInterface = (data: any) => api.post('/data-interfaces', data)
export const updateDataInterface = (id: number, data: any) => api.put(`/data-interfaces/${id}`, data)
export const deleteDataInterface = (id: number) => api.delete(`/data-interfaces/${id}`)

// Map Version endpoints
export const getMapVersions = () => api.get('/map-versions')
export const getMapVersion = (id: number) => api.get(`/map-versions/${id}`)
export const getMapVersionsByInterface = (interfaceId: number) => api.get(`/map-versions/interface/${interfaceId}`)
export const createMapVersion = (data: any) => api.post('/map-versions', data)
export const updateMapVersion = (id: number, data: any) => api.put(`/map-versions/${id}`, data)
export const deleteMapVersion = (id: number) => api.delete(`/map-versions/${id}`)

// Map Point endpoints
export const getMapPoints = () => api.get('/map-points')
export const getMapPointsByVersion = (versionId: number) => api.get(`/map-points/version/${versionId}`)
export const getMapPoint = (id: number) => api.get(`/map-points/${id}`)
export const createMapPoint = (data: any) => api.post('/map-points', data)
export const createMapPointsBulk = (data: any[]) => api.post('/map-points/bulk', data)
export const updateMapPoint = (id: number, data: any) => api.put(`/map-points/${id}`, data)
export const deleteMapPoint = (id: number) => api.delete(`/map-points/${id}`)

// Project endpoints
export const getProjects = () => api.get('/projects')
export const getProject = (id: number) => api.get(`/projects/${id}`)
export const createProject = (data: any) => api.post('/projects', data)
export const updateProject = (id: number, data: any) => api.put(`/projects/${id}`, data)
export const deleteProject = (id: number) => api.delete(`/projects/${id}`)
export const addMapUsageToProject = (projectId: number, data: any) => api.post(`/projects/${projectId}/map-usage`, data)
export const removeMapUsageFromProject = (usageId: number) => api.delete(`/projects/map-usage/${usageId}`)