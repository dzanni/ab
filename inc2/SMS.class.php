<?php

class SMS
{

    static function send($phone, $text)
    {
        $login = PARAMS::get('SSMS_LOGIN');
        $pwd = PARAMS::get('SSMS_PWD');
        $sender = PARAMS::get('SSMS_SENDER_NAME');
        $text = urlencode($text);

        $phone = preg_replace('/[^0-9]/', "", $phone);
        if (substr($phone, 0, 1) == 8) {
            $phone = substr_replace($phone, "7", 0, 1);
        }
        if (substr($phone, 0, 1) != 7 || strlen($phone) != 11) {
            return false;
        }

       //$url = "http://api2.ssms.su/?method=push_msg&email=$login&password=$pwd&text=$text&phone=$phone&sender_name=$sender";

        $url = "https://gateway.api.sc/get/?user=$login&pwd=$pwd&sadr=$sender&dadr=$phone&text=$text";
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($ch, CURLOPT_URL, $url);
        $result = curl_exec($ch);
        return $result;
    }

/* https://gateway.api.sc/get/?user=login&pwd=password&name_deliver=Title&sadr=SMS%20Info&dadr=79999999999&text=Data&callback_url=https://mysite.com/script.php */

    /*
    http://api2.ssms.su/?method=push_msg&email=YOUR_LOGIN&password=YOUR_PASSWORD&text=SMS_TEXT&phone=SMS_PHONE_NUMBER_OF_THE_RECIPIENT&sender_name=MyBrandName
    */

}