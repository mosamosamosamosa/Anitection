import { createSlice } from '@reduxjs/toolkit';

export type View = {
  loginModal: boolean;
  registerModal: boolean;
  sidebar: boolean;
  mobile: boolean;
};

export type ViewState = View;

const initialState: ViewState = {
  loginModal: false,
  registerModal: false,
  sidebar: true,
  mobile: false,
};

export const viewSlice = createSlice({
  name: 'view',
  initialState,
  reducers: {
    toggleLoginModal: (state) => {
      state.loginModal = !state.loginModal;
    },
    toggleRegisterModal: (state) => {
      state.registerModal = !state.registerModal;
    },
    resetModal: (state) => {
      state.loginModal = false;
      state.registerModal = false;
    },
    toggleSidebar: (state) => {
      state.sidebar = !state.sidebar;
    },
    setMobile: (state, action) => {
      state.mobile = action.payload;
    },
    setLoginModal: (state, action) => {
      state.loginModal = action.payload;
    },
    setSidebar: (state, action) => {
      state.sidebar = action.payload;
    },
  },
});
