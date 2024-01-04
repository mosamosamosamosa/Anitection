import { combineReducers } from 'redux';
import { configureStore } from '@reduxjs/toolkit';

import { viewSlice, ViewState } from './features/view';
import { userSlice, UserState } from './features/user';
import { institutionSlice, InstitutionState } from './features/institution';

export type RootState = {
  view: ViewState;
  user: UserState;
  institution: InstitutionState;
};

const rootReducer = combineReducers<RootState>({
  view: viewSlice.reducer,
  user: userSlice.reducer,
  institution: institutionSlice.reducer,
});

export const store = configureStore({ reducer: rootReducer });
