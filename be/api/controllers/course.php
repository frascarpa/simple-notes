<?php

class CourseController{

    public static function handleRequest($request){
        if($request->isMethod('get')){
            if ($request->isAction('all')) {
                CourseController::getAll($request);
            }
        }
        if($request->isMethod('post')){
            if ($request->isAction('create')) {
                CourseController::create($request);
            }
        }
    }

    private static function getAll($request) {
        $user =  Auth::authMiddleware($request);
        $courses = $_SESSION['database']->getAllCourses();
        Response::send(200, $courses);
    }

    private static function create($request) {
        $user =  Auth::authMiddleware($request);
        $data = $request->getData();

        $name = $data->name;
        $description = $data->description;

        if (empty($name)) {
            Response::send(422, array("error" => "missing fields"));
        } else {
            $courseExists = $_SESSION['database']->courseExists($name);
            if (!$courseExists) {
                $created = $_SESSION['database']->createCourse($name, $description, $user);
                Response::send(200, array("status" => "course created"));
            } else {
                Response::send(422, array("error" => "course already exists"));
            }
        }
    }
}