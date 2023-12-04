import axios from 'axios';

export const fetchInstance = () => {
  return axios.create({
    baseURL: 'http://localhost:8080/api',
    headers: {
      'Content-Type': 'application/json',
    },
  });
};

export const fetchInstanceWithToken = (token: string) => {
  return axios.create({
    baseURL: 'http://localhost:8080/api',
    headers: {
      'Content-Type': 'application/json',
      Authorization: `Bearer ${token}`,
    },
  });
};
