<?php
    class Request {
        private $method;
        private $uri;
        private $data;
        private $headers;

        public function __construct(array $server) {

            // handling cors preflight
            if ($_SERVER['REQUEST_METHOD'] == 'OPTIONS') {
                exit;
            }
            $this->headers = apache_request_headers();
            // var_dump($this->headers);
            $this->method = $server['REQUEST_METHOD'];
            $this->uri = $server['REQUEST_URI'];
            $this->data = json_decode(file_get_contents('php://input'));
        }

        public function getMethod() {
            return $this->method;
        }

        public function getUri() {
            return $this->uri;
        }

        public function getData() {
            return $this->data;
        }

        public function getHeaders() {
            return $this->headers;
        }

        public function isMethod(string $method) {
            return strcasecmp($this->method, $method) === 0;
        }

        public function isAction(string $action) {
            // $regex = '/' . str_replace('\:id', '\d+', preg_quote($action, '/')) . '$/i';

            return strpos($this->uri, $action);
        }

        public function getId() {
            preg_match('/\d+$/', $this->uri, $id);

            return $id[0];
        }
    }
?>