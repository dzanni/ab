<?php
require("../../start.php");

if (isset($_POST['createNewQuest'])) {
    $user_id = CURRENT_USER::getInstance()->id;

    $insert = array("user" => $user_id);
    if ($_POST['is_news']){
        $insert['is_news'] = 1;
    }

    $quest = new dbl_quest();
    $id = $quest->insert_local_table($insert);
    dbl_score::add_score($user_id, "quest");
    echo $id;
    exit();
}

if (isset($_POST['createNewAnswer'])) {
    $user_id = CURRENT_USER::getInstance()->id;
    $quest_id = $_POST['quest'];
    $answer = new dbl_answer();
    $answer->setFilter(array("quest_id" => $quest_id, "user" => $user_id));
    if (!$answer->col()) {
        $id = $answer->insert_local_table(array("quest_id" => $quest_id, "user" => $user_id));
    } else {
        // Сюда не должно зайти - только если вдруг в tpl не передался id существующего ответа
        $answer->get();
        $id = $answer->result[0]['id'];
    }
    echo $id;
    exit();
}

if (isset($_POST['changeAnswer'])) {
    $user_id = CURRENT_USER::getInstance()->id;
    $quest_id = $_POST['quest'];
    $title = trim(preg_replace('/[^a-zA-Zа-яА-Я0-9,.;!? ]/ui', '', $_POST['title']));
    //$title = viewer::render_txt($title);
    $page = 1;

    $answer = new dbl_answer();
    $answer->setFilter(array("quest_id" => $quest_id, "user" => $user_id));
    if ($answer->col()) {
        $answer->chg(array("title" => $title));

        changeAnswerPage($quest_id, $page);
    }
}

if (isset($_POST['changeAnswerPage'])) {
    $quest_id = $_POST['quest'];
    $page = $_POST['page'];

    changeAnswerPage($quest_id, $page);
}

if (isset($_POST['deleteAnswer'])) {
    $user_id = CURRENT_USER::getInstance()->id;
    $quest_id = $_POST['quest'];
    $page = 1;

    $answer = new dbl_answer();
    $answer->setFilter(array("quest_id" => $quest_id, "user" => $user_id))->delete();

    changeAnswerPage($quest_id, $page);
}

if (isset($_POST['changeQuestAnswer'])) {
    $id = $_POST['answer_id'];
    $text = trim(preg_replace('/[^a-zA-Zа-яА-Я0-9,.;!? ]/ui', '', $_POST['text']));
    //$text = viewer::render_txt($text);
    $answer = new dbl_answer();
    $answer->setFilter(array("id" => $id));
    if ($answer->col()) {
        $answer->chg(array("title" => $text));
    }
}

if (isset($_POST['deleteQuestAnswer'])) {
    $id = $_POST['answer_id'];
    $answer = new dbl_answer();
    $answer->setFilter(array("id" => $id))->delete();

    $liked = new dbl_liked();
    $liked->setFilter(array("obj"=>"answer", "obj_id"=>$id))->delete();

    $answer_files = new dbl_answer_files();
    $answer_files->setFilter(array("answer"=>$id));
    if ($answer_files->col()){
        $answer_files->get();
        foreach($answer_files->result as $res){
            unlink(dirname(__FILE__)."/../../files/answer/".$res['filename']);
        }
        $answer_files->delete();
    }

}

function changeAnswerPage($quest_id, $page){
    $answer = new dbl_answer();
    $answer->setFilter(array("quest_id" => $quest_id));
    if ($answer->col()) {
        $answer->setOrderBy(array("date DESC"))->setCol(2)->setPage($page)->get();
    }

    foreach ($answer->result as &$res) {
        $res["full_name"] = dbl_users::getNameById($res['user']);
        $liked = new dbl_liked();
        $liked->setFilter(array("obj" => "answer", "obj_id" => $res['id']));
        $res['like'] = $liked->col();

        //Фрагмент для аякса, в классе render_quest() файлы добавляются отдельной функцией
        $answer_files = new dbl_answer_files();
        $answer_files->setFilter(array("answer"=>$res['id']));
        if ($answer_files->col()){
            $answer_files->get();
            $res['files'] = $answer_files->result;
        }

    }
    $result = $answer->result;

    $smarty = SMARTY_GLOBAL::getInstance();
    $smarty->assign("page", $page);
    $smarty->assign("current_user", CURRENT_USER::getInstance());
    $smarty->assign("page_current_answer", $page);
    $smarty->assign("answers", $result);
    $smarty->assign("quest_id", $quest_id);

    $pages_answer = $answer->getPagesArr("default", 3);
    $smarty->assign("pages_answer", $pages_answer);

    echo $smarty->fetch("templates/answer_pages.tpl");
}