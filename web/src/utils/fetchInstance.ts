import axios from 'axios';

export const fetchInstance = () => {
  return axios.create({
    baseURL: `${process.env.REACT_APP_API_URL}` || 'http://bff:8080',
    headers: {
      'Content-Type': 'application/json',
    },
  });
};
