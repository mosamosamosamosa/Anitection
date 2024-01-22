import { createSlice } from '@reduxjs/toolkit';

export type View = {
  loginModal: boolean;
  registerModal: boolean;
  sidebar: boolean;
};

export type ViewState = View;

const initialState: ViewState = {
  loginModal: localStorage.getItem('token') ? false : true,
  registerModal: false,
  sidebar: false,
};

export const viewSlice = createSlice({
  name: 'view',
  initialState,
  reducers: {
    setRegisterModal: (state, action) => {
      state.registerModal = action.payload;
    },
    setLoginModal: (state, action) => {
      state.loginModal = action.payload;
    },
    setSidebar: (state, action) => {
      state.sidebar = action.payload;
    },
  },
});
