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
    private $course_table = "courses";
    private $lesson_table = "lessons";
    private $note_table = "notes";

    function __construct(){
        try{
            $this->pdo = new PDO("pgsql:host=" . $this->host . ";port=" . $this->port . ";dbname=" . $this->db_name, $this->username, $this->password);
        }catch(PDOException $exception){
            Response::send(500, array("db_error" => $exception->getMessage()));
        }
    }

    // USER queries
 
    public function mailExists($email) {
        $sql = "SELECT email
        FROM " . $this->user_table . "
        WHERE email = :email";
        $sth = $this->pdo->prepare($sql);
        $sth->execute(array(':email' => $email));
        $result = $sth->fetch(PDO::FETCH_ASSOC);

        return $result;
     
    }

    public function getUser($email) {
        $sql = "SELECT *
        FROM " . $this->user_table . "
        WHERE email = :email";
        $sth = $this->pdo->prepare($sql);
        $sth->execute(array(':email' => $email));
        $result = $sth->fetch(PDO::FETCH_ASSOC);

        return  (object) $result;
     
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

    // COURSE queries
     
    public function courseExists($name) {
        $sql = "SELECT *
        FROM " . $this->course_table . "
        WHERE name = :name";
        $sth = $this->pdo->prepare($sql);
        $sth->execute(array(':name' => $name));
        $result = $sth->fetch(PDO::FETCH_ASSOC);

        return $result;
     
    }

    public function getCourseById($id) {
        $sql = "SELECT *
        FROM " . $this->course_table . "
        WHERE id = :id";
        $sth = $this->pdo->prepare($sql);
        $sth->execute(array(':id' => $id));
        $result = $sth->fetch(PDO::FETCH_ASSOC);

        return $result;
     
    }

    public function getAllCourses() {
        $sql = "SELECT *
        FROM " . $this->course_table;
        return $this->pdo->query($sql)->fetchAll(PDO::FETCH_OBJ);
    }

    public function createCourse($name, $description = '', $user) {
        $sql = "INSERT INTO " . $this->course_table . "(name,description,user_id)
        VALUES( :name, :description, :user_id)";
        $sth = $this->pdo->prepare($sql);
        $result = $sth->execute(array(
            ':name' => $name,
            ':description' => $description,
            ':user_id' => (int) $user->id,
        ));
        if($result){
            return $this->courseExists($name);
        } else {
            return $result;
        }
     
    }

    // LESSONS queries
     
    public function lessonExists($name) {
        $sql = "SELECT *
        FROM " . $this->lesson_table . "
        WHERE name = :name";
        $sth = $this->pdo->prepare($sql);
        $sth->execute(array(':name' => $name));
        $result = $sth->fetch(PDO::FETCH_ASSOC);

        return $result;
     
    }

    public function getAllLessons() {
        $sql = "SELECT *
        FROM " . $this->lesson_table;
        return $this->pdo->query($sql)->fetchAll(PDO::FETCH_OBJ);
    }

    public function getLessonsByCourse() {
        $sql = "SELECT ".$this->lesson_table. "*, ".$this->course_table. "id as idc
        FROM " . $this->lesson_table .", ". $this->lesson_table .
        "WHERE idc = :courseId";
        $sth = $this->pdo->prepare($sql)->execute();
        return $sth->fetch(PDO::FETCH_ASSOC);
    }

    public function createLesson($name, $description, $courseId, $user) {
        $sql = "INSERT INTO " . $this->lesson_table . "(name,description,course_id,user_id)
        VALUES( :name, :description, :courseId, :userId)";
        $sth = $this->pdo->prepare($sql);
        if($sth->execute(array(
            ':name' => $name,
            ':description' => $description,
            ':courseId' => $courseId,
            ':userId' => $user->id,
        )))
            {
            return $this->lessonExists($name);
        }
        return false;
     
    }

    // NOTES queries

    public function getAllNotes() {
        $sql = "SELECT *
        FROM " . $this->note_table;
        return $this->pdo->query($sql)->fetchAll(PDO::FETCH_OBJ);
    }

    public function getMyNotes($userId) {
        $sql = "SELECT *
        FROM " . $this->note_table . "
        WHERE user_id = :userId ";
        $sth = $this->pdo->prepare($sql);
        $sth->execute(array(':userId' => $userId));
        $result = $sth->fetchAll(PDO::FETCH_OBJ);

        return $result;
        return $this->pdo->query($sql)->fetchAll(PDO::FETCH_OBJ);
    }

    public function noteExists($title, $lesson_id) {
        $sql = "SELECT *
        FROM " . $this->note_table . "
        WHERE title = :title AND lesson_id = :lesson_id";
        $sth = $this->pdo->prepare($sql);
        $sth->execute(array(':title' => $title, ':lesson_id' => $lesson_id));
        $result = $sth->fetch(PDO::FETCH_OBJ);

        return $result;
     

    }
    public function getNotesByLessons($noteId) {
        $sql = "SELECT *
        FROM " . $this->note_table . "
        WHERE lesson_id = :id";
        $sth = $this->pdo->prepare($sql);
        $sth->execute(array(':id' => $lessonId));
        $result = $sth->fetchAll(PDO::FETCH_OBJ);

        return $result;
    }
     
    public function getNoteDetails($noteId) {
        $sql = "SELECT *
        FROM " . $this->note_table . "
        WHERE id = :id";
        $sth = $this->pdo->prepare($sql);
        $sth->execute(array(':id' => $noteId));
        $result = $sth->fetch(PDO::FETCH_OBJ);

        return $result;
     
    }

    public function createNote($title, $description, $lessonId, $user) {
        $sql = "INSERT INTO " . $this->note_table . "(title,description,lesson_id,user_id)
        VALUES( :title, :description, :lessonId, :userId)";
        $sth = $this->pdo->prepare($sql);
        if($sth->execute(array(
            ':title' => $title,
            ':description' => $description,
            ':lessonId' => $lessonId,
            ':userId' => $user->id,
        )))
            {
            return $this->noteExists($title, $lessonId);
        }
        return false;
     
    }

    public function editNote($noteId, $title, $description = '', $content, $content_clean) {
        $sql = "UPDATE " . $this->note_table .
        " SET title = :title,
        description = :description,
        content = :content,
        content_clean = :content_clean
        WHERE id = :noteId;";
        var_dump($noteId, $title, $description, $content, $content_clean);
        $sth = $this->pdo->prepare($sql);
        $sth->errorInfo();
        $res = $sth->execute(array(
            ':title' => $title,
            ':description' => $description,
            ':content' => $content,
            ':content_clean' => $content_clean,
            ':noteId' => $noteId,
        ));
        if($res)
            {
            return $this->noteExists($title, $lessonId);
        }
        return false;
     
    }


}
?>