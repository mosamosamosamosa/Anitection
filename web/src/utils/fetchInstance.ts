import axios from 'axios';

export const fetchInstance = () => {
  return axios.create({
    baseURL: `${process.env.REACT_APP_API_URL}/api` || 'http://localhost:8080/api',
    headers: {
      'Content-Type': 'application/json',
    },
  });
};

export const fetchInstanceWithToken = (token: string) => {
  return axios.create({
    baseURL: `${process.env.REACT_APP_API_URL}/api` || 'http://localhost:8080/api',
    headers: {
      'Content-Type': 'application/json',
      Authorization: `Bearer ${token}`,
    },
  });
};
