<?php

//header("Cache-Control: no-store, no-cache, must-revalidate, max-age=0");
//header("Cache-Control: post-check=0, pre-check=0", false);
//header("Pragma: no-cache");

require (dirname(__FILE__)."/start.php");
require(dirname(__FILE__) . "/inc/tlgbot.class.php");

$bot = new Tlgbot();
$counter = new AB_counters();

$path = 'https://api.telegram.org/bot' . PARAMS::get("TLG_BOT_TOKEN");
$update = json_decode(file_get_contents("php://input"), TRUE);

// Вообще от греха подальше можно не вводить эти 4 переменные
$chatId = $update["message"]["chat"]["id"];
$message = $update["message"]["text"];
$user_name = $update["message"]["from"]["first_name"];
$user_tlg_id = $update["message"]["from"]["id"];

$bad = "Ваш телеграм-аккаунт не привязан к ". PARAMS::get("DOMAIN_EXP") . ". Нажмите \"Привязать к сайту\"";


// Бот сейчас обрабатывает два типа входящих данных: коллбэки с кнопок и текстовые сообщения

// Обработка коллбэков
if (isset($update['callback_query'])) {

    $text = "К этой кнопке еще не присоединили действие";

    if ($update['callback_query']['data'] === "/menu") {
        $text = "Меню:";

    } elseif ($update['callback_query']['data'] === "/bind") {
        $text = "У Вас уже есть профиль на Автбосс.Эксперт?";

    } elseif ($update['callback_query']['data'] === "/statistic") {

        $text = "Сейчас нас " . $counter->count_all() . ", +" . $counter->count_lastweek() . " за неделю" . "\n" . "<a href='" . PARAMS::get("DOMAIN_EXP") . "'>Смотреть всю статистику</a>";

    } elseif ($update['callback_query']['data'] === "/quest" || $update['callback_query']['data'] === "/news") {

        if (Tlgbot::checkTlgBind($update['callback_query']['from']['id'])) {
            $user_id = tlgbot::checkTlgBind($update['callback_query']['from']['id'])['id'];
            $quest = new dbl_quest();
            $insert = array("user" => $user_id);
            if ($update['callback_query']['data'] === '/news') {
                $insert['is_news'] = 1;
                $text = "Чтобы разместить новость, ";
            } else {
                $text = "Чтобы задать вопрос экспертам, ";
            }
            $quest_id = $quest->insert_local_table($insert);
            $text .= "перейдите по <a href='" . PARAMS::get("DOMAIN_EXP") . "/account/quests/?lk_quest_edit_profile=$quest_id" . "'>ссылке</a>";
        } else {
            $text = $bad;
        }

    } elseif ($update['callback_query']['data'] === "/user_find") {

        if (Tlgbot::checkTlgBind($update['callback_query']['from']['id'])) {
            $text = "Введите фамилию или фамилию и имя эксперта:";
            $reply_markup = json_encode(array("force_reply" => true));
        } else {
            $text = $bad;
        }

    } elseif ($update['callback_query']['data'] === "/firm_find") {

        if (Tlgbot::checkTlgBind($update['callback_query']['from']['id'])) {
            $text = "Введите название компании:";
            $reply_markup = json_encode(array("force_reply" => true));
        } else {
            $text = $bad;
        }

    } elseif ($update['callback_query']['data'] === "/news_find") {

        if (Tlgbot::checkTlgBind($update['callback_query']['from']['id'])) {
            if (abs($counter->count_quest_lastday(1)) > 0) {
                $text = "Новостей за сегодня -  " . abs($counter->count_quest_lastday(1));
            } else {
                $text = "Сегодня не было новостей";
            }
        } else {
            $text = $bad;
        }
    } elseif ($update['callback_query']['data'] === "/quest_find") {

        if (tlgbot::checkTlgBind($update['callback_query']['from']['id'])) {
            if (abs($counter->count_quest_lastday()) > 0) {
                $text = "Обсуждений за сегодня - " . abs($counter->count_quest_lastday());
            } else {
                $text = "Сегодня не было новых обсуждений";
            }

        } else {
            $text = $bad;
        }

    } elseif ($update['callback_query']['data'] === "/news_find_word") {

        if (Tlgbot::checkTlgBind($update['callback_query']['from']['id'])) {
            $text = "Введите ключевое слово для поиска новости:";
            $reply_markup = json_encode(array("force_reply" => true));
        } else {
            $text = $bad;
        }

    } elseif ($update['callback_query']['data'] === "/quest_find_word") {

        if (tlgbot::checkTlgBind($update['callback_query']['from']['id'])) {
            $text = "Введите ключевое слово для поиска обсуждения:";
            $reply_markup = json_encode(array("force_reply" => true));
        } else {
            $text = $bad;
        }
    } elseif ($update['callback_query']['data'] === "/auth_yes") {

        $text = "Давайте привяжем Ваш профиль к телеграм-аккаунту. Перейдите по <a href='" . PARAMS::get("DOMAIN_EXP") . "/account/?setTlg=" . $update['callback_query']['from']['id'] . "'>ссылке</a>, авторизуйтесь и на странице Автобосс.Эксперт нажмите кнопку 'Привязать профиль к Телеграм'. " . "\n" . "\n" . " После возвращайтесь ко мне, я Вас жду!";
    } elseif ($update['callback_query']['data'] === "/auth_no") {
        $text = "<a href='" . PARAMS::get("DOMAIN_EXP") . "/account/?lk_reg" . "'>Зарегистрируйтесь</a>";
    }

    if ($update['callback_query']['data'] === "/menu") {
        $keyboard = $bot->setKeyboards()['default'];
    }elseif ($update['callback_query']['data'] === "/news_find") {
        $keyboard = $bot->setKeyboards()['news_find'];
    }elseif ($update['callback_query']['data'] === "/quest_find") {
        $keyboard = $bot->setKeyboards()['quest_find'];
    }elseif ($update['callback_query']['data'] === "/bind") {
        $keyboard = $bot->setKeyboards()['auth'];
    }else{
        $keyboard = $bot->setKeyboards()['menu'];
    }

    if ($update['callback_query']['data'] != "/auth_yes" && $update['callback_query']['data'] != "/auth_no"){
        $inlineKeyboardMarkup = array(
            'inline_keyboard' => $keyboard
        );
        $reply_markup = $reply_markup ?? json_encode($inlineKeyboardMarkup);
    }

    // Reply with callback_query data
    $data = http_build_query([
        'chat_id' => $update['callback_query']['from']['id'],
        'text' => $text,
        "parse_mode" => "HTML",
        "reply_markup" => $reply_markup
    ]);

    file_get_contents($path . "/sendMessage?{$data}");
}

// Обработка сообщений
if ($message === '/start') {
    if (!tlgbot::checkTlgBind($user_tlg_id)) {
        $text = "Добро пожаловать в сообщество экспертов автобизнеса - Автобосс.Эксперт!" . "%0A" . "Я помогу пользоваться платформой и сообщу, если:" . "%0A" . "- придет личное сообщение;" . "%0A" .  "- поступит ответ на твой вопрос;" . "%0A" .  "- появится новое обсуждение или новость." . "%0A" . "%0A" ."Рекомендую посмотреть этот ролик, чтобы узнать больше о нашем ресурсе:";
        $ask_auth = true;
        $video = PARAMS::get("DOMAIN_EXP") . "/images/aboss.mp4";
    } else {

        $text = "Рад снова вас видеть! Кликните на Меню и начните пользоваться Автобосс.Эксперт";

        $keyboard = $bot->setKeyboards()['menu'];
        $inlineKeyboardMarkup = array(
            'inline_keyboard' => $keyboard
        );
        $reply_markup = json_encode($inlineKeyboardMarkup);
    }

// Ответ /user_find
}elseif ($update["message"]['reply_to_message']['text'] === "Введите фамилию или фамилию и имя эксперта:") {

    $filter = array("status"=>1);
    $search_txt = STANDART::parseSearch($message);
    if ($search_txt){
        $filter[] = array(
            "LOGIC" => "OR",
            "LIKE=name" => "%$search_txt%",
            "LIKE=family_name" => "%$search_txt%",
            "LIKE=NOPARSE_CONCAT(family_name,' ',name)" => "%$search_txt%",
            "LIKE=NOPARSE_CONCAT(name,' ',family_name)" => "%$search_txt%",
        );
    }
    $users = new dbl_users();
    $users->setSelectFields("id, CONCAT(name,' ',family_name) as FN")->setFilter($filter)->setOrderBy(array("score DESC"))->setCol(100)->get();
    $users_res = $users->result;

    $arr = array();
    foreach ($users_res as $val) {
        $arr[] = $val['FN'] . "%0A" .
        "<a href='" .  PARAMS::get("DOMAIN_EXP") . "/users/?user=" . $val['id'] . "'>Перейти к профилю</a>".
          "%0A" .
         "<a href='" .  PARAMS::get("DOMAIN_EXP") . "/account/messages/?user_to=" . $val['id'] . "'>Написать сообщение</a>" . "%0A";
    }

    if ($arr){
        $text=implode("%0A", $arr);
    } else{
        $text = "Увы, я ничего не нашел..." . "%0A" . "<a href='" . PARAMS::get("DOMAIN_EXP") . "/users/" . "'>Смотреть всех экспертов</a>";
    }

    $inlineKeyboardMarkup = array('inline_keyboard' => $bot->setKeyboards()['menu']);
    $reply_markup = json_encode($inlineKeyboardMarkup);

// Ответ /firm_find
}elseif ($update["message"]['reply_to_message']['text'] === "Введите название компании:" || $update["message"]['reply_to_message']['text'] === "Попробуйте ввести название на другом языке:") {

    $filter = array("status"=>1);
    $search_txt = STANDART::parseSearch($message);
    if ($search_txt){
        $filter[] = array(
            "LOGIC" => "OR",
            "LIKE=title" => "%$search_txt%",
        );
    }

    $firm = new dbl_firm();
    $firm->setSelectFields("id, title, rating")->setFilter($filter)->setOrderBy(array("rating DESC","title"))->setCol(10)->get();
    $firm_res = $firm->result;

    $arr = array();
    foreach ($firm_res as $val) {
        $arr[] = $val['title'] . "%0A" . "<a href='" . PARAMS::get("DOMAIN_EXP") . "/firms/?firm=" . $val['id'] ."'>Открыть карточку компании</a>" . "%0A";
    }

    $inlineKeyboardMarkup = array('inline_keyboard' => $bot->setKeyboards()['menu']);
    $reply_markup = json_encode($inlineKeyboardMarkup);

    if ($arr){
        $text=implode("%0A", $arr);
    } else{
        if ($update["message"]['reply_to_message']['text'] === "Попробуйте ввести название на другом языке:"){
            $text = "Увы, я ничего не нашел..." . "%0A" . "<a href='" . PARAMS::get("DOMAIN_EXP") . "/firms/" . "'>Смотреть все компании</a>";
        }else{
            $text = "Попробуйте ввести название на другом языке:";
            $reply_markup = json_encode(array("force_reply" => true));
        }
    }


//Ответ /news_find и /quest_find
}elseif ($update["message"]['reply_to_message']['text'] === "Введите ключевое слово для поиска новости:" || $update["message"]['reply_to_message']['text'] === "Введите ключевое слово для поиска обсуждения:") {

    $q_type = ($update["message"]['reply_to_message']['text'] === "Введите ключевое слово для поиска новости:") ? "news" : "quests";

//   $is_news = ($update["message"]['reply_to_message']['text'] === "Введите ключевое слово для поиска новости:") ? 1 : 0;
//
//   $filter = array('is_news'=>$is_news);
//    $search_txt = STANDART::parseSearch($message);
//    if ($search_txt){
//        $searchTxtAgainst = txt_search::clearText($search_txt);
//        $searchWord = "+" . str_replace(" ", " +", $searchTxtAgainst);
//
//        $search = " ( MATCH (quest.TXT_INDX) AGAINST ('".$searchWord."' IN BOOLEAN MODE) ) ";
//        $filter[] = array(
//            "LOGIC" => "OR",
//            "LIKE=quest.title" => "%$search_txt%",
//            "MATCH=" => $search,
//        );
//    }
//
//    $quest = new questions();
//    $quest->setFilter($filter)->setOrderBy(array("date DESC"))->setCol(10);
//    if ($quest->col()){
//        $quest->get();
//        $quest_res = $quest->result;
//
//        $arr = array();
//        foreach ($quest_res as $val) {
//            $br = "%0A";
//            $txt = str_replace(array("<br><br>", "<br>"),$br,$val['title']);
//            $txt = str_replace(array("<p>", "</p>"),"",$txt);
//            $arr[] = $val['name'] . " " . $val['family_name'] . "%0A" . $bot->formatDate($val['date']) . "%0A" . $txt . "%0A" . "<a href='" . PARAMS::get("DOMAIN_EXP") . "/quests/?quest=" . $val['id'] . "'>Ответить и посмотреть ответы</a>" . "%0A";
//        }
//
//        if ($is_news){
//            $type = 'news';
//            $txt1 = "новостей";
//        }else{
//            $type = 'quests';
//            $txt1 = "обсуждений";
//        }
//
//        $text = "Найдено $txt1 : " . $quest->col() . ". " . "<a href='" . PARAMS::get("DOMAIN_EXP") . "/quests/?q_type=$type%26q=$search_txt" ."'>Смотреть все</a> " . "%0A" . "%0A" . implode("%0A", $arr);
//
//    } else{
//        $text = "Поиск не дал результатов";
//    }

    require_once(dirname(__FILE__)."/modules/Quests/inc/render_quest.class.php");
    require_once(dirname(__FILE__)."/modules/Quests/inc/render_quest_TLG.class.php");
    $tlg_quest = new render_quest_TLG($q_type, $message);
    $text = $tlg_quest->getHtmlTLG();

    $inlineKeyboardMarkup = array('inline_keyboard' => $bot->setKeyboards()['menu']);
    $reply_markup = json_encode($inlineKeyboardMarkup);

//}elseif ($message === 'хуй' || mb_strpos($message, "хуй")) {
//    $text="Fucking Russians!";
}elseif ($message){
    $text="Сообщение не входит в список команд";
    if (!tlgbot::checkTlgBind($user_tlg_id)) {
        $inlineKeyboardMarkup = array('inline_keyboard' => $bot->setKeyboards()['bind']);
    }else{
        $inlineKeyboardMarkup = array('inline_keyboard' => $bot->setKeyboards()['menu']);
    }
    $reply_markup = json_encode($inlineKeyboardMarkup);
}

file_get_contents($path."/sendmessage?chat_id=$chatId&text=$text&parse_mode=HTML&reply_markup=$reply_markup");


// При входе с неизвестной телеги даем видео и второй запрос
if ($ask_auth){
    file_get_contents($path."/sendVideo?chat_id=$chatId&video=$video");

    $text = "У Вас уже есть профиль на Автбосс.Эксперт?";
    $inlineKeyboardMarkup = array('inline_keyboard' => $bot->setKeyboards()['auth']);
    $reply_markup = json_encode($inlineKeyboardMarkup);
    file_get_contents($path."/sendmessage?chat_id=$chatId&text=$text&parse_mode=HTML&reply_markup=$reply_markup");
}

