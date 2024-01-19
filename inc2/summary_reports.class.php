<?php
class summary_reports{
    private $path = '';
    private $current_user = 0;
    public $msg;
    public $ans;
    public $rmk;

    function __construct(){
        $hour = 1 * date("H"); // убираем ведущий ноль
        $this->path = dirname(__FILE__)."/../templates/mail/";
        if ($hour > 9){
            $this->get_tasks();
        }
    }

    private function get_tasks(){
        $users = new dbl_users();
        $filter = array(
           // "IN=id" => "2,16334",
           // "IN=id" => "2",
            "LIKE=login" => "%@%",
            "<last_report_send_or_check" => date("Y-m-d 9:00:01", time()),
            "status" => 1,
            "send_mail" => 0,

        );
        if ($users->setFilter($filter)->col()){
            $users->setCol(5);
            $users->get();

            foreach ($users->result as $result) {
                $this->current_user = $result;
                $this->mk_report();
            }
        }else{
            exit();
        }
    }

    private function mk_report(){
        if ($this->current_user['id']){
            $this->msg = $this->get_new_messages();
            $this->ans = $this->get_new_answers();
            $this->rmk = $this->get_new_remarks();
            if ( ($this->msg + $this->ans['col'] + $this->rmk['col']) > 0){
                $mail = new mail();
                $mail->setTo($this->current_user['login']);
                $mail->setAdmin_copy(true); // todo убрать.
                $smarty = SMARTY_GLOBAL::getInstance();
                $smarty->assign("user", $this->current_user);
                $smarty->assign("obj", $this);

                $TXT = $smarty->fetch($this->path."summary_report.tpl");

                $mail->setTheme("Отчет по событиям");
                $mail->setTxt($TXT);
                $mail->send();
            }

            $user = new dbl_users();
            $user->setFilter(array("id"=>$this->current_user['id']))->chg(array("last_report_send_or_check"=> date("Y-m-d H:i:s")));
        }
    }

    private function get_new_messages(){
        $filter = array(
            "user_to" => $this->current_user['id'],
            ">date" => $this->current_user['last_report_send_or_check'],
            "has_seen" => 0,
        );
        $msg = new dbl_messages();
        return $msg->setFilter($filter)->col();
    }
    private function get_new_answers(){
        $filter = array(
            "!=user" => $this->current_user['id'],
            "IN=quest_id" => " SELECT id FROM quest WHERE user = ".$this->current_user['id'],
            ">date" => $this->current_user['last_report_send_or_check'],
            "status" => 1,
        );
        $obj = new dbl_answer();
        $col = $obj->setFilter($filter)->col();
        $result = array();
        if ($col){
            $obj->setSelectFields("id, quest_id, COUNT(id) AS col ")->setGroupBy("quest_id")->get();
            $result = $obj->result;
            for($i=0;$i<count($result);$i++){
                $result[$i]['title'] = $this->getQuestTitle($result[$i]['quest_id']);
            }
        }
        return array("col"=>$col, "res"=>$result);
    }

    private function getQuestTitle($id){
        $obj = new dbl_quest;
        $obj->setSelectFields("title")->setFilter(array('id'=>$id))->get();
        return $obj->result[0]['title'];
    }
    private function get_new_remarks(){
        $filter = array(
            "IN=firm_id" => " SELECT id FROM firm WHERE users = ".$this->current_user['id'],
            ">date" => $this->current_user['last_report_send_or_check'],
            "!=text" => "",
        );
        $obj = new dbl_remark();
        $col = $obj->setFilter($filter)->col();

        $result = array();
        if ($col){
            $obj->setSelectFields("id, firm_id, COUNT(id) AS col ")->setGroupBy("firm_id")->get();
            $result = $obj->result;
            for($i=0;$i<count($result);$i++){
                $result[$i]['title'] = $this->getFirmTitle($result[$i]['firm_id']);
            }
        }
        return array("col"=>$col, "res"=>$result);
    }

    private function getFirmTitle($id){
        $obj = new dbl_firm();
        $obj->setSelectFields("title")->setFilter(array('id'=>$id))->get();
        return $obj->result[0]['title'];
    }
}