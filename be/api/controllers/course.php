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
            if ($request->isAction('delete')) {
                CourseController::delete($request);
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

    private static function delete($request) {
        $user =  Auth::authMiddleware($request);
        $data = $request->getData();

        $id = $data->id;

        if (empty($id)) {
            Response::send(422, array("error" => "missing fields"));
        } else {
            $_SESSION['database']->deleteCourse($id);
            Response::send(200, array("status" => "course deleted"));
        }
    }
}