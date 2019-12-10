import axios from 'axios';

const restUrl = 'http://localhost:8088/~francesco/api/'

const instance = axios.create({
    baseURL: restUrl,
    headers: {
      "Access-Control-Allow-Origin": "*",
      'content-type': 'application/json', 
      "Access-Control-Allow-Methods": "GET, POST, PATCH, PUT, DELETE, OPTIONS",
      "Access-Control-Allow-Headers": "Origin, Content-Type, X-Auth-Token"
    }
  });

function login(email, password){
    return instance.post('user/login', {
        email,
        password,
    }).then((resp) => {
        instance.defaults.headers.common['Authorization'] = `${resp.data.data.jwt}`
        return resp;
    })
}

function register(email, nickname, password){
    return instance.post('user/register', {
        email,
        nickname,
        password,
    });
}

function getMe(){
    return instance.get('user/me');
}



export {
    login,
    getMe,
    register,
}