import { fetchUtils, DataProvider } from 'react-admin';
import simpleRestProvider from 'ra-data-simple-rest';

const API_URL = import.meta.env.VITE_API_URL || 'http://localhost:3000';

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

const baseDataProvider = simpleRestProvider(`${API_URL}/api/v1`, httpClient);

export const dataProvider: DataProvider = {
  ...baseDataProvider,

  // Customize getList to handle pagination properly
  getList: (resource, _params) => {
    // const { page, perPage } = params.pagination;
    // const { field, order } = params.sort;

    return httpClient(`${API_URL}/api/${resource}`)
      .then(({ json }) => {
        // If the API doesn't return pagination info, create it
        const data = Array.isArray(json) ? json : [];
        return {
          data: data,
          total: data.length,
        };
      });
  },

  // Customize getOne to handle responses properly
  getOne: (resource, params) =>
    httpClient(`${API_URL}/api/${resource}/${params.id}`)
      .then(({ json }) => ({ data: json })),

  // Customize create
  create: (resource, params) =>
    httpClient(`${API_URL}/api/${resource}`, {
      method: 'POST',
      body: JSON.stringify(params.data),
    }).then(({ json }) => ({ data: { ...params.data, id: json.id } as any })),

  // Customize update
  update: (resource, params) =>
    httpClient(`${API_URL}/api/${resource}/${params.id}`, {
      method: 'PUT',
      body: JSON.stringify(params.data),
    }).then(() => ({ data: { ...params.data, id: params.id } as any })),

  // Customize delete
  delete: (resource, params) =>
    httpClient(`${API_URL}/api/${resource}/${params.id}`, {
      method: 'DELETE',
    }).then(() => ({ data: { id: params.id } as any })),
};
