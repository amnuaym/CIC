import { fetchUtils, DataProvider } from 'react-admin';

// All API calls go through the nginx gateway
const API_URL = import.meta.env.VITE_API_URL || 'http://localhost:80/api/v1';

const httpClient = (url: string, options: fetchUtils.Options = {}) => {
  if (!options.headers) {
    options.headers = new Headers({ Accept: 'application/json' });
  }
  const token = localStorage.getItem('token');
  if (token) {
    (options.headers as Headers).set('Authorization', `Bearer ${token}`);
  }
  return fetchUtils.fetchJson(url, options);
};

// Map dashboard resource names to actual API resource paths
// Both individuals and juristic use the /customers endpoint with type filter
const resourceConfig: Record<string, { apiResource: string; extraParams?: Record<string, string> }> = {
  individuals: { apiResource: 'customers', extraParams: { type: 'PERSONAL' } },
  juristics:    { apiResource: 'customers', extraParams: { type: 'JURISTIC' } },
  consents:    { apiResource: 'consents' },
  'audit-logs': { apiResource: 'audit-logs' },
  users:       { apiResource: 'users' },
};

const getConfig = (resource: string) => {
  return resourceConfig[resource] || { apiResource: resource };
};

export const dataProvider: DataProvider = {
  getList: (resource, params) => {
    const config = getConfig(resource);
    const url = new URL(`${API_URL}/${config.apiResource}`, window.location.origin);

    // Apply type filter for individuals/juristic
    if (config.extraParams) {
      Object.entries(config.extraParams).forEach(([key, value]) => {
        url.searchParams.set(key, value);
      });
    }

    // Search-first: for customer and consent resources, require a search query
    const isSearchFirstResource = resource === 'individuals' || resource === 'juristics' || resource === 'consents';
    const searchQuery = params.filter?.q;
    if (isSearchFirstResource && (!searchQuery || searchQuery.toString().trim() === '')) {
      return Promise.resolve({ data: [], total: 0 });
    }

    // Apply react-admin filters
    if (params.filter) {
      Object.entries(params.filter).forEach(([key, value]) => {
        if (value !== undefined && value !== null && value !== '') {
          url.searchParams.set(key, String(value));
        }
      });
    }

    return httpClient(url.toString())
      .then(({ json }) => {
        const data = Array.isArray(json) ? json : [];
        return { data, total: data.length };
      });
  },

  getOne: (resource, params) => {
    const config = getConfig(resource);
    return httpClient(`${API_URL}/${config.apiResource}/${params.id}`)
      .then(({ json }) => ({ data: json }));
  },

  create: (resource, params) => {
    const config = getConfig(resource);
    // Auto-inject type for individuals/juristic
    const body = { ...params.data };
    if (resource === 'individuals') body.type = 'PERSONAL';
    if (resource === 'juristics') body.type = 'JURISTIC';

    return httpClient(`${API_URL}/${config.apiResource}`, {
      method: 'POST',
      body: JSON.stringify(body),
    }).then(({ json }) => ({ data: { ...body, id: json.id } as any }));
  },

  update: (resource, params) => {
    const config = getConfig(resource);
    return httpClient(`${API_URL}/${config.apiResource}/${params.id}`, {
      method: 'PUT',
      body: JSON.stringify(params.data),
    }).then(() => ({ data: { ...params.data, id: params.id } as any }));
  },

  delete: (resource, params) => {
    const config = getConfig(resource);
    return httpClient(`${API_URL}/${config.apiResource}/${params.id}`, {
      method: 'DELETE',
    }).then(() => ({ data: { id: params.id } as any }));
  },

  getMany: (resource, params) => {
    const config = getConfig(resource);
    return Promise.all(
      params.ids.map(id =>
        httpClient(`${API_URL}/${config.apiResource}/${id}`)
          .then(({ json }) => json)
      )
    ).then(data => ({ data }));
  },

  getManyReference: (resource, params) => {
    const config = getConfig(resource);
    const url = `${API_URL}/${config.apiResource}?${params.target}=${params.id}`;
    return httpClient(url)
      .then(({ json }) => {
        const data = Array.isArray(json) ? json : [];
        return { data, total: data.length };
      });
  },

  updateMany: (_resource, _params) => Promise.reject('Not supported'),
  deleteMany: (_resource, _params) => Promise.reject('Not supported'),

  // Custom restore method
  restore: (resource: string, params: { id: string | number }) => {
    const config = getConfig(resource);
    return httpClient(`${API_URL}/${config.apiResource}/${params.id}/restore`, {
      method: 'POST',
    }).then(({ json }) => ({ data: json }));
  },
};
