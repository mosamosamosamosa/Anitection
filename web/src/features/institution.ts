import { createSlice } from '@reduxjs/toolkit';

export type Institution = {
  institution: any;
};

export type InstitutionState = Institution;

const initialState: InstitutionState = {
  institution: null,
};

export const institutionSlice = createSlice({
  name: 'institution',
  initialState,
  reducers: {
    setInstitution: (state, action) => {
      state.institution = action.payload;
    },
  },
});
