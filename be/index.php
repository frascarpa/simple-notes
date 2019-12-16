<?php

    require __DIR__ . '/../vendor/autoload.php';

    require_once 'Request.php';
    require_once 'Database.php';
    require_once 'Response.php';
    require_once 'Auth.php';
    require_once './api/controllers/user.php';
    require_once './api/controllers/course.php';
    require_once './api/controllers/lesson.php';
    require_once './api/controllers/note.php';
    require_once './api/controllers/search.php';
    require_once './api/controllers/history.php';

    header("Access-Control-Allow-Origin: *");

    
    $request = new Request($_SERVER);
    $_SESSION['database'] = new Database();
    
    if ($request->isMethod('get')) {
        if ($request->isAction('/api/test')) {
            $data = "Backend up and running!";
            Response::send(200, array("status" => $data));
        }
    }

    if ($request->isAction('/api/user/')) {
        UserController::handleRequest($request);
    }

    if ($request->isAction('/api/courses/')) {
        CourseController::handleRequest($request);
    }

    if ($request->isAction('/api/lessons/')) {
        LessonController::handleRequest($request);
    }

    if ($request->isAction('/api/notes/')) {
        NoteController::handleRequest($request);
    }

    if ($request->isAction('/api/search/')) {
        SearchController::handleRequest($request);
    }

    if ($request->isAction('/api/history/')) {
        HistoryController::handleRequest($request);
    }

    Response::send(501,'unknown action: ' . $request->getMethod());
?>