<?php
class CONTENT{
    protected static $_instance;
    private $data = array();
    public $html;
    // Переменные для лендингов страниц фирм
    private $firm = 0;
    private $firmpage = 0;
    private $firm_logik = false;
    private $filter;

    public function __construct(route $route)
    {
        //Хардкодим в условиях id модуля /firms/, чтобы не добавлял лендинги фирм в иных местах
//        if ($route->mainModule['id'] == 23 && isset($_GET['firm']) && isset($_GET['firmpage'])) {
//            $this->firm = preg_replace("/[^0-9]/", "", $_GET['firm']);
//            $this->firmpage = preg_replace("/[^0-9]/", "", $_GET['firmpage']);
//        }
//        if($this->firm && $this->firmpage){
//            if (dbl_firm_pages::pageExist($this->firm, $this->firmpage)){
//                $this->firm_logik = true;
//            }
//        }

        if ($route->firmPage){
            $this->firm = preg_replace("/[^0-9]/", "", $_GET['firm']);
            if (isset($_GET['firmpage']) && $_GET['firmpage']){
                $this->firmpage = preg_replace("/[^0-9]/", "", $_GET['firmpage']);
            }else{
                $this->firmpage = 0;
            }
            $this->firm_logik = true;
        }

        // Разрешаем вставлять блоки в модуль /firms/
        if ($route->mainModule && !$this->firm_logik) // SEO PARAMS insert inside the module
            return false;
        if ($route->category >= 0 && !ROUTE::getInstance()->tovar){
            $cnt = new dbl_coreDataTable();

            $this->filter = ($this->firm_logik) ? array("firm"=>$this->firm, "firmpage"=>$this->firmpage) : array("coreDataCategory"=>$route->category);

            $cnt->setFilter($this->filter)->setCol(100)->setOrderBy(array("position"))->get();
            $this->data = $cnt->result;
            if (isset($_GET['debug'])){
                debug::d($this->data);
            }
            for ($i=0;$i<count($this->data);$i++){
                $this->data[$i] = $this->makeTxtBlock($this->data[$i]);
            }
        }
    }
    public static function getInstance (ROUTE $ROUTE){
        if (self::$_instance === null) {
            self::$_instance = new self($ROUTE);
        }

        return self::$_instance;
    }
    private function __clone() {
    }

    private function __wakeup() {
    }

    private function makeTxtBlock($data){
        $Trans=array_flip(get_html_translation_table());
        $data['text']=strtr($data['text'], $Trans);

        if ($data['landing_block_type_id'] > 0){
            if ($data['landing_block'] == ""){
                $data['landing_block'] = array();
            }else{
                $data['landing_block'] = unserialize($data['landing_block']);
            }
        }

        return $data;
    }

    public function parse_content(){
        $this->html = array();
        $USER = CURRENT_USER::getInstance();
        $LB_edit = false;
        if (isset($USER->LB_edit_on_page)){
            $LB_edit = true;
            $APP = APP::getInstance();

            $APP::add_css("/modules/LB_edit_on_page/LB_edit.css");
            $APP::add_js("/modules/LB_edit_on_page/LB_edit.js");
            $APP::add_js("/modules/LB_edit_on_page/jquery.arcticmodal-0.3.min.js");
        }

        for($i=0;$i<count($this->data);$i++){
            $smarty = SMARTY_GLOBAL::getInstance();
            $smarty->assign("data",$this->data[$i]);
            $smarty->assign("mainParams",PARAMS::getAll());
            $smarty->assign("current_user", CURRENT_USER::getInstance());
            $smarty->assign("right_block", ROUTE::getInstance()->right_block);
            $smarty->assign("white_back", ROUTE::getInstance()->white_back);
            $smarty->assign("firmPage", ROUTE::getInstance()->firmPage);
            if (isset($_SESSION['LB_edit'])){
                $smarty->assign("LB_edit", true);
            }else{
                $smarty->assign("LB_edit", false);
            }

            $this->html[] = $smarty->fetch("shablon/txt_block.tpl");
        }

        if ($LB_edit){
            $this->html[] = $USER->LB_edit_on_page->html;
            if (isset($_SESSION['LB_edit'])) {
                $this->html[] = $USER->LB_edit_on_page->getInsertBasicHtml();
            }
        }
        return $this->html;
    }

    public function get(){
        return $this->data;
    }


    // Отсекаем главную страницу
    public function check_need_show_header(){
        for($i=0;$i<count($this->data);$i++){
            if ($this->data[$i]['landing_block_type_id'] == 2) return false;
        }
       return true;
    }

}