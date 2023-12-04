import { createSlice } from '@reduxjs/toolkit';

export type User = {
  username: string;
  email: string;
  token: string;
};

export type UserState = User;

const initialState: UserState = {
  username: '',
  email: '',
  token: localStorage.getItem('token') || '',
};

export const userSlice = createSlice({
  name: 'user',
  initialState,
  reducers: {
    setUsername: (state, action) => {
      state.username = action.payload;
    },
    setEmail: (state, action) => {
      state.email = action.payload;
    },
    setToken: (state, action) => {
      localStorage.setItem('token', action.payload);
      state.token = action.payload;
    },
  },
});
