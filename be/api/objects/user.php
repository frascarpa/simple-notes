<?php
// 'user' object

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
 
    // database connection and table name
    private $conn;
    private $table_name = "users";
 
    // object properties
    public $id;
    public $nickname;
    public $email;
    public $password;
 
    function create(){
 
        // insert query
        $query = "INSERT INTO " . $this->table_name . "(nickname,email,password)
                VALUES( :nickname, :email, :password)";
     
        // prepare the query
        $stmt = $this->conn->prepare($query);
     
        // sanitize
        $this->nickname=htmlspecialchars(strip_tags($this->nickname));
        $this->email=htmlspecialchars(strip_tags($this->email));
        $this->password=htmlspecialchars(strip_tags($this->password));
     
        // bind the values
        $stmt->bindParam(':nickname', $this->nickname);
        $stmt->bindParam(':email', $this->email);
     
        // hash the password before saving to database
        $password_hash = password_hash($this->password, PASSWORD_BCRYPT);
        $stmt->bindParam(':password', $password_hash);
     
        // execute the query, also check if query was successful
        if($stmt->execute()){
            return true;
        }
     
        return false;
    }
     
    // emailExists() method will be here
}
