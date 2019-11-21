<?php
// used to get mysql database connection
class Database{
 
    // specify your own database credentials
    private $host = "127.0.0.1";
    private $port = "5432";
    private $db_name = "simple-notes";
    private $username = "postgres";
    private $password = "postgres";
    public $conn;
 
    // get the database connection
    public function getConnection(){
 
        $this->conn = null;
 
        try{
            $this->conn = new PDO("pgsql:host=" . $this->host . ";port=" . $this->port . ";dbname=" . $this->db_name, $this->username, $this->password);
        }catch(PDOException $exception){
            echo "Connection error: " . $exception->getMessage();
        }
 
        return $this->conn;
    }
}
?>