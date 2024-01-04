import axios from 'axios';

export const fetchInstance = () => {
  return axios.create({
    baseURL: 'https://anitection-strapi.yumekiti.net/api',
    headers: {
      'Content-Type': 'application/json',
    },
  });
};

export const fetchInstanceWithToken = () => {
  return axios.create({
    baseURL: 'https://anitection-strapi.yumekiti.net/api',
    headers: {
      'Content-Type': 'application/json',
      Authorization: `Bearer ${localStorage.getItem('token')}`,
    },
  });
};
