import axios from 'axios';

export const fetchInstance = () => {
  return axios.create({
    // baseURL: `${process.env.REACT_APP_API_URL}`,
    baseURL: `https://anitection-strapi.yumekiti.net`,
    headers: {
      'Content-Type': 'application/json',
    },
  });
};

export const fetchInstanceWithToken = () => {
  return axios.create({
    baseURL: `${process.env.REACT_APP_API_URL}`,
    headers: {
      'Content-Type': 'application/json',
      Authorization: `Bearer ${localStorage.getItem('token')}`,
    },
  });
};
