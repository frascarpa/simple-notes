<?php
use \Firebase\JWT\JWT;


class Auth {

    private static function getKey(){
        return "super-secret-key";
    }

    private static function checkJwtValid($jwt) {
        if($jwt){
            try {
                $key = Auth::getKey();
                $decoded = JWT::decode($jwt, $key, array('HS256'));
            } catch (Exception $e){
                Response::send(401, array("error" => $e));
            }
        } else {
            Response::send(401, array("error" => "missing  jwt"));

        }
    }

    public static function createJwt($payload) {
        return JWT::encode($payload, Auth::getKey());
    }

    public static function authMiddleware($req) {
        $jwt = $req->getHeaders()['Authorization'];
        Auth::checkJwtValid($jwt);
    }





}
