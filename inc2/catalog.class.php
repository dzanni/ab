<?php
class catalog extends db_lib{
    const TABLE_NAME = "tovar";
    protected $get_photos = true;
    protected $get_all_photos = true;
    protected $get_files = true;
    protected $get_params = true;
    protected $get_brand_email = true;
    protected $basket_type = "";
    protected $pict_url = "images/photo/";
    protected $catalog_type = '';

    function __construct($dbh = 0){
        parent::__construct($dbh);

        $this->setTableJoin("tovar, firm, sellers", "tovar.firm = firm.id AND tovar.sellers = sellers.id");
        $this->setSelectFields("tovar.*, firm.title AS fName, sellers.title AS sTitle");
    }

    public function get(){
        $result = parent::get();
        $this->parse_get_result($this->result); ;
        return $result;
    }

    protected function parse_get_result($data){
        $route = ROUTE::getInstance();
        $Trans = array_flip(get_html_translation_table());
        for($i=0;$i<count($data);$i++){
            $data[$i]['basket_type'] = $this->basket_type;
            $data[$i]['title'] = strtr($data[$i]['title'], $Trans);
            $data[$i]['about'] = strtr($data[$i]['about'], $Trans);
            $data[$i]['fName'] = strtr($data[$i]['fName'], $Trans);
            if ($route->tire_disk){
                $data[$i]['title'] = $data[$i]['fName']." ".$data[$i]['title'];
            }
            $data[$i]['URL'] = $this->createURL($data[$i]);
            if ($data[$i]['oldPrice'] > $data[$i]['price'] && $data[$i]['price'] > 0){
                $data[$i]['skidka'] = round(($data[$i]['oldPrice'] - $data[$i]['price']) / $data[$i]['oldPrice']*100);
            }
            $data[$i]['priceFormated'] = str_replace(" ", "&nbsp;", number_format($data[$i]['price'], 0, '.', " "));
            $data[$i]['priceOldFormated'] = str_replace(" ", "&nbsp;", number_format($data[$i]['oldPrice'], 0, '.', " "));

            $data[$i]['files'] = unserialize($data[$i]['files']);
            $data[$i] = $this->add_extra_values($data[$i]);
            $data[$i] = $this->tovarInnerChg($data[$i]);
            $data[$i]['add_basket'] = $this->get_basket_html($data[$i]);
        }
        $this->result = $data;
        return $data;
    }

    protected function tovarInnerChg($data){
        return $data;
    }
    protected function createURL($data){
        return structure::createURL($data['category']).$data['enName']."-".$data['id'].".html";
    }
    protected function getPhoto($data){
        $obj = new dbl_timages();
        $filter = array("tovar" => $data['id']);
        $obj->setFilter($filter)->setOrderBy(array("main", "id DESC"))->setCol(1)->get();
        $img = $obj->result[0]['filename'];
        if ($img){
            $img = $this->pict_url . $img;
        }else{
            $img = "images/no_image.png";
        }
        return $img;
    }

    protected function getAllPhoto($data){
        $obj = new dbl_timages();
        $filter = array("tovar" => $data['id']);
        $obj->setFilter($filter)->setOrderBy(array("main", "id DESC"))->setCol(100)->get();
        foreach ($obj->result as &$v) {
            $v['filename'] = $this->pict_url . $v['filename'];
        }
        $img = $obj->result;
        return $img;
    }

    protected function add_extra_values($data)
    {
        if ($this->get_photos) {
            $data["IMG"] = $this->getPhoto($data);
        }
        if ($this->get_all_photos) {
            $data["IMG_ALL"] = $this->getAllPhoto($data);
        }
        if ($this->get_files) {
            $obj = new dbl_tfiles();
            $filter = array("tovar" => $data['id']);
            $obj->setSelectFields("filename, user_filename, ext")->setFilter($filter)->setOrderBy(array("user_filename"))->get();
            $data["files"] = $obj->result;
        }
        if ($this->get_params) {
            $obj = new tovar_options();
            $filter = array("data.tovar" => $data['id']);
            $obj->setFilter($filter)->setOrderBy(array("options.position", "options.title"))->setCol(100)->get();
            $data["PARAMS"] = $obj->result;
        }

        if ($this->get_brand_email) {
            $obj = new dbl_firm();
            $filter = array("id" => $data['firm']);
            $obj->setSelectFields("email")->setFilter($filter)->get();
            $data["brand_email"] = $obj->result[0]['email'];
        }

        $obj = new dbl_favorite();
        $user_id = CURRENT_USER::getInstance()->id;
        $filter = array("tovar_id" => $data['id'], "user_id" => $user_id);
        $obj->setFilter($filter)->get();
        if ($obj->col()){
        $data["favorite"] = 1;
        }else{
        $data["favorite"] = 0;
        }

        //debug::d($data["favorite"], 1);
        return $data;
    }

    public function render_list($smarty = false){
        if (!$smarty){
            $smarty = SMARTY_GLOBAL::get();
        }
        $smarty->assign("viewer", new viewer());

        $this->get();
        $path = dirname(__FILE__)."/../templates/";
        $smarty->assign("path", $path);
        $smarty->assign("CURRENT_USER", CURRENT_USER::getInstance());
        $smarty->assign("tovar", $this->result);
        $smarty->assign("catalog_type", $this->catalog_type);

        return $smarty->fetch($path."spisok_tovarov.tpl");
    }
    public function set_catalog_type($v){
        $this->catalog_type = $v;
        return $this;
    }
    public function set_basket_type($v){
        $this->basket_type = $v;
        return $this;
    }
    public function set_get_photos($v){
        $this->get_photos = $v;
        return $this;
    }
    public function set_get_all_photos($v){
        $this->get_all_photos = $v;
        return $this;
    }
    public function set_get_params($v){
        $this->get_params = $v;
        return $this;
    }

    protected function get_basket_html($element){
        $order = CURRENT_ORDER::getInstance();
        $col = $order->check_is_in_basket($element);
        if ($col == 0){
            return viewer::add_basket($element);
        }
        $element['col_in_basket'] = $col;
        return viewer::added_in_basket($element);
    }

}