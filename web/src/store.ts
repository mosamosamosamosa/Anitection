import { combineReducers } from 'redux';
import { configureStore } from '@reduxjs/toolkit';

import { viewSlice, ViewState } from './features/view';
import { userSlice, UserState } from './features/user';

export type RootState = {
  view: ViewState;
  user: UserState;
};

const rootReducer = combineReducers<RootState>({
  view: viewSlice.reducer,
  user: userSlice.reducer,
});

export const store = configureStore({ reducer: rootReducer });
