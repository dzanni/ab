<?php
class recapcha_check{
    static function check(){
        if (!isset($_POST['g-recaptcha-response'])){
            return false;
        }else{
            $recaptcha = new \ReCaptcha\ReCaptcha(PARAMS::get("RE_CAPCHA_BACKEND"));
            $resp = $recaptcha->verify($_POST['g-recaptcha-response'], $_SERVER['REMOTE_ADDR']);
            if ($resp->isSuccess()){
                return true;
            }else{
                // $errors = $resp->getErrorCodes();
                return true;
            }
        }
    }
}