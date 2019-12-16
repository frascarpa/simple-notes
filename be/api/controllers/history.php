<?php

class HistoryController{

    public static function handleRequest($request){
        if($request->isMethod('get')){
            HistoryController::getHistory($request);
        }
    }

    private static function getHistory($request) {
        $user =  Auth::authMiddleware($request);

        $hystory = $_SESSION['database']->getHistory();
        Response::send(200, $hystory);
    }

}