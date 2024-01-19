<?php
class questions extends db_lib{
    const TABLE_NAME = "quest";
    private $path;
    private $col_answers = 0;
    private $result_for_render;

    function __construct($dbh = 0){
        parent::__construct($dbh);
        $this->path = dirname(__FILE__)."/../modules/Quests/templates/";

        $this->setTableJoin("quest, users", "quest.user = users.id");
        $this->setSelectFields("quest.*, users.family_name AS family_name, users.name AS name");
        $this->setSecurityFilter(array("quest.status" => 1)); // фильтр по умолчанию -- нельзя снять
    }
    public function get(){
        $result = parent::get();
        $this->parse_get_result($this->result);
        $this->result_for_render = $this->result;
        return $result;
    }

    public function getTLG(){
        $result = parent::get();
        return $result;
    }


    public function set_col_answers($col){
        $this->col_answers = $col;
    }

    protected function parse_get_result($data){
        for($i=0;$i<count($data);$i++){
             if ($this->col_answers){
                  $data[$i]['answers'] = $this->getAnswers($data[$i]['id']);
             }
            $data[$i]['tags'] = $this->getTags($data[$i]['id']);
            $data[$i]['files'] = $this->getQuestFiles($data[$i]['id']);

            $data[$i]['likes'] = dbl_liked::getLikesByObj("quest", $data[$i]['id']); // получаем к-во лайков у вопроса

             if (CURRENT_USER::getInstance()->id){
                 $data[$i]['likes_my'] = dbl_liked::getLikesByObj("quest", $data[$i]['id'],CURRENT_USER::getInstance()->id); // ставил ли лайк этот пользователь или нет
                 if ($data[$i]['user'] == CURRENT_USER::getInstance()->id || CURRENT_USER::getInstance()->role_GAK > 3){
                     $data[$i]['can_edit'] = true;
                 }
                 $data[$i]['can_like'] = true;
                 $data[$i]['current_answer'] = $this->getMyCurrentAnswer($data[$i]['id']);
             }
        }
        $this->result = $data;

        if (isset($_GET['debug_quest'])){
            debug::d($data);
        }
        return $data;
    }

    public function deleteFiles()
    {
        if ($_POST["deleteAnswerFile"] && $this->check_edit_answer($_POST["id"])) {
            $filename = $_POST["filename"];
            $id = $_POST["id"];

            $files = new dbl_answer_files();
            $filter = array("id" => $id);
            $files->setFilter($filter)->delete();
            unlink(dirname(__FILE__) . "/../files/answer/" . $filename);

        } else {
            return '';
        }
    }

    protected function check_edit_answer($id){
        if (CURRENT_USER::getInstance()->role_GAK < 4) { /* не администраторы */
            $ans = new dbl_answer();
            $ans->setFilter(array("id"=>$id, "user"=>CURRENT_USER::getInstance()->id));
            if ($ans->col() == 0){
                return false;
            }
        }
        return true;
    }

    private function getTags($quest){
        $tags = new dbl_tags();
        $filter = array(
            "IN=id" => " SELECT tag_id FROM quest_tags WHERE quest_id = $quest "
        );
        $tags->setCol(1000)->setFilter($filter)->setOrderBy(array("title"))->get();
        return $tags->result;
    }
    private function getAnswers($quest){
        $ans = new questions_answers();
        $ans->setCol($this->col_answers)->setFilter(array("quest_id"=>$quest, "answer.status"=>1, "answer.parent"=>0))->setOrderBy(array("date"))->get();
        foreach ($ans->result as &$r){
            $ans1 = new questions_answers();
            $ans1->setFilter(array("answer.status"=>1, "answer.parent"=>$r['id']))->setOrderBy(array("date"))->get();
            $r['inner'] = $ans1->result;
        }

//        echo"<pre>";
//        var_dump($ans->result);

        return array("res"=>$ans->result, "html"=>$ans->render(), "col"=>$ans->col()); // порядок важен. Если сначала col то результат пропадет
    }
    private function getMyCurrentAnswer($quest){
        $ans = new questions_answers();
        $ans->setCol($this->col_answers)->setFilter(array("quest_id"=>$quest, "answer.status"=>0, "answer.user"=>CURRENT_USER::getInstance()->id))->setOrderBy(array("date"))->get();
        if (count($ans->result)){
            return $ans->result[0];
        }
        return array();
    }

    private function getQuestFiles($quest){
        $obj = new dbl_quest_files();
        $obj->setCol(1000)->setFilter(array("quest"=>$quest))->setOrderBy(array("id"))->get();
        if (count($obj->result)){
            for($i=0;$i<count($obj->result);$i++){
                if ($obj->result[$i]['mime'] == "image/png" || $obj->result[$i]['mime'] == "image/gif" || $obj->result[$i]['mime'] == "image/jpeg" ){
                    $obj->result[$i]['is_img'] = true;
                }else{
                    $obj->result[$i]['is_img'] = false;
                }
            }
        }
        return $obj->result;
    }

    public function render(){
        $smarty = SMARTY_GLOBAL::getInstance();
        $smarty->assign("result", $this->result_for_render);
        $smarty->assign("col_answers", $this->col_answers);
        if (isset($_GET['quest'])){
            $smarty->assign("show_ans", true);
        }
        $smarty->assign("current_user_id", CURRENT_USER::getInstance()->id);
        $smarty->assign("viewer", new viewer());
        $smarty->assign("url", PARAMS::get("DOMAIN_EXP"));

        return $smarty->fetch($this->path."questions.tpl");
    }
}