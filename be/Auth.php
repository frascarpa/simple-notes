<?php
use \Firebase\JWT\JWT;

$key= "super-secret-key";


class Auth {

    private static function checkJwtValid($jwt) {
        if($jwt){
            try {
                $decoded = JWT::decode($jwt, $key, array('HS256'));
            } catch (Exception $e){
                Response::send(401, array("error" => "unauthorized"));
            }
        }
    }

    public static function createJwt($payload) {
        return JWT::encode($payload, $key);
    }

    public static function authMiddleware($req) {
        $jwt = $req->getHeaders()['Authorization'];
        Auth::checkJwtValid($jwt);
    }





}
