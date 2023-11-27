import { createSlice } from '@reduxjs/toolkit';

export type View = {
  loginModal: boolean;
  sidebar: boolean;
};

export type ViewState = View;

const initialState: ViewState = {
  loginModal: false,
  sidebar: false,
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
  },
});
