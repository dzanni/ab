<?php
class LB_edit_on_page{
    public $html;
    public $LB_edit;
    private $link_close ='?LB_edit_close=true';
    private $link_show ='?LB_edit_show=true';
    private $firm = 0;
    private $firmpage = 0;

    function __construct(){

        $smarty = SMARTY_GLOBAL::get();
        if (isset($_GET['LB_edit_show'])){
            $_SESSION['LB_edit'] = true;
        }
        if (isset($_GET['LB_edit_close'])){
            unset($_SESSION['LB_edit']);
        }

        $LB_edit = false;
        if (isset($_SESSION['LB_edit'])){
            $LB_edit = $_SESSION['LB_edit'];
        }
        $smarty->assign("LB_edit",$LB_edit);
        require_once (dirname(__FILE__)."/../../inc/landing_block_type.class.php");

        $lb_title_by_code = array();
        $tmp = landing_block_type::get_base_structure(DB::getInstance());
        for($i=0;$i<count($tmp);$i++){
            $lb_title_by_code[$tmp[$i]['id']] = $tmp[$i]['title'];
        }
        $ROUTE = ROUTE::getInstance();
        $category = $ROUTE->category;

        //        if (isset($_GET['firm']) && isset($_GET['firmpage'])){
//            $this->firm  = preg_replace("/[^0-9]/", "", $_GET['firm']);
//            $this->firmpage = preg_replace("/[^0-9]/", "", $_GET['firmpage']);
//            if (dbl_firm_pages::pageExist($this->firm, $this->firmpage)){
//             $category = -1;
//             $this->link_close ="?firm=" . $this->firm . "&firmpage=" . $this->firmpage . "&LB_edit_close=true";
//             $this->link_show ="?firm=" . $this->firm . "&firmpage=" . $this->firmpage . "&LB_edit_show=true";
//            }
//        }

        if ($ROUTE->firmPage) {
            $this->firm = preg_replace("/[^0-9]/", "", $_GET['firm']);
            if (isset($_GET['firmpage'])){
                $this->firmpage = preg_replace("/[^0-9]/", "", $_GET['firmpage']);
                $add = "&firmpage=" . $this->firmpage;
            }else{
                $add = '';
            }
            $category = -1;
            $this->link_close ="?firm=" . $this->firm . $add . "&LB_edit_close=true";
            $this->link_show ="?firm=" . $this->firm . $add . "&LB_edit_show=true";
        }

        $smarty->assign("category", $category);
        $smarty->assign("tovarId", $ROUTE->tovar);
        $smarty->assign("LB_base", $lb_title_by_code);
        $smarty->assign("firm", $this->firm);
        $smarty->assign("firmpage", $this->firmpage);
        $smarty->assign("link_close", $this->link_close);
        $smarty->assign("link_show", $this->link_show);

        $this->html = $smarty->fetch(dirname(__FILE__)."/../../modules/LB_edit_on_page/templates/LB_edit_on_page.tpl");
        $this->LB_edit = $LB_edit;
    }

    public function getInsertBasicHtml(){
        return '<div class="cs_block_element cs_block_element_none" data-id="0"></div>';
    }

    public function getForTheTovar(){
        return '<div class="cs_block_element cs_block_element_none" data-id="0"></div>';
    }
}