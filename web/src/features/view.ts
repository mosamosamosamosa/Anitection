import { createSlice } from '@reduxjs/toolkit';

export type View = {
  loginModal: boolean;
  sidebar: boolean;
  mobile: boolean;
};

export type ViewState = View;

const initialState: ViewState = {
  loginModal: false,
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
