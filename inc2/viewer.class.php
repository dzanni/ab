<?php
class viewer
{
    private $msg_col = -1;

    static function add_basket($item)
    {
        $smarty = SMARTY_GLOBAL::get();

        $item['add_in_basket'] = CURRENT_ORDER::mk_add_in_basket_row($item);
        $smarty->assign("item", $item);
                return $smarty->fetch(dirname(__FILE__) . "/../templates/viewer/add_basket.tpl");
    }

    static function added_in_basket($item)
    {
        $smarty = SMARTY_GLOBAL::get();
        $smarty->assign("item", $item);
       //debug::d( $item, 1);

        return $smarty->fetch(dirname(__FILE__) . "/../templates/viewer/is_in_basket.tpl");
    }

    static function render_path($path)
    {
        $smarty = SMARTY_GLOBAL::get();
        $smarty->assign("path", $path);
        //print_r($path);
        return $smarty->fetch(dirname(__FILE__) . "/../templates/viewer/render_path.tpl");
    }

/*
    public function get_news_list_left()
    {
        require_once(dirname(__FILE__) . "/../core/cs_news/inc/cs_news.class.php");
        $news = new cs_news();
        $news->setCol(3)->setFilter(array("status" => 1))->setOrderBy(array("date DESC"))->get();
        $smarty = SMARTY_GLOBAL::get();
        $smarty->assign("news", $news->result);
        return $smarty->fetch("viewer/left_news.tpl");
    }
*/

    public function get_news_list_small()
    {
        require_once(dirname(__FILE__) . "/../core/cs_news/inc/cs_news.class.php");
        $news = new cs_news();
        $news->setCol(10)->setFilter(array("status" => 1))->setOrderBy(array("date DESC"))->get();
        $smarty = SMARTY_GLOBAL::get();
        $smarty->assign("news", $news->result);
        return $smarty->fetch(dirname(__FILE__) . "/../templates/viewer/news_list_small.tpl");
    }

    public static function get_filters($category = -1){
        if ($category < 0) {
            $category = ROUTE::getInstance()->category;
        }
        $filters = filters::getAllFiltersWithTitles(DB::getInstance(), $category);

        if(count($filters)){
            $smarty = SMARTY_GLOBAL::get();
            if (isset($_GET['brand'])){
                $brand = preg_replace("/[^0-9]/","",$_GET['brand']);
                $smarty->assign("brand", $brand);
            }
            $smarty->assign("filters",$filters);

            return $smarty->fetch(dirname(__FILE__) . "/../templates/viewer/filters.tpl");
        }
        return '';
    }

    public function get_widget($widget)
    {
        switch ($widget) {
            case "Новинки":
                return $this->get_new_tovar();
                break;
            case "Бренды":
                return $this->get_partners_slider();
                break;
            case "Новости":
                return $this->get_news_list_small();
                break;
            case "ПВЗ на карте":
                return $this->get_pwz_on_map();
                break;
            case "Счетчики":
                return $this->getCounters();
                break;
        }
        return '';
    }

    public function getCounters()
    {
        $obj = new AB_counters();
        return $obj->render();
    }

    public function get_pwz_on_map()
    {
        $pvz_map_generator = new pvz_map_generator();
        return $pvz_map_generator->render();
    }

    public function get_new_tovar()
    {
        $tovar = new catalog();
        $tovar->setFilter(array("active" => 1, "new" => 1))->setCol(8);
        if ($tovar->col()) {
            $smarty = SMARTY_GLOBAL::get();
            $smarty->assign("no_show_extra_params", true);
            $smarty->assign("add_title", "Новинки");
            return $tovar->render_list($smarty);
        }
        return '';
    }

    public static function get_partners_slider($flag = '')
    {
        $brands = new dbl_firm();
        $brands->setFilter(array("main_page" => 1))->setSelectFields("id, RAND() AS rand")->setCol(18)->setOrderBy(array(" rand "));
        $brands->get();
        if (count($brands->result)) {
            $smarty = SMARTY_GLOBAL::get();
            $smarty->assign("brands", $brands);
            $smarty->assign("flag", $flag);

            if ($flag){
                $tovar = new dbl_tovar();
                $smarty->assign("col", $tovar->col());
            }

            return $smarty->fetch(dirname(__FILE__) . "/../templates/viewer/partners.tpl");
        }

        return '';
    }

    public static function render_tyre_search_form($template, $type, $car_search){
        $search_form_generator = new search_form_generator();
        $search_form_generator->setTemplateType($template)->setSearchType($type)->setCar_search($car_search);
        return $search_form_generator->render();
    }

    public function returnClassObj($className){
        if (class_exists($className)) {
            if (is_callable(array($className, "getInstance"))){
                return $className::getInstance();
            }else{
                return new $className;
            }
        }
    }

    public static function getAdminFilters(){
        $smarty = SMARTY_GLOBAL::get();
        if (isset($_GET['code']) && $_GET['code'] > 0){
            $code = preg_replace("/[^0-9]/", "", $_GET['code']);
            $smarty->assign("code", $code);
        }
        if (isset($_GET['code_OEM']) && $_GET['code_OEM'] != ""){
            $code_OEM = preg_replace("/[^a-zA-Zа-яА-Я0-9\.,_-]/", "", $_GET['code_OEM']);
            $smarty->assign("code_OEM", $code_OEM);
        }
        if (isset($_GET['code_xml']) && $_GET['code_xml'] > 0){
            $code_xml = preg_replace("/[^a-zA-Z0-9\.,]/", "", $_GET['code_xml']);
            $smarty->assign("code_xml",  $code_xml);
        }
        $smarty->assign("role_GAK", CURRENT_USER::getInstance()->role_GAK);
        return $smarty->fetch(dirname(__FILE__) . "/../templates/viewer/admin_filters.tpl");

    }

    public function render_price($price){
        return str_replace(" ", "&nbsp;", number_format($price, PARAMS::get("ROUND_PRICE"), '.', " "));
    }
    public function render_date($date, $seconds=false){
        if ($seconds){
            return date("d.m.Y H:i:s", strtotime($date));
        }else{
            return date("d.m.Y H:i", strtotime($date));
        }
    }
    public function get_name_user($user){
        return dbl_users::getNameById($user);
    }
    public function get_msg_count(){
        if ($this->msg_col <= 0){
            $this->msg_col = messages_chats_lk::get_unread_in_all_chats();
        }
        return $this->msg_col;
    }

    public function gen_share($url = '', $acc = false, $size='m', $title = ''){
        $route = ROUTE::getInstance();
        if (!$url){
            $url = "https://expert.a-boss.ru".$route->get_url_with_params(array("u_from" => CURRENT_USER::getInstance()->id));
        }

        if ($title == ''){
            if (isset($_GET['user']) && $_GET['user'] == CURRENT_USER::getInstance()->id || $acc == true){
                $title = "Привет! Я уже участник профессиональной сети экспертов автобизнеса АвтоБосс. Эксперт. Жду тебя здесь!";
            }else{
                $title = "Привет! Посмотри эту страницу, она может быть полезна!";
            }
        }
        $html = '';
        if (!$acc){
            $html .= '<div class="comp__item-rating-t">Поделиться&nbsp;</div>';
        }
        //$html .= '<script src="https://yastatic.net/share2/share.js"></script><div class="ya-share2" data-title="'.$title.'" data-curtain data-shape="round" data-limit="8" data-services="messenger,vkontakte,odnoklassniki,telegram,twitter,viber,whatsapp,moimir" data-url="'.$url.'"></div>';
        $html .= '<script src="https://yastatic.net/share2/share.js"></script><div class="ya-share2" data-title="'.$title.'" data-curtain data-size="'.$size.'" data-shape="round" data-limit="8" data-services="vkontakte,odnoklassniki,telegram,viber,whatsapp" data-url="'.$url.'"></div>';
        return $html;
    }
    public function get_icon_by_user($user){
        if (file_exists(dirname(__FILE__)."/../images/u/$user.jpg")){
            return "/images/u/$user.jpg?f=".filemtime(dirname(__FILE__)."/../images/u/$user.jpg");
        }else{
            return "/i/noimg.png";
        }
    }
    public function get_icon_by_firm($firm){
        if (file_exists(dirname(__FILE__)."/../images/f/$firm.jpg")){
            return "/images/f/$firm.jpg?f=".filemtime(dirname(__FILE__)."/../images/f/$firm.jpg");
        }else{
            return "/i/noimg.png";
            return "/images/u/incognito.svg";
        }
    }

    public function getSellersName($id){
        $sellers = new dbl_sellers();
        $sellers->setSelectFields("title")->setFilter(array("id"=>$id));
        if ($sellers->col()){
            $sellers->get();
            return $sellers->result[0]["title"];
        }else{
            return "";
        }
    }

    public function getXmlCode($tovarId){
        $obj = new dbl_xml_import();
        $obj->setSelectFields("code, sellers, OEM")->setFilter(array("tovar"=>$tovarId));
        if ($obj->col()){
            $obj->get();
            return dbl_sellers::getXmlCode($obj->result[0]["code"], $obj->result[0]["sellers"], $obj->result[0]["OEM"] );
        }else{
            return "";
        }
    }

    public static function render_txt($text){
        //$regex = '/(http|https|ftp|ftps)\:\/\/[a-zA-Zа-яА-Я0-9\-\.]+\.[a-zA-Zа-яА-Я]{2,6}(\/\S*)?/u';
        $regex = '/(http|https|ftp|ftps)\:\/\/([a-zA-Zа-яА-Я0-9\-\.]+\.[a-zA-Zа-яА-Я]{2,6}(\/[^\s<>]*)?)/u';
        //$text = preg_replace($regex, "<a href='$0' target='_blank'>$2</a>", $text);

        $text = preg_replace_callback($regex, function ($matches) {

            if (strripos($matches[0], $_SERVER['HTTP_HOST'])){
                $domain = $_SERVER['HTTP_HOST'];
                if (strripos($matches[2], "/") || strripos($matches[2], "?")){
                    $domain .="/...";
                }
                return "<a href=$matches[0]>$domain</a>";
            }else{
                $domain = $matches[2];
                if (strripos($matches[2], "/")){
                    $domain = str_replace(stristr($domain, "/"), "", $domain);
                    $domain .="/...";
                }elseif (strripos($matches[2], "?")){
                    $domain = str_replace(stristr($domain, "?"), "", $domain);
                    $domain .="/...";
                }
                return "<a href=$matches[0] target='_blank'>$domain</a>";
            }
        },
            $text);

        $text = str_replace(array("\r\n", "\r", "\n"), '<br>', $text);
        return $text;
    }

    public function getParentUserNameByAnswerId($parent){
        $users = new dbl_users();
        $users->setSelectFields("CONCAT(family_name,' ',name) AS FN")->setFilter(array("IN=id"=>"SELECT user FROM answer WHERE id=$parent"));
        if (!$users->col()){
            return "Неизвестный";
        }else{
            $users->get();
            return $users->result[0]['FN'];
        }
    }

    public function get_right_block()
    {
        if (isset($_GET['firm']) && isset($_GET['firmpage']) && dbl_firm_pages::pageExist($_GET['firm'], $_GET['firmpage'])){
            $firm = new dbl_firm();
            $firm->setFilter(array("id" => $_GET['firm']));
            if ($firm->col()){
                $firm->setSelectFields('id, title, email, phone, address, tarif')->get();
                $firm_res = $this->jsonParseResult($firm->result[0]);

                //Документы
                $docs = new dbl_document();
                $docs->setFilter(array("firm"=>$firm_res['id']))->setOrderBy(array("position", "title"));
                if ($docs->col())
                {
                    $docs->get();
                    $firm_res['docs'] = $docs->result;
                    foreach ($firm_res['docs'] as &$val){
                        if ($val['date'] != 0){
                            $val['date'] = $this->formatDate($val['date']);
                        }else{
                            $val['date'] = false;
                        }
                    }
                }

                //Сайты
                $site = new dbl_site();
                $site->setFilter(array("firm"=>$firm_res['id']));
                if ($site->col()){
                    $site->get();
                    $firm_res['site'] = array();
                    foreach($site->result as $key => $res){
                        if ($res['URL']){
                            if (!$res['type']){
                                $firm_res['site'][0][] = $res;
                            }else{
                                $firm_res['site'][1][] = $res;
                            }
                        }
                    }
                }
                $smarty = SMARTY_GLOBAL::getInstance();
                $smarty->assign("firm", $firm_res);
                return $smarty->fetch(dirname(__FILE__) . "/../templates/viewer/right_block.tpl");

            }
        }
        return "";
    }

    private function formatDate($date){
        $date = date("d M Y", strtotime($date));
        $date_from = array(
            "Jan",
            "Feb",
            "Mar",
            "Apr",
            "May",
            "Jun",
            "Jul",
            "Aug",
            "Sep",
            "Oct",
            "Nov",
            "Dec"
        );
        $date_to = array(
            "января",
            "февраля",
            "марта",
            "апреля",
            "мая",
            "июня",
            "июля",
            "августа",
            "сентября",
            "октября",
            "ноября",
            "декабря",
        );
        $date = str_replace($date_from, $date_to, $date);
        return $date;
    }

    private function jsonParseResult($result){
        foreach ($result as &$res){
            if (is_array(json_decode($res, 1))){
                $res = json_decode($res, 1);
            }
        }
        return $result;
    }

}