<?php
class menu{
    static function get(route $route){
        return array(
            "topMenu"  => self::getWidthSubs($route,0, 1),
            //"topMenu2" => self::get_menu_by_code($route,0, 2),
            "topMenu2" => self::getWidthSubs($route,0, 2),
            "footer"   => self::get_menu_by_code($route,0, 5),
        );
    }
    static function getWidthSubs($route,$parent, $code){
        $res = self::get_menu_by_code($route,$parent, $code);
        for($i=0;$i<count($res);$i++){
            if ($res[$i]['URL'] == "/O-nas/"){
                $res[$i]['URL'] = '/';
            }
            $res[$i]["inner"] = self::getSubCats($res[$i]['id'], $res[$i]['URL']);
        }
        return $res;
    }
    static function getSubCats($parent, $url){
        $category = new dbl_category();
        $category->setSelectFields("id, title, enURL");
        $category->setFilter(array("parent"=>$parent))->get();
        $res = $category->result;
        foreach ($res as &$r){
            $r["URL"] = $url.$r['enURL']."/";
            $r["inner"] = self::getSubCats($r['id'], $r["URL"]);
        }
        return $res;
    }

    static function get_menu_by_code(route $route, $parent, $code){
        $category = new dbl_category();
        if ($parent === "no"){
            $filter = array("LIKE=ctype"=>"%".$code."%");
        }else{
            $filter = array("parent"=>$parent, "LIKE=ctype"=>"%".$code."%");
        }
        $category->setSelectFields("id, title")->setFilter($filter)->setOrderBy(array("position DESC", "title"))->get();
        for($i=0;$i<count($category->result);$i++){
             $category->result[$i]['URL'] = structure::createURL($category->result[$i]['id']);
             if ($route->category == $category->result[$i]['id']){
                 $category->result[$i]['selected'] = true;
             }
        }
        return $category->result;
    }
}