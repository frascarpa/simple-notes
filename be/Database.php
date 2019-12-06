<?php
// used to get mysql database connection
class Database{
 
    // specify your own database credentials
    private $host = "localhost";
    private $port = "5432";
    private $db_name = "simple-notes";
    private $username = "postgres";
    private $password = "postgres";
    private $pdo;

    private $user_table = "users";

    function __construct(){
        try{
            $this->pdo = new PDO("pgsql:host=" . $this->host . ";port=" . $this->port . ";dbname=" . $this->db_name, $this->username, $this->password);
        }catch(PDOException $exception){
            Response::send(500, array("db_error" => $exception->getMessage()));
        }
    }
 
    public function mailExists($email) {
        $sql = "SELECT email
        FROM " . $this->user_table . "
        WHERE email = :email";
        $sth = $this->pdo->prepare($sql);
        $sth->execute(array(':email' => $email));
        $result = $sth->fetch();

        return $result;
     
    }

    public function getUser($email) {
        $sql = "SELECT nickname, password
        FROM " . $this->user_table . "
        WHERE email = :email";
        $sth = $this->pdo->prepare($sql);
        $sth->execute(array(':email' => $email));
        $result = $sth->fetch();

        return $result;
     
    }
 
    public function register($nickname, $email, $password) {
        // hash the password before saving to database
        $password_hash = password_hash($password, PASSWORD_BCRYPT);

        $sql = "INSERT INTO " . $this->user_table . "(nickname,email,password)
        VALUES( :nickname, :email, :password)";
        // return $email;
        $sth = $this->pdo->prepare($sql);
        if($sth->execute(array(
            ':nickname' => $nickname,
            ':email' => $email,
            ':password' => $password_hash,
        ))){
            return true;
        }
        return false;
     
    }


}
?>