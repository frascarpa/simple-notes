<?php

class SearchController{

    public static function handleRequest($request){
        if($request->isMethod('get')){
            SearchController::searchAll($request);
        }
    }

    private static function searchAll($request) {
        $user =  Auth::authMiddleware($request);
        $data = $request->getData();

        $query = $data->query;
        $words = preg_split('/\s+/', $query, -1, PREG_SPLIT_NO_EMPTY);
        if (!count($words)) {
            Response::send(422, array("error" => "missing fields"));
        } else {
            $courses = $_SESSION['database']->searchCourses($words);
            $lessons = $_SESSION['database']->searchLessons($words);
            $notes = $_SESSION['database']->searchNotes($words);
            Response::send(200, array(
                "courses" => $courses,
                "lessons" => $lessons,
                "notes" => $notes,
            ));
        }
    }

}