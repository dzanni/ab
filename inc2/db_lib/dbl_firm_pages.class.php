<?php
class dbl_firm_pages extends db_lib{
    const TABLE_NAME = "firm_pages";

    public static function checkUserPagesAccess(){
        $dbh = DB::getInstance();
        $sql = "SELECT id FROM firm_pages WHERE firm IN (SELECT id FROM firm WHERE users=" . CURRENT_USER::getInstance()->id . ")";
        $result = $dbh->query($sql);
        $data = $result->fetchAll(PDO::FETCH_ASSOC);
        if ($data){
            return 1;
        }
        return 0;
    }

    public static function pageExist($firm, $page){
        $dbh = DB::getInstance();
        if ($page){
            $sql = "SELECT id FROM firm_pages WHERE id=$page AND firm=$firm";
        }else{
            $sql = "SELECT id FROM firm WHERE id=$firm";
        }
        $result = $dbh->query($sql);
        $data = $result->fetchAll(PDO::FETCH_ASSOC);
        if ($data){
            return 1;
        }
        return 0;
    }
}