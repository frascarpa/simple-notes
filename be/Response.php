<?php
    class Response {
        public static function send(int $code, array $headers, array $data) {
            foreach ($headers as $key => $value) {
                header("$key: $value");
            }
            http_response_code($code);
            echo json_encode(array("data" => $data));
            exit();
        }
    }
?>