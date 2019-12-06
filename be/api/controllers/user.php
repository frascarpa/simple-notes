<?php

class UserController{

    public static function handleRequest($request){

        if($request->isMethod('post')){
            if ($request->isAction('register')) {
                UserController::register($request);
            }
            if ($request->isAction('login')) {
                UserController::login($request);
            }
        }
        
        Response::send(404, array("error" => "method not found"));

    }

    private static function login($request){
        $data = $request->getData();
        $email = $data->email;
        $password = $data->password;
        if (empty($nickname) | empty($email)) {
            Response::send(422, array("error" => "missing fields"));
        } else {
            $user = $_SESSION['database']->getUser($email);
            if ($user & password_verify($password, $user->$password)) {
                $jwt = Auth::createJwt(array("email" => $email, 'password' => $password));
                Response::send(200, array(
                    "jwt" => $jwt,
                    "nickname" => $user->nickname,
                    "email" => $user->email
                ));

            }

            Response::send(401, array("error" => "unauthorized"));

        }
    }


    private static function register($request){
        $data = $request->getData();
        
        $nickname = $data->nickname;
        $email = $data->email;
        $password = $data->password;
        // Response::send(200, array("error" => $nickname));
        if (empty($nickname) | empty($email) | empty($password)) {
            Response::send(422, array("error" => "missing fields".$nickname));
        } else {
            $mailExists = $_SESSION['database']->mailExists($data->email);
            if(!$mailExists){
                $registered = $_SESSION['database']->register($nickname, $email, $password);
                if ($registered){
                    Response::send(200, array("status" => "user created"));
                } else {
                    Response::send(500, array("error" => "cannot register user"));
                }
            } else {
                Response::send(403, array("error" => "user already exists"));
            }
        }
    }
}
