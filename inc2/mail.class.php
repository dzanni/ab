<?php
require_once(dirname(__FILE__)."/../inc/class.phpmailer.php");
class mail{
    protected $to;
    protected $from;
    protected $admin_copy = false;
    protected $theme;
    protected $txt;
    protected $template;
    protected $attachments = array();

    function __construct(){
        $this->template = dirname(__FILE__).'/../templates/mail/mainMail.tpl';
        $this->attachments['logo.png'] = dirname(__FILE__) . "/../i/abos.png";
    }

    public function send(){
        if (!$this->txt){
            return "ERR: No data for send";
        }
        $mainParams = PARAMS::getAll();
        $smarty = SMARTY_GLOBAL::get();
        $smarty->assign("mainParams", $mainParams);
        $mail = new PHPMailer();
        $host = $_SERVER['HTTP_HOST'];
        $host = str_replace("www.", "", $host);
        if ($this->from){
            $mail->From = $this->from; // от кого
        }else{
            $mail->From = "info@" . $host; // от кого
        }
        $mail->FromName = $mainParams['COMPANY_EXP']; // от кого

        if ($this->to){
            $e_mail = explode(",", $this->to);
            for($i = 0;$i < count($e_mail);$i++) {
                $e_mail[$i] = trim($e_mail[$i]);
                if ($e_mail[$i] <> "") {
                    $mail->AddAddress($e_mail[$i], ''); // кому - адрес, Имя
                }
            }
        }elseif($this->admin_copy == false){
            return "ERR: не указан адресат, для отправки письма";
        }
        if($this->admin_copy) {
            $e_mail = explode(",", $mainParams['ADMIN_MAIL']);
            for($i = 0;$i < count($e_mail);$i++) {
                $e_mail[$i] = trim($e_mail[$i]);
                if ($e_mail[$i] <> "") {
                    $mail->AddBCC($e_mail[$i], ''); // кому - адрес, Имя
                }
            }
        }

        if (count($this->attachments)){
            foreach ($this->attachments as $key => $v) {
                $mail->AddEmbeddedImage($v, $key, $key);
            }
        }

        $mail->CharSet = "UTF-8";
        $mail->IsHTML(true); // выставляем формат письма HTML
        $mail->Subject = $this->theme; // тема письма
        $smarty->assign("HTML_MAIL_SEND",$this->txt);
        $mail->Body = $smarty->fetch(dirname(__FILE__).'/../templates/mail/mainMail.tpl');
        // отправляем наше письмо
        if ($mail->Send()){
            //debug::d($mail);
            return 1;
        }else{
            return 0;
        }
    }
    public function setTo($to){
        $this->to = trim($to);
        return $this;
    }
    public function setFrom($from){
        $this->from = trim($from);
        return $this;
    }
    public function setAdmin_copy($admin_copy){
        $this->admin_copy = $admin_copy;
        return $this;
    }
    public function setTheme($theme){
        $this->theme = trim($theme);
        return $this;
    }
    public function setTxt($txt){
        $this->txt = $txt;
        return $this;
    }
    public function setTemplate($template){
        $this->to = $template;
        return $this;
    }
}