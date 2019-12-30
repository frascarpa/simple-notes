<?php

class NoteController{

    public static function handleRequest($request){
        if($request->isMethod('get')){
            if ($request->isAction('all')) {
                NoteController::getAll($request);
            }
            if ($request->isAction('bylesson')) {
                NoteController::getByLesson($request);
            }
            if ($request->isAction('details')) {
                NoteController::details($request);
            }
            if ($request->isAction('my')) {
                NoteController::myNotes($request);
            }

        }
        if($request->isMethod('post')){
            if ($request->isAction('create')) {
                NoteController::create($request);
            }
            if ($request->isAction('edit')) {
                NoteController::edit($request);
            }
            if ($request->isAction('delete')) {
                NoteController::delete($request);
            }
        }
    }

    private static function getAll($request) {
        $user =  Auth::authMiddleware($request);
        $notes = $_SESSION['database']->getAllNotes();
        Response::send(200, $notes);
    }

    private static function myNotes($request) {
        $user =  Auth::authMiddleware($request);
        $notes = $_SESSION['database']->getMyNotes($user->id);
        Response::send(200, $notes);
    }

    private static function getByLesson($request) {
        $user =  Auth::authMiddleware($request);
        $data = $request->getData();
        $lessonId = $data->lessonId;

        if (empty($lessonId)) {
            Response::send(422, array("error" => "missing fields"));
        } else {
            $notes = $_SESSION['database']->getNotesByLessons($lessonId);
            Response::send(200, $notes);
            }
    }

    private static function details($request) {
        $user =  Auth::authMiddleware($request);
        $data = $request->getData();
        
        $noteId = (int) $data->noteId;

        if (empty($noteId)) {
            Response::send(422, array("error" => "missing fields"));
        } else {
            $note = $_SESSION['database']->getNoteDetails($noteId);
            Response::send(200, $note);
            }
    }

    private static function create($request) {
        $user =  Auth::authMiddleware($request);
        $data = $request->getData();

        $title = $data->title;
        $description = $data->description;
        $lessonId = $data->lessonId;

        if (empty($title) | empty($lessonId) ) {
            Response::send(422, array("error" => "missing fields"));
        } else {
            $noteExists = $_SESSION['database']->noteExists($title, $lessonId);
            if (!$noteExists) {
                $created = $_SESSION['database']->createNote($title, $description, $lessonId, $user);
                Response::send(200, $created);
            } else {
                Response::send(422, array("error" => "note already exists"));
            }
        }
    }

    private static function edit($request) {
        $user =  Auth::authMiddleware($request);
        $data = $request->getData();

        $noteId = $data->noteId;
        $title = $data->title;
        $description = $data->description;
        $content = $data->content;

        if (empty($title) | empty($content) ) {
            Response::send(422, array("error" => "missing fields"));
        } else {
            $noteExists = $_SESSION['database']->getNoteDetails($noteId);
            if ($noteExists) {
                $contentClean = strip_tags($content);
                $edited = $_SESSION['database']->editNote($noteId, $title, $description, $content, $contentClean);
                Response::send(200, array("status" => "note saved"));
            } else {
                Response::send(422, array("error" => "note does not exists"));
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
            $_SESSION['database']->deleteNote($id);
            Response::send(200, array("status" => "note deleted"));
        }
    }
}