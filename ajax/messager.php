<?php
require (dirname(__FILE__)."/../start.php");

if (isset($_POST['query'])){
    //Вставка для форм, отправленных от имени фирм
    $query = str_replace("?", "", $_POST['query']); // Выдаст ГЕТ-запрос страницы, если форма ушла со страницы фирмы
    if ($query){
        parse_str($query, $queryArray);
        if (dbl_firm_pages::pageExist($queryArray['firm'], $queryArray['firmpage'])){
            $firm = new dbl_firm();
            $firm->setFilter(array("id" => $queryArray['firm']));
            if ($firm->col()){
                $firm->setSelectFields('id, title, email, email_form')->get();
                $res = $firm->result[0];

                if ($res['email_form']){
                    $to = $res['email_form'];
                }elseif (json_decode($res['email'], 1)){
                    $to = implode(",", json_decode($res['email']));
                }else{
                    $to = $res['email'];
                }
            }
        }
    }
}

if (isset($_POST['sendData'])){
    if (!recapcha_check::check()){
        //$this->auth_result = 'Код капчи не прошёл проверку на сервере';
        echo 0;
        exit();
    } else{

        $data = $_POST['sendData'];

        $mail = new mail();

//    if (isset($_POST['email'])){
//        $email = preg_replace("/[^a-zA-z0-9-@._,]/", "", $_POST['email']);
//    }
        $to = PARAMS::get('ADMIN_MAIL');
        $theme = 'Заявка на '.PARAMS::get('DOMAIN_EXP');

        $txt = '';
        foreach ($data as $v){
            $txt .=  $v["title"]. ': '.$v['value'].". <br>";
        }
        $txt = preg_replace('/<.*?>/', '', $txt);

        $mail->setTo($to)->setTheme($theme)->setTxt($txt);
        $mail->send();

        echo 1;
        exit();
    }
}

if (isset($_POST['currentUser'])){
    $user = CURRENT_USER::getInstance();

    $mail = new mail();

    $theme = 'Заявка на '.PARAMS::get('DOMAIN_EXP');

    $txt = '';
    if (!$to){
        $txt .= 'Заявка не доставлена, так как у фирмы ' . PARAMS::get('DOMAIN_EXP') . '/firms/?firm=' . $res['id'] . ' не заполнен e-mail.<br><br>';
        $theme .= " НЕ ДОСТАВЛЕНА";
        $to = PARAMS::get('ADMIN_MAIL');
    }

    if ($user->id == $user->login){ // Т.е. пользователь не ввел e-mail, и в логине стоит id
        $u_email = '';
    }else{
        $u_email = $user->login;
    }

    $txt .= 'Форма: ' . preg_replace('/<.*?>/', '', $_POST['title']) . '<br>' .
            'Имя: ' . $user->name . '<br>' .
            'Телефон: ' . $user->tel . '<br>' .
            'E-mail: ' . $u_email . '<br>' .
            'Профиль на сайте: ' . PARAMS::get('DOMAIN_EXP') . '/users/?user=' . $user->id;

    $mail->setTo($to)->setTheme($theme)->setTxt($txt);
    $mail->send();

    echo 1;
  exit();
}