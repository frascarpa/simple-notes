import axios from 'axios';
import router from './router'


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

  instance.interceptors.response.use(response => {
    return response;
 }, error => {
   if (error.response.status === 401) {
        router.push('login');
   }
   return error;
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

function getCourses(){
    return instance.get('courses/all');
}

function createCourse(name, description){
    return instance.post('courses/create', {
        name,
        description
    });
}

function getLessons(){
    return instance.get('lessons/all');
}

function createLesson(name, description, courseId){
    return instance.post('lessons/create', {
        name,
        description,
        courseId,
    });
}




export {
    login,
    getMe,
    register,
    getCourses,
    createCourse,
    getLessons,
    createLesson,
}