<?php
class debug{
    static function d($var, $exit = false){
        echo "<pre>";
        print_r($var);
        echo "</pre>";
        if ($exit){
            exit();
        }
    }

    static function all(){
        echo "<pre>";
        debug_print_backtrace();
        echo "</pre>";
    }
}