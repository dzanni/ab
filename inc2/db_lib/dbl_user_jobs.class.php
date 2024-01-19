<?php
class dbl_user_jobs extends db_lib{
    const TABLE_NAME = "user_jobs";

    public function set_work($id){
        $obj = new dbl_user_jobs();
        $obj->setFilter(array("user_id"=>$id, "till_now" => 1))->get();
        $chg = array("job_place" =>"", "job_title"=>"");
        if (count($obj->result)){
            $chg = array(
                "job_place" =>$obj->result[0]["firm_title"],
                "job_title"=>$obj->result[0]["job_title"],
              );
        }
        $users = new dbl_users();
        $users->setFilter(array("id" => $id))->chg($chg);
    }

    public function get_user_by_id($id){
        $obj = new dbl_user_jobs();
        $obj->setFilter(array("id"=>$id))->setSelectFields("user_id")->get();
        return $obj->result[0]['user_id'];
    }
}