import { createSlice } from '@reduxjs/toolkit';

export type User = {
  user: any;
};

export type UserState = User;

const initialState: UserState = {
  user: null,
};

export const userSlice = createSlice({
  name: 'user',
  initialState,
  reducers: {
    setUser: (state, action) => {
      state.user = action.payload;
    },
  },
});
