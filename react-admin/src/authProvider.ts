import { AuthProvider } from 'react-admin';

const API_URL = import.meta.env.VITE_API_URL || 'http://localhost:3000/api';

export const authProvider: AuthProvider = {
  login: async ({ username, password }) => {
    // API_URL might be http://localhost:80/api/v1, but auth is at /api/auth/login
    const baseUrl = API_URL.replace(/\/v1\/?$/, '');
    const request = new Request(`${baseUrl}/auth/login`, {
      method: 'POST',
      body: JSON.stringify({ username, password }),
      headers: new Headers({ 'Content-Type': 'application/json' }),
    });

    const response = await fetch(request);
    if (response.status < 200 || response.status >= 300) {
      throw new Error(response.statusText);
    }

    const auth = await response.json();
    localStorage.setItem('token', auth.token);
    localStorage.setItem('user', JSON.stringify(auth.user));
    
    return Promise.resolve();
  },

  logout: () => {
    localStorage.removeItem('token');
    localStorage.removeItem('user');
    return Promise.resolve();
  },

  checkError: (error) => {
    const status = error.status;
    if (status === 401 || status === 403) {
      localStorage.removeItem('token');
      localStorage.removeItem('user');
      return Promise.reject();
    }
    return Promise.resolve();
  },

  checkAuth: () => {
    return localStorage.getItem('token')
      ? Promise.resolve()
      : Promise.reject();
  },

  getPermissions: () => {
    return Promise.resolve();
  },

  getIdentity: () => {
    try {
      const user = JSON.parse(localStorage.getItem('user') || '{}');
      return Promise.resolve({
        id: user.id,
        fullName: user.username,
        avatar: undefined,
      });
    } catch (error) {
      return Promise.reject(error);
    }
  },
};
