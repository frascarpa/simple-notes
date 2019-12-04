<?php

class UserController{

    public static function handleRequest($request){

        if($request->isMethod('post')){
            if ($request->isAction('register')) {
                UserController::register($request);
            }
        }

        Response::send(401, array("status" => "handling user request"));

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
