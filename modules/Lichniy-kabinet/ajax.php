<?php
require("../../start.php");


if (isset($_POST['login']) && isset($_POST['forget_pwd'])){
    echo json_encode(LK::pwd_resign($_POST['login'], $_POST['device']), JSON_UNESCAPED_UNICODE);
    exit();
}
if (isset($_POST['send_register_request'])){
    echo json_encode(LK::registrate(), JSON_UNESCAPED_UNICODE);
    exit();
}

if (isset($_GET['load_price_set_settings']) && isset($_GET['stock'])){
    $LK_load_price = new LK_load_price($_GET['stock']);
    echo $LK_load_price->set_settings();
    exit();
}
if (isset($_POST['check_price']) && isset($_POST['forder'])){
    $smarty = SMARTY_GLOBAL::getInstance();
    $smarty->assign("err", LK_load_price::get_fOrder_errors($_POST['forder']));
    $smarty->display(dirname(__FILE__)."/templates/check_price.tpl");
    exit();
}
if (isset($_POST['lk_brand_select'])){
   $tovar_id = $_POST["tovar_id"];
   $firm_id = $_POST["brand"];
   $tovar = new dbl_tovar();
   $tovar->setFilter(array("id" => $tovar_id))->chg(array("firm" => $firm_id));
   echo 1;
}
if (isset($_POST['reset_pwd'])){
      echo json_encode(LK::pwd_chg($_POST['old_pwd'], $_POST['new_pwd']), JSON_UNESCAPED_UNICODE);
      exit();
}

if (isset($_POST['chg_user_field'])) {
    $value = $_POST['value'];
    $field = $_POST['field'];
    $user = CURRENT_USER::getInstance();
    if (!$user->id) {
        return false;
    }
    $users = new dbl_users();
    if ($users->setFilter(array("id"=>$user->id))->col()) {
        $users->chg(array($field => $value));
    }
}

if (isset($_POST['input_option'])) {
    $tovar = $_POST['tovar'];
    $option = $_POST['option'];
    $text = $_POST['text'];
    $data = new dbl_data();
    $data->setSelectFields("id")->setFilter(array("tovar" => $tovar, "options" => $option));
    if ($data->col()) {
        $data->get();
        $id = $data->result[0]['id'];
        $data->setFilter(array("id"=>$id))->chg(array("text" => $text));
    }else{
        $data->insert_local_table(array("text" => $text, "tovar" => $tovar, "options" => $option));
    }
}

if (isset($_POST['editOptions'])) {
    $options_id = $_POST['options_id'];
    $tovar_id = $_POST['tovar_id'];

    $options_val = new dbl_options_values();
    $options_val->setFilter(array("parent" => $options_id))->get();
    $options_values = $options_val->result;
    if (count($options_values) > 0){
        $data = new dbl_data;
        $data->setSelectFields("options")->setFilter(array("tovar" => $tovar_id))->get();

        //debug::d($data->result, 1);

        $arr2 = array();
        foreach ($data->result as $val) {
            $arr2[] = $val['options'];
        }
        foreach ($options_values as &$value) {
            if (in_array($value['id'], $arr2)) {
                $value['flag'] = 1;
                //$options_val = new dbl_options_values();
                $options_val->setFilter(array("parent" => $value['id']))->get();
                if  ($options_val->col()){
                    $needRecursion = true;
                }else{
                    $needRecursion = false;
                }
            }else{
                $value['flag'] = 0;
            }
        }

        //debug::d($needRecursion, 1);
        //debug::d($options_values, 1);

        $smarty = SMARTY_GLOBAL::get();
        $smarty->assign("needRecursion", $needRecursion);
        $smarty->assign("options_values", $options_values);
        $smarty->assign("tovar_id", $tovar_id);
        echo $smarty->fetch(dirname(__FILE__)."/../../templates/lk_edit_selector.tpl");
        exit();
    }else{
        exit();
    }
}

if (isset($_POST['saveOptions'])) {
    $tovar_id = $_POST['tovar_id'];
    $key = $_POST['key'];
    $options = $_POST['options'];
    //debug::d($options, 1);

    saveOptions ($tovar_id, $key, $options);
}

if (isset($_POST['checkAuthData'])) {
  $user = CURRENT_USER::getInstance();
  $tel = $_POST['tel'];
  $users = new dbl_users();
  $users->setFilter(array("tel"=>$tel));
  if ($users->col()) {
     echo "Пользователь с таким телефоном уже зарегистрирован";
  }else{
      echo "";
  }
}


if (isset($_POST['au'])){
    $ch = explode(".", $_POST['au']);
    $id = $ch[0];
    $ch = $ch[1];
    $check = md5($id);
    $check = $check[0].$check[1];
    if ($check == $ch){
        $user = new dbl_users();
        $filter = array(
            "id" => $id,
            "autoloaded" => 1,
            "pwd" => "",
        );
        if ($user->setFilter($filter)->col()) {
            $user->get();
            $pwd_hash = password_hash($_POST['pwd'], PASSWORD_BCRYPT);
            $token = md5($pwd_hash . $user->result[0]['login']) . "." . $id;
            $user->chg(array(
                "forget_pwd_token" => "",
                "forget_pwd_action" => "",
                "token" => $token,
                "pwd" => $pwd_hash,
                "mail_verification" => 1,
                "status" => 1,
            ));
            setcookie('token', $token, time()+150*864000,"/");  /* срок действия 150 дней */
            echo "/account/users/?lk_users_edit_profile=".$id;
            exit();
        }
    }
    echo "/account/?au=".$_POST['au'];
    exit();
}

// Старый пользователь
if (isset($_POST['checkNewTel'])) {
        $tel = $_POST['tel'];
        $user = CURRENT_USER::getInstance();

    if ($user->tel != $tel) {
        $users = new dbl_users();
        $users->setFilter(array("tel" => $tel));
        if ($users->col()) {
            echo "Пользователь с таким телефоном уже зарегистрирован";
        }else{
            echo "<a class='account__button js_lk_chg_tel' data-tel='".$tel."'>Сменить телефон?</a>";
        }
    }else{
        echo "Это Ваш действующий номер";
    }
}

// Старый пользователь
if (isset($_POST['changeTel'])) {
    $tel = $_POST['tel'];
    $tel_code = random_int(1000, 9999);
    $user = CURRENT_USER::getInstance();
    $users = new dbl_users();
    $users->setFilter(array("id" => $user->id))->chg(array("tel_code" => $tel_code, "tel_verification" => 0));
    $text = "Код подтверждения $tel_code";
    $intro = "Подтвердите телефон: ";

    if (SMS::send($tel, $text)) {
        echo "<p>$intro<input type='text' class='slyle_input js_verificate_new_tel_anchor' placeholder='Введите код из sms'><a class='account__button js_verificate_new_tel' data-tel='".$tel."'>Подтвердить</a></p>";
    } else {
        echo "Ошибка отправки SMS";
    }
}

// Старый пользователь
if (isset($_POST['proveTel'])) {
   $tel_code = preg_replace("/[^0-9]/", "", $_POST['tel_code']);
   $tel = $_POST['tel'];
    $user = CURRENT_USER::getInstance();
    $users = new dbl_users();
    $users->setSelectFields("tel_code")->setFilter(array("id" => $user->id));
    if ($users->col()){
        $users->get();
        if ($users->result[0]['tel_code'] == $tel_code){
           $users->setFilter(array("id" => $user->id))->chg(array("tel" => $tel, "tel_verification" => 1));
            echo "Телефон подтвержден";
        }else{
           echo "<p>Попробуйте еще раз: <input type='text' class='slyle_input js_verificate_new_tel_anchor' placeholder='Введите код из sms'><a class='account__button js_verificate_new_tel' data-tel='".$tel."'>Подтвердить</a>"."<a class='account__button js_lk_chg_tel' data-tel='".$tel."'>Или отправить SMS еще раз</a></p>";
        }
    }else{
        echo "Пользователь не обнаружен - POST['proveTel']";
    }
}

// Новый пользователь
if (isset($_POST['telInput'])) {
    $id = $_POST['id'];
    $device = $_POST['device'];
    $tel_code = preg_replace("/[^0-9]/", "", $_POST['tel_code']);
    $users = new dbl_users();
    $users->setSelectFields("login, tel, tel_code")->setFilter(array("id" => $id));
    if ($users->col()){
        $users->get();

        if ($users->result[0]['tel_code'] == $tel_code){
            $status = (PARAMS::get("ACTIVATION_STATUS") == 1 || PARAMS::get("REGISTRATION_STATUS") == 1) ? 1 : 0;

            if ($device == "mail"){
                $filter = array("status" => $status, "mail_verification" => 1);
            } else {
                $filter = array("status" => $status, "tel_verification" => 1);
            }

            $users->setFilter(array("id" => $id))->chg($filter);

            //$answer = ($status == 1) ? "Телефон подтвержден. Пользователь активирован." : "Телефон подтвержден администратором.";
            //$answer = "Телефон подтвержден. Пользователь № $id активирован. <br>Можете <a href='/account/' style='text-decoration: underline'>войти</a>, используя номер телефона и пароль.";
            //echo $answer;

            $res = array(
                'status' => '1',
                'url' => "/account/users/?lk_users_edit_profile=$id"
            );
                echo json_encode($res);
        }else{
            echo "<p>Попробуйте еще раз: <input type='text' class='slyle_input  js_lk_tel_input_anchor' placeholder='Введите код из sms'><a class='account__button js_lk_tel_input' data-id=$id data-device=$device>Подтвердить</a></p>";
        }
    }else{
        echo "Пользователь не обнаружен - POST['telInput']";
    }
}

if (isset($_POST['chgTags'])) {
    $tag = $_POST['tag'];
    //$user = $_POST['user'];
    $id = $_POST['id']; // new
    $subj_type = $_POST['subj_type'];// new

    $root = $_POST['root'];
    if ($root !=1 && $root !=-1){
        $root = 0;
    }
    $flag = $_POST['flag'];
    $is_multi = $_POST['is_multi'];

    // Тут абстрактность условная, так как пришлось через if решать
   if ($subj_type == "user"){
        $subj_tags = new dbl_user_tags();
    }elseif ($subj_type == "firm"){
        $subj_tags = new dbl_firm_tags();
    }

    $params = array($subj_type."_id" => $id, "tag_id" => $tag, "root_id" => $root);
    $subj_tags->setFilter($params);
    if ($flag == 1) {
        if($is_multi == 0) {
            if ($subj_type == "user"){
                $tags = new dbl_user_tags();
            }elseif ($subj_type == "firm"){
                $tags = new dbl_firm_tags();
            }
           $search = array($subj_type."_id" => $id);
            if ($root == 1){
                $search["IN=root_id"] = "1,-1";
            }else{
               $search["root_id"] = $root;
            }
            $tags->setFilter($search)->delete();
        }

        if (!$subj_tags->col()) {
            // Если $tag == 0 (Радиокнопка "Ничего не выбрано"), в таблицу не записываем
            if ($tag !=0){
                $subj_tags->insert_local_table($params);
            }

        }
    } else {
        $subj_tags->delete();
    }

    if ($root == 1 && $tag !=0) {
        echo addSecondTagBox($tag, $id, $is_multi, $subj_type);
    }else{
        echo "";
    }
}

if (isset($_POST['addDefaultSecondTags'])) {
    $tag = $_POST['tag'];
    //$user = $_POST['user'];
    $id = $_POST['id']; // new
    $subj_type = $_POST['subj_type'];// new
    $is_multi = $_POST['is_multi'];
    echo addSecondTagBox($tag, $id, $is_multi, $subj_type);
}

if (isset($_POST['askModeration'])) {
    $id = $_POST['user'];
    $subj_type = "user";
    $users = new dbl_users();
    $users->setFilter(array("id"=>$id));
    if (!$users->col()){
        return false;
    }
    //$users->chg(array("status"=>2));
    $users->chg(array("moderate"=>1));
    sendModerationAlert($id, $subj_type);
    echo "Запрос на модерацию отправлен";
}

if (isset($_POST['askModerationFirm'])) {
    $id = $_POST['firm'];
    $subj_type = "firm";
    $firm = new dbl_firm();
    $firm->setFilter(array("id"=>$id));
        if (!$firm->col()){
        return false;
    }
    //$firm->chg(array("status"=>2));
    $firm->chg(array("moderate"=>1));
    sendModerationAlert($id, $subj_type);
    echo "Запрос на модерацию отправлен";
}

if (isset($_POST['askModerationQuest'])) {
    $id = $_POST['quest'];
    $quest = new dbl_quest();
    $quest->setFilter(array("id"=>$id));
    if (!$quest->col()){
        return false;
    }
    $quest->chg(array("status"=>2));
    echo "Запрос на модерацию отправлен";
}

if (isset($_POST['deleteTag'])) {
    $id = $_POST['id'];
    $user = $_POST['user'];
    $user_tags = new dbl_user_tags();
    $user_tags->setFilter(array("user_id"=>$user, "tag_id"=>$id, "root_id"=>0));
    $user_tags->delete();

    if (in_array($id, dbl_tags::getStatesTags())){
        changeRegTpl($user, "user");
    }
}

if (isset($_POST['addTag'])) {

    $id = $_POST['id'];
    $user = $_POST['user'];
    $user_tags = new dbl_user_tags();
    $user_tags->setFilter(array("user_id"=>$user,"tag_id"=>$id, "root_id"=>0));
    if (!$user_tags->col()){
        $user_tags->insert_local_table(array("user_id"=>$user, "tag_id"=>$id, "root_id"=>0));
    }

    if (in_array($id, dbl_tags::getStatesTags())){
        changeRegTpl($user, "user");
    }
}

if (isset($_POST['deleteTagFirm'])) {
    $id = $_POST['id'];
    $firm = $_POST['firm'];
    $firm_tags = new dbl_firm_tags();
    $firm_tags->setFilter(array("firm_id"=>$firm, "tag_id"=>$id, "root_id"=>0));
    $firm_tags->delete();

    if (in_array($id, dbl_tags::getStatesTags())){
        changeRegTpl($firm, "firm");
    }

}

if (isset($_POST['addTagFirm'])) {
    $id = $_POST['id'];
    $firm = $_POST['firm'];
    $firm_tags = new dbl_firm_tags();
    $firm_tags->setFilter(array("firm_id"=>$firm,"tag_id"=>$id, "root_id"=>0));
    if (!$firm_tags->col()){
        $firm_tags->insert_local_table(array("firm_id"=>$firm, "tag_id"=>$id, "root_id"=>0));
    }

    if (in_array($id, dbl_tags::getStatesTags())){
        changeRegTpl($firm, "firm");
    }

}

if (isset($_POST['acceptFirm'])) {
    $user = $_POST['user'];
    $firm = $_POST['firm'];
    $flag = $_POST['flag'];
    $user_firm = new dbl_user_firm();
    $user_firm->setFilter(array("firm_id"=>$firm,"user_id"=>$user));
    if($user_firm->col()){
        $user_firm->get();
        if ($flag == "add"){
            $user_firm->chg(array("agree"=>1));
            echo " - запрос принят";
        }else{
            $user_firm->chg(array("agree"=>0));
            echo " - запрос не принят";
        }
    }
}

if (isset($_POST['acceptClientStatus'])) {
    $id = $_POST['id'];
    $flag = $_POST['flag'];
    $clients = new dbl_clients();
    $clients->setFilter(array("id"=>$id));
    if($clients->col()){
        $clients->get();
        if ($flag == "add"){
            $clients->chg(array("agree"=>1));
            echo " - запрос принят";
        }else{
            $clients->chg(array("agree"=>0));
            echo " - запрос не принят";
        }
    }
}

if (isset($_POST['deleteTagQuest'])) {
    $id = $_POST['id'];
    $quest = $_POST['quest'];
    $quest_tags = new dbl_quest_tags();
    $quest_tags->setFilter(array("quest_id"=>$quest, "tag_id"=>$id, "root_id"=>0));
    $quest_tags->delete();

    if (in_array($id, dbl_tags::getStatesTags())){
        changeRegTpl($quest, "quest");
    }
}

if (isset($_POST['addTagQuest'])) {
    $id = $_POST['id'];
    $quest = $_POST['quest'];
    $quest_tags = new dbl_quest_tags();
    $quest_tags->setFilter(array("quest_id"=>$quest,"tag_id"=>$id, "root_id"=>0));
    if (!$quest_tags->col()){
        $quest_tags->insert_local_table(array("quest_id"=>$quest, "tag_id"=>$id, "root_id"=>0));
    }

    if (in_array($id, dbl_tags::getStatesTags())){
        changeRegTpl($quest, "quest");
    }
}

if (isset($_POST['activateQuest'])) {
    $id = $_POST['id'];
    $quest = new dbl_quest();
    $quest->setSelectFields("title, status")->setFilter(array("id"=>$id));
    if ($quest->col()){
        $quest->get();

        if (!$quest->result[0]['status'] && !trim($quest->result[0]['title'])){
            echo false;
        }else{
            $new_status = ($quest->result[0]['status']) ? 0 : 1;
            $msg = ($new_status) ? "Скрыть" : "Активировать";
            $quest->chg(array("status"=>$new_status));
            if ($new_status){
                sendTlgNewQuest($id);
            }
           echo $msg;
        }
    }
}

if (isset($_POST['activateQuestAdmin'])) {
    $id = $_POST['id'];
    $quest = new dbl_quest();
    $quest->setSelectFields("title")->setFilter(array("id"=>$id));
    if ($quest->col()){
        $quest->get();
        if (trim($quest->result[0]['title'])){
          sendTlgNewQuest($id);
       }
    }
}

if (isset($_POST['likeRemark'])) {
    $obj = $_POST['obj'];
    $obj_id = $_POST['obj_id'];
    $liked = new dbl_liked();
    $liked->setFilter(array("obj"=>$obj, "obj_id"=>$obj_id, "user_id"=>CURRENT_USER::getInstance()->id));
    if ($liked->col()){
        $liked->delete();
    }else{
        $liked->insert_local_table(array("obj"=>$obj, "obj_id"=>$obj_id, "user_id"=>CURRENT_USER::getInstance()->id));
    }
    $liked->setFilter(array("obj"=>$obj, "obj_id"=>$obj_id));
    echo $liked->col();
}

if (isset($_POST['newTagFromUser'])) {
    $title = preg_replace("/[^\w ]/u", "", $_POST['title']);
    $parent_id = $_POST['parent_id'];
    $tag_from_user = new dbl_tag_from_user();
    $tag_from_user->insert_local_table(array("title"=>$title, "user_id"=>CURRENT_USER::getInstance()->id, "parent_id"=>$parent_id));

    $id = CURRENT_USER::getInstance()->id;

    $mail = new mail();
    $to = PARAMS::get('ADMIN_MAIL');
    $theme = 'Заявка на новый тег '.PARAMS::get('DOMAIN_EXP');
    $txt = "Заявка на новый тег. Пользователь id=$id предлагает новый тег $title. Все заявки тут ". PARAMS::get('DOMAIN_EXP')."/account/newtag/";

    if ($txt){
        $mail->setTo($to)->setTheme($theme)->setTxt($txt);
        if ($mail->send()){
            return true;
        }else{
            return false;
        }
    }
    return false;
}

// Завершение смены пароля по телефону на Автобосс
if (isset($_POST['resignPwdByTel'])){
    $id = $_POST['id'];
    $tel_code = preg_replace("/[^0-9]/", "", $_POST['tel_code']);
    $pwd_hash = password_hash($_POST['pwd'], PASSWORD_BCRYPT);

    $users = new dbl_users();
    $users->setFilter(array("id"=>$id, "tel_code"=>$tel_code));
    if ($users->col()){
        $users->get();
        $tel = $users->result[0]['tel'];
        $users->chg(array("pwd"=>$pwd_hash, "tel_verification"=>1));

        $current_user = new CURRENT_USER();
        $current_user->Auth($tel, $_POST['pwd'], false); // Почему-то не срабатывает автоматическая аутентификации
        echo "Пароль успешно изменен, можете войти с новым паролем";
    }
}


// Смена телефона, email или телеграм пользователя на Автобосс: шаг 1 - генерация и отправка кода
if (isset($_POST['chgCodeGenerate'])) {
    $id = $_POST['id'];
    $device = $_POST['device'];
    $val = $_POST['val'];
    $tel_code = random_int(1000, 9999);

    if ($device == "email"){
        $device = "login";
    }/*elseif($device == "text"){
        $device = "tlg";
    }*/

    if ($device == "tel"){
        $word = "телефон";
        $filter = array("tel"=>$val);
        $verific = "tel_verification";
    }elseif ($device == "login"){
        $word = "e-mail";
        $filter = array("login"=>$val);
        $verific = "mail_verification";
    }/*elseif ($device == "tlg"){
        $word = "телеграм";
        $filter = array("tlg"=>$val);
        $verific = "tlg_verification";
    }*/

    $users = new dbl_users();
    $users->setFilter($filter);
    if ($users->col()){
        $users->get();
        $check = false;
        if($val == $users->result[0][$device] && $users->result[0]['id'] == CURRENT_USER::getInstance()->id){
            if ($users->result[0][$verific] == 1){
                $res = array(
                    'status' => '0',
                    'msg' => "Это старый $word данного пользователя. Введите новый"
                );
                $check = true;
            }
            /* в противном случае телефон, почта или телеграм не подтверждены -- нужно подтверждение */
        }else{
            $res = array(
                'status' => '0',
                'msg' => "Этот $word уже занят"
            );
            $check = true;
        }
        if ($check) {
            echo json_encode($res);
            return false;
        }
    }

    $chg = array();
    $chg['tel_code'] = $tel_code;
    /*if ($device == "tlg"){
        $chg['tlg_tmp'] = $val;
    }*/

    $users->setFilter(array("id"=>$id))->chg($chg);
    $text = "Код подтверждения $tel_code";

    if($device == "tel"){
        if (SMS::send($val, $text)) {
            $res = array(
                'status' => '1',
                'msg' => "На указанный $word отправлен код подтверждения"
            );
        }else{
            $res = array(
                'status' => '0',
                'msg' => "Ошибка отправки sms"
            );
        }
    }elseif ($device == "login"){

        $mail = new mail();
        $mail->setTo($val)->setTheme("Смена e-mail на сайте " . PARAMS::get('COMPANY_EXP'))->setTxt($text);
        if ($mail->send()) {
            $res = array(
                'status' => '1',
                'msg' => "На указанный $word отправлен код подтверждения"
            );
        }else{
            $res = array(
                'status' => '0',
                'msg' => "Ошибка отправки письма"
            );
        }
    }
    /*elseif ($device == "tlg"){
            $res = array(
                'status' => '1',
                'msg' => 'Телеграм-бот выдаст вам код подтверждения'
            );

    }*/
    echo json_encode($res);
}

// Смена ТЕЛЕФОНА пользователя на Автобосс: шаг 2 - проверка кода и запись нового телефона
if (isset($_POST['chgUserTel'])) {
    $tel = $_POST["tel"];
    $tel_code = trim($_POST["tel_code"]);
    $id = $_POST["id"];
    $users = new dbl_users();
    $users->setFilter(array("id"=>$id));
    if ($users->col()) {
        $users->get();
        if ($tel_code == $users->result[0]['tel_code']){
            $chg = array("tel"=>$tel, "tel_verification"=>1);
            if ($users->result[0]['status'] > -2){
                $chg["status"] = 1;
            }
            $users->chg($chg);
            $res = array(
                'status' => '1',
                'msg' => "Телефон подтвержден и сохранен"
            );
        }else{
            $res = array(
                'status' => '0',
                'msg' => "Неправильный код"
            );
        }
    }else{
        $res = array(
            'status' => '0',
            'msg' => "Непредвиденная ошибка: пользователь id=$id не обнаружен"
        );
    }
    echo json_encode($res);
}

// Смена ЛОГИНА (e-mail) пользователя на Автобосс: шаг 2 - проверка кода и запись нового логина
// Смену токена закоммитили, чтобы не вылетало из сессии
if (isset($_POST['chgUserLogin'])) {
    $login = $_POST["login"];
    $tel_code = trim($_POST["tel_code"]);
    $id = $_POST["id"];
    $users = new dbl_users();
    $users->setFilter(array("id"=>$id));
    if ($users->col()) {
        $users->get();
        if ($tel_code == $users->result[0]['tel_code']){
            $chg = array("login"=>$login, "mail_verification" => 1);
            if ($users->result[0]['status'] > -2){
                $chg["status"] = 1;
            }
            $users->chg($chg);
            $res = array(
                'status' => '1',
                'msg' => "E-mail подтвержден и сохранен"
            );
        }else{
            $res = array(
                'status' => '0',
                'msg' => "Неправильный код"
            );
        }
    }else{
        $res = array(
            'status' => '0',
            'msg' => "Непредвиденная ошибка: пользователь id=$id не обнаружен"
        );
    }
    echo json_encode($res);
}

// Смена ТЕЛЕГРАМА пользователя на Автобосс: шаг 2 - проверка кода и запись нового телеграма
/*if (isset($_POST['chgUserTlg'])) {
    $tlg = $_POST["tlg"];
    $tel_code = trim($_POST["tel_code"]);
    $id = $_POST["id"];
    $users = new dbl_users();
    $users->setFilter(array("id"=>$id));
    if ($users->col()) {
        $users->get();
        if ($tel_code == $users->result[0]['tel_code']){
            $chg = array("tlg"=>$tlg, "tlg_verification"=>1);
            if ($users->result[0]['status'] > -2){
                $chg["status"] = 1;
            }
            $users->chg($chg);
            $res = array(
                'status' => '1',
                'msg' => "Телеграм подтвержден и сохранен"
            );
        }else{
            $res = array(
                'status' => '0',
                'msg' => "Неправильный код"
            );
        }
    }else{
        $res = array(
            'status' => '0',
            'msg' => "Непредвиденная ошибка: пользователь id=$id не обнаружен"
        );
    }
    echo json_encode($res);
}*/

if (isset($_POST['chooseState'])) {
    $id = $_POST["id"];
    $state_id = $_POST["state_id"];
    $user_tags = new dbl_user_tags();
    $user_tags->setFilter(array("user_id"=>$id, "root_id"=>1))->delete();
    $user_tags->insert_local_table(array("user_id"=>$id, "tag_id"=>$state_id, "root_id"=>1));

    $smarty = SMARTY_GLOBAL::get();
    $LK_users = new LK_users();
    $smarty->assign("cities", $LK_users->getCity($id));
    echo $smarty->fetch(dirname(__FILE__)."/templates/inner/lk_city_selector.tpl");
    exit();
}

if (isset($_POST['chooseCity'])) {
    $id = $_POST["id"];
    $city_id = $_POST["city_id"];
    $user_tags = new dbl_user_tags();
    $user_tags->setFilter(array("user_id"=>$id, "root_id"=>-1))->delete();
    $user_tags->insert_local_table(array("user_id"=>$id, "tag_id"=>$city_id, "root_id"=>-1));
    exit();
}
if (isset($_POST['chooseState_brand'])) {
    $id = $_POST["id"];
    $state_id = $_POST["state_id"];
    $firm_tags = new dbl_firm_tags();
    $firm_tags->setFilter(array("firm_id"=>$id, "root_id"=>1))->delete();
    $firm_tags->insert_local_table(array("firm_id"=>$id, "tag_id"=>$state_id, "root_id"=>1));

    $smarty = SMARTY_GLOBAL::get();
    $LK_firm = new LK_firm();
    $smarty->assign("cities", $LK_firm->getCity($id));
    echo $smarty->fetch(dirname(__FILE__)."/templates/inner/lk_city_selector.tpl");
    exit();
}

if (isset($_POST['chooseCity_brand'])) {
    $id = $_POST["id"];
    $city_id = $_POST["city_id"];
    $firm_tags = new dbl_firm_tags();
    $firm_tags->setFilter(array("firm_id"=>$id, "root_id"=>-1))->delete();
    $firm_tags->insert_local_table(array("firm_id"=>$id, "tag_id"=>$city_id, "root_id"=>-1));
    exit();
}

if (isset($_POST['chgDateTill'])) {
    $id = $_POST["id"];
    $till_now = $_POST["till_now"];
    $user_jobs = new dbl_user_jobs();
    $user_jobs->setFilter(array("id"=>$id));
    if ($user_jobs->col()){
        $user_jobs->chg(array("till_now"=>$till_now));
        $user_jobs->set_work($user_jobs->get_user_by_id($id));
    }
}

if (isset($_POST['chgJobField'])) {
    $id = $_POST["id"];
    $field = $_POST["field"];
    $val = trim(preg_replace("/[<>]/u", "", $_POST['val']));

    $user_jobs = new dbl_user_jobs();
    $user_jobs->setFilter(array("id"=>$id));
    if ($user_jobs->col()){
        $user_jobs->chg(array($field=>$val));

        $user_jobs->set_work($user_jobs->get_user_by_id($id));
    }
}

if (isset($_POST['addJob'])) {
    $user = $_POST["user"];
    $user_jobs = new dbl_user_jobs();
    $id = $user_jobs->insert_local_table(array("user_id"=>$user));

    $smarty = SMARTY_GLOBAL::get();
    $LK_users = new LK_users();
    $smarty->assign("all_years", $LK_users->getYearsPeriod());
    $smarty->assign("id", $id);
    echo $smarty->fetch(dirname(__FILE__)."/templates/inner/new_job_form.tpl");
}

if (isset($_POST['deleteJob'])) {
    $id = $_POST["id"];
    $user_jobs = new dbl_user_jobs();
    $user_id = $user_jobs->get_user_by_id($id);
    $id = $user_jobs->setFilter(array("id"=>$id))->delete();
    $user_jobs->set_work($user_id);
}

if (isset($_POST['chgFavicon'])) {
    $num = messages_chats_lk::get_unread_in_all_chats();
    $num = $num ?? false;
    echo $num;
}

if (isset($_POST['deleteMsgByUser'])) {
 $id = $_POST['msg'];
 $msg = new dbl_messages();
 if ($msg->setFilter(array("id"=>$id,"user_from"=>CURRENT_USER::getInstance()->id))->delete()){
     echo true;
 }else{
     echo false;
 }
}

if (isset($_POST['checkFirmLanding'])) {
    $firm_landing = new dbl_firm_landing();
    $filter = array("firm" => $_POST['firm'], "landing" => $_POST['landing']);
    $firm_landing->setFilter($filter);
    if ($_POST['flag'] == 0) {
        $firm_landing->delete();
    }else{
        if (!$firm_landing->col()){
            $firm_landing->insert_local_table($filter);
        }
    }
}

function addSecondTagBox ($tag, $id, $is_multi, $subj_type){

    $tags = new dbl_tags();
    $tags->setFilter(array("parent"=>$tag))->setOrderBy(array("position","title"))->setCol(1000);

    if (!$tags->col()){
        return "";
    }

    $tags->get();

    //debug::d($tags->result,1);

    $smarty = SMARTY_GLOBAL::getInstance();
    $smarty->assign("tags", $tags->result);
    $smarty->assign("root", $tag);
    $smarty->assign("id", $id);
    $smarty->assign("is_multi", $is_multi);
    $smarty->assign("subj_type", $subj_type);

    if ($subj_type == "user"){
        $obj = new LK_users();
        $obj->mk_get_user_tage($id);
    }elseif ($subj_type == "firm"){
        $obj = new LK_firm();
        $obj->mk_get_firm_tage($id);
    }

    $smarty->assign("obj", $obj);

   return $smarty->fetch(dirname(__FILE__)."/../../modules/Lichniy-kabinet/templates/inner/inner_tag.tpl");
}

function saveOptions ($tovar_id, $key, $options){

    $options_values = new dbl_options_values;
    $options_values->setSelectFields("id")->setFilter(array("id_options" => $key))->get();
    $arr_to_delete = array();
    foreach ($options_values->result as $val){
        $arr_to_delete[] = $val['id'];
    }

    $data = new dbl_data();
    $data->setSelectFields("options")->setFilter(array("tovar" => $tovar_id))->get();
    foreach ($data->result as $value) {
        if (in_array($value['options'], $arr_to_delete)) {
            $data->setFilter(array("tovar" => $tovar_id, "options" => $value['options']))->delete();
        }
    }
    foreach ($options as $value) {
        if ($value != -1){
            $data->insert_local_table(array("tovar" => $tovar_id, "options" => $value));
        }
    }
}

function sendModerationAlert($id, $subj_type){

    $mail = new mail();
    $to = PARAMS::get('ADMIN_MAIL');
    $theme = 'Заявка на модерацию '.PARAMS::get('DOMAIN_EXP');
    switch ($subj_type){
        case "user":
            $txt = "Запрос на модерацию. Пользователь id=$id. Прямая ссылка ". PARAMS::get('DOMAIN_EXP')."/account/users/?lk_users_edit_profile=$id.";
        break;
        case "firm":
            $txt = "Запрос на модерацию. Компания id=$id. Прямая ссылка ". PARAMS::get('DOMAIN_EXP')."/account/brands/?lk_brands_edit_profile=$id.";
        break;
        default:
            $txt = '';
    }
    if ($txt){
        $mail->setTo($to)->setTheme($theme)->setTxt($txt);
        if ($mail->send()){
            return true;
        }else{
            return false;
        }
    }
    return false;
}

function changeRegTpl($id, $class){
    //Хардкодим проверку на тег региона, так как не работает в аяксе check_tag_select()

    switch ($class){
        case "user":
            $db = new dbl_user_tags();
            $obj = new LK_users();
            $filter = array("user_id"=>$id, "root_id"=>0);
            break;
        case "firm":
            $db = new dbl_firm_tags();
            $obj = new LK_firm();
            $filter = array("firm_id"=>$id, "root_id"=>0);
            break;
        case "quest":
            $db = new dbl_quest_tags();
            $obj = new LK_quest();
            $filter = array("quest_id"=>$id, "root_id"=>0);
            break;
    }

    $db->setFilter($filter);
    if ($db->col()){
        $db->setSelectFields("tag_id")->get();
        $tmp = array();
        foreach ($db->result as $res){
            $tmp[] = $res['tag_id'];
        }
        $tmp = array_intersect($tmp, dbl_tags::getRegTagsSimpleArr());
    }

    $smarty = SMARTY_GLOBAL::getInstance();
    $smarty->assign("obj", $obj);
    $smarty->assign("id", $id);
    $smarty->assign("reg_arr", $tmp);
    $smarty->assign("class", $class);

    echo $smarty->fetch(dirname(__FILE__)."/../../modules/Lichniy-kabinet/templates/inner/reg_tag.tpl");
}

function sendTlgNewQuest ($id){
    require(dirname(__FILE__) . "/../../inc/tlgbot.class.php");
    $bot = new Tlgbot();

    $quest = new dbl_quest();
    $quest->setFilter(array("id"=>$id))->get();
    $res = $quest->result[0];

    $content = $res['title'];
    $content = str_replace(array('<br>', '</br>', "\n"), " ", $content);
    if (mb_strlen($content) > 50){
        $content = mb_substr($content, 0, 50) . "...";
    }else{
        $content .= "...";
    }

    if ($res['is_news']){
        $text = "Новость на сайте: ". $content . " " ."<a href='" . PARAMS::get("DOMAIN_EXP") . "/quests/?quest=" . $res['id'] . "'>Прочитать</a>";
    }else{
        $text = "Новый вопрос: ". $content . " " . "<a href='" . PARAMS::get("DOMAIN_EXP") . "/quests/?quest=" . $res['id'] . "'>Прочитать</a>";
    }

    $keyboard = $bot->setKeyboards()['menu'];
    $inlineKeyboardMarkup = array(
        'inline_keyboard' => $keyboard
    );
    $reply_markup = json_encode($inlineKeyboardMarkup);

    foreach ($bot->getAllTlgUsers() as $v){
        //if ($v['id'] == $res['user'] || $v['id'] == 16335 || $v['id'] == 2){
        if ($v['id'] != $res['user']){
            $bot->sendMessage($v['tlg_id'], $text, $reply_markup);
        }
    }

}