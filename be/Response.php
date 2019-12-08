<?php
    class Response {
        public static function send(int $code, array $data) {
            // foreach ($headers as $key => $value) {
            //     header("$key: $value");
            // }
            header("Access-Control-Allow-Origin: *");
            header("Content-Type: application/json; charset=UTF-8");
            header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
            header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");
            http_response_code($code);
            echo json_encode(array("data" => $data));
            exit();
        }
    }
?>