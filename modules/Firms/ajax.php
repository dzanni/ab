<?php
require("../../start.php");

if (isset($_POST['changeRemarkPage'])) {
    $page = $_POST['page'];
    $firm_id = $_POST['firm'];

    changeRemarkPage($firm_id, $page);
}

if (!CURRENT_USER::getInstance()->id){
    exit();
}
/* все что дальше только с авторизацией доступно */

if (isset($_POST['createNewFirm'])) {
    $flag = $_POST['flag'];
    $title = $_POST['title'];
    $user_id = CURRENT_USER::getInstance()->id;

    $firm = new dbl_firm();
    $id = $firm->insert_local_table(array("title"=>$title, "users"=>$user_id));

    if ($flag){
        $user_firm = new dbl_user_firm();
        $user_firm->insert_local_table(array("user_id"=>$user_id, "firm_id"=>$id, "agree"=>1));
    }

    echo $id;
}

if (isset($_POST['send_request_for_brand'])){
    if (CURRENT_USER::getInstance()->id){

        $user = CURRENT_USER::getInstance();
        $mail = new mail();
        $mail->setTo(PARAMS::get("ADMIN_MAIL"));
        $mail->setTheme("Запрос на доступ к компании");
        $mail->setTxt("Пользователь id=".CURRENT_USER::getInstance()->id." запрашивает доступ к управлению компанией id=".$_POST['id']." ");
        $mail->send();

        echo "<p>Ваш запрос на доступ отправлен. Просьба не дублировать запрос. Мы скоро Вам ответим.</p>";

    }else{
        echo '<p><a href="/account/?lk_reg">Зарегистрируйтесь в системе</a>, чтобы запросить доступ на управление компанией у службы поддержки.</p>';
    }
    exit();
}


if (isset($_POST['send_request_for_sotrudnik'])){
        if (CURRENT_USER::getInstance()->id){
            $check = new dbl_user_firm();
            if (!test_firm($_POST['id'])){
                echo 'no brand';
                exit();
            }
            $filter = array(
                "user_id" => CURRENT_USER::getInstance()->id,
                "firm_id" => $_POST['id'],
            );
            if ($check->setFilter($filter)->col()){
                $check->get();
                $res = $check->result[0];
                if ($res['agree'] == 1 && $res['firm_agree'] == 1){
                    echo 'Ваш запрос подтвержден';
                    exit();
                }elseif ($res['agree'] == 1 && $res['firm_agree'] == 0){
                    echo 'Ожидайте подтверждения от компании';
                    exit();
                }elseif ($res['agree'] == 0 && $res['firm_agree'] == 1){
                    $check->chg(array("agree"=>1));
                    echo 'Ваш запрос подтвержден';
                    exit();
                }
            }else{
                $values = array(
                    "user_id" => CURRENT_USER::getInstance()->id,
                    "firm_id" => $_POST['id'],
                    "agree" => 1,
                    "firm_agree" => 0,
                );
                $check->insert_local_table($values);
                echo 'Ожидайте подтверждения от компании';
                exit();
            }
        }

    exit();
}

if (isset($_POST['addClientToFirm'])) {
    $client = $_POST['client'];
    if (CURRENT_USER::getInstance()->role_GAK < 4) { /* не администраторы */
        test_firm_user($client);
    }
    $firm = $_POST['firm'];
    $flag =  $_POST['flag'];
    if (!test_firm($firm)){
        echo 'no brand';
        exit();
    }
    if (!test_firm($client)){
        echo 'no brand client';
        exit();
    }

    $clients = new dbl_clients();
    $clients->setFilter(array("firm_id"=>$firm, "client_id"=>$client));

    if ($flag == "add" && $clients->col()){
        $clients->get();
        if ($clients->result[0]['agree']){
            echo "- запрос подтвержден";
        }else{
            echo "- запрос отправлен";
        }
    }elseif ($flag == "add"){
        $clients->insert_local_table(array("firm_id"=>$firm, "client_id"=>$client));
        echo "- запрос отправлен";
    }elseif ($flag == "del" && $clients->col()){
        $clients->delete();
        echo "- клиент удален";
    }elseif ($flag == "del"){
        echo "";
    }
}

if (isset($_POST['changeRating'])) {
    $client = $_POST['client'];
    $firm = $_POST['firm'];
    if (!test_firm($firm)){
        echo 'no brand';
        exit();
    }
    $score =  $_POST['rating'];
    //$full_rating = 0;

    $rating = new dbl_rating();
    $filter = array("firm_id" =>$firm);
    if ($client) {
        if (!test_firm($client)){
            echo 'no brand client';
            exit();
        }
        $filter["client_id"] = $client;

        if (CURRENT_USER::getInstance()->role_GAK < 4) { /* не администраторы */
            test_firm_user($client);
        }
    }else{
        $filter["user_id"] = CURRENT_USER::getInstance()->id;
    }
    $rating->setFilter($filter);
    if ($rating->col()){
        $rating->chg(array("rating"=>$score));
    }else{
        $filter["rating"] = $score;
        $rating->insert_local_table($filter);
    }

    $smarty = SMARTY_GLOBAL::getInstance();
    $smarty->assign("rating", round($rating->update_rating($firm), 1));
    $smarty->assign("col", $rating->setFilter(array("firm_id"=>$firm))->col());
    echo $smarty->fetch("templates/rating.tpl");
    exit();
}

function test_firm_user($firm){
    $clients = new dbl_user_firm();
    $clients->setFilter(
        array(
            "user_id" => CURRENT_USER::getInstance()->id,
            "firm_id" => $firm,
            "firm_agree" => 1,
        )
    );
    if ($clients->col() == 0){ /* проверяем привязана ли эта фирма у пользователя */
        echo "ERR1. ";
        exit();
    }
}
function test_firm($id){
    $firm = new dbl_firm();
    if ($firm->setFilter(array("id"=>$id))->col()){
        return true;
    }
    return false;
}

if (isset($_POST['changeRemark'])) { /* ok */
    $client = $_POST['client'];
    $firm_id = $_POST['firm'];
    $page = $_POST['page'];
    $text = trim($_POST['text']); // Желателен preg_replace

    $remark = new dbl_remark();
    $filter = array("firm_id" => $firm_id);
    if ($client) {
        $filter["client_id"] = $client;
    }else {
        $filter["user_id"] = CURRENT_USER::getInstance()->id;
    }

    if (CURRENT_USER::getInstance()->role_GAK < 4){ /* не администраторы */
        $filter[] = array(
            "LOGIC"=>"OR",
            "user_id" => CURRENT_USER::getInstance()->id,
            "IN=client_id" => " SELECT firm_id FROM user_firm WHERE user_id = ".CURRENT_USER::getInstance()->id ,
        );
    }

    $remark->setFilter($filter);
    if ($remark->col() && $text) {
        $remark->get();
        if ($remark->result[0]['text'] != $text){
            $remark->chg(array("text" => $text));
        }
    } elseif ($text) {
        $filter["text"] = $text;
        $remark->insert_local_table($filter);
    }

    changeRemarkPage($firm_id, $page);
}

if (isset($_POST['changeAnswer'])) { /* ok */
    $id = $_POST['id'];
    $answer = $_POST['answer'];
    $answer = trim(preg_replace('/[^a-zA-Zа-яА-Я0-9,.;!? ]/ui', '', $answer));

    $remark = new dbl_remark();
    $filter = array("id" => $id);
    if (CURRENT_USER::getInstance()->role_GAK < 4){ /* не администраторы */
        $filter["IN=firm_id"] = " SELECT firm_id FROM user_firm WHERE firm_agree=1 AND user_id = ".CURRENT_USER::getInstance()->id ;
        /* отзыв может редактировать только тот пользователь, который привязан к карточке компании */
    }
    $remark->setFilter($filter);
    if ($remark->col() && $answer) {
        $remark->get();
        if ($remark->result[0]['text_answer'] != $answer) {
            $date = date("Y-m-d H:i:s");
            $remark->chg(array("text_answer" => $answer, "date_answer"=>$date));
        }
        echo "Изменен";
    }else{
        echo "Err";
    }
    exit();
}

if (isset($_POST['deleteAnswer'])) { /* ok */
    $id = $_POST['id'];

    $remark = new dbl_remark();
    $filter = array("id" => $id);
    if (CURRENT_USER::getInstance()->role_GAK < 4){ /* не администраторы */
        $filter["IN=firm_id"] = " SELECT firm_id FROM user_firm WHERE firm_agree=1 AND user_id = ".CURRENT_USER::getInstance()->id ;
        /* отзыв может редактировать только тот пользователь, который привязан к карточке компании */
    }
    $remark->setFilter($filter);
    if ($remark->col()) {
        $remark->get();
        $remark->chg(array("text_answer" => "", "date_answer"=>0));

        $liked = new dbl_liked();
        $liked->setFilter(array("obj"=>"remark_answer", "obj_id"=>$id))->delete();
    }
}


if (isset($_POST['changeRemarkBottom'])) { /* ok */
    $id = $_POST['remark_id'];
    $text = trim(preg_replace('/[^a-zA-Zа-яА-Я0-9,.;!? ]/ui', '', $_POST['text']));

    $remark = new dbl_remark();
    $filter = array("id" => $id);
    if (CURRENT_USER::getInstance()->role_GAK < 4){ /* не администраторы */
        $filter[] = array(
            "LOGIC"=>"OR",
            "user_id" => CURRENT_USER::getInstance()->id,
            "IN=client_id" => " SELECT firm_id FROM user_firm WHERE user_id = ".CURRENT_USER::getInstance()->id ,
        );
    }
    $remark->setFilter($filter);
    if ($remark->col()){
        $date = date("Y-m-d H:i:s");
        $remark->chg(array("text"=>$text, "date"=>$date));
        echo "Изменено";
    }else{
        echo "Ошибка изменения";
    }
    exit();
}

if (isset($_POST['deleteRemarkBottom'])) { /* ok */
    $id = $_POST['remark_id'];

    $remark = new dbl_remark();
    $filter = array("id" => $id);
    if (CURRENT_USER::getInstance()->role_GAK < 4){ /* не администраторы */
        $filter[] = array(
            "LOGIC"=>"OR",
            "user_id" => CURRENT_USER::getInstance()->id,
            "IN=client_id" => " SELECT firm_id FROM user_firm WHERE user_id = ".CURRENT_USER::getInstance()->id ,
        );
    }
    if ($remark->setFilter($filter)->col()){
        $remark->delete();
        $liked = new dbl_liked();
        $liked->setFilter(array("obj"=>"remark", "obj_id"=>$id))->delete();
        echo "удалено";
    }
    exit();
}


function changeRemarkPage($firm_id, $page){

    $render_firm = new render_firm(true);
    $render_firm->set_id($firm_id);
    $_GET['page'] = $page;
    $smarty = SMARTY_GLOBAL::getInstance();
    $smarty->assign("current_user", CURRENT_USER::getInstance());
    $viewer = new viewer();
    $smarty->assign("viewer",$viewer);
    echo $render_firm->render_remarks();
    exit();
}
