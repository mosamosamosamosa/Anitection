import { combineReducers } from 'redux';
import { configureStore } from '@reduxjs/toolkit';

import { viewSlice, ViewState } from './features/view';

export type RootState = {
  view: ViewState;
};

const rootReducer = combineReducers<RootState>({
  view: viewSlice.reducer,
});

export const store = configureStore({ reducer: rootReducer });
