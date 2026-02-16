export interface User {
  id: string;
  email: string;
  username: string;
  password_hash?: string;
  oauth_provider?: string;
  oauth_id?: string;
  is_active: boolean;
  created_at: Date;
  updated_at: Date;
}

export interface Post {
  id: string;
  user_id: string;
  title: string;
  content?: string;
  status: string;
  created_at: Date;
  updated_at: Date;
}

export interface APIKey {
  id: string;
  user_id: string;
  key_hash: string;
  name: string;
  expires_at?: Date;
  is_active: boolean;
  created_at: Date;
}

export interface Session {
  id: string;
  user_id: string;
  token_hash: string;
  expires_at: Date;
  created_at: Date;
}

export interface Role {
  id: string;
  name: string;
  description?: string;
  created_at: Date;
}

export interface JWTPayload {
  userId: string;
  username: string;
  email: string;
}
