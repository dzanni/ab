<?php
class questions_answers extends db_lib{
    const TABLE_NAME = "answer";
    private $path;
    private $result_for_render;

    function __construct($dbh = 0){
        parent::__construct($dbh);

        $this->path = dirname(__FILE__)."/../modules/Quests/templates/";
        $this->setTableJoin("answer, users", "answer.user = users.id");
        $this->setSelectFields("answer.*, users.family_name AS family_name, users.name AS name");
        //$this->setSecurityFilter(array("answer.status" => 1)); // фильтр по умолчанию -- нельзя снять
    }

    public function get(){
        $result = parent::get();
        $this->parse_get_result($this->result);
        $this->result_for_render = $this->result;
        return $result;
    }

    protected function parse_get_result($data){
        for($i=0;$i<count($data);$i++){
            $data[$i]['likes'] = dbl_liked::getLikesByObj("answer", $data[$i]['id']); // получаем к-во лайков у ответа
            if (CURRENT_USER::getInstance()->id){
                $data[$i]['likes_my'] = dbl_liked::getLikesByObj("answer", $data[$i]['id'],CURRENT_USER::getInstance()->id); // ставил ли лайк этот пользователь или нет
                if ($data[$i]['user'] == CURRENT_USER::getInstance()->id || CURRENT_USER::getInstance()->role_GAK > 3){
                    $data[$i]['can_edit'] = true;
                }
                $data[$i]['can_like'] = true;
            }
            $data[$i]['files'] = $this->getFiles($data[$i]['id']);

            $data[$i]['title_txt'] = viewer::render_txt($data[$i]['title']);

            //Пришлось так добавить ответы на ответы
            if ($data[$i]['parent'] == 0){
                $ans = new self;
                //Фильтр нужен по всей цепочке детей
               //$ans->setFilter(array("parent"=> $data[$i]['id']));
               $ans->setFilter(array("IN=parent"=> implode(",", dbl_answer::get_child_id_arr($data[$i]['id']))));

                if ($ans->col()){
                    $ans->get();
                    $data[$i]['inner'] = $ans->result;
                }
            }
        }
        $this->result = $data;
        //debug::d($data, 1);

        return $data;
    }

    private function getFiles($ans){
        $obj = new dbl_answer_files();
        $obj->setCol(1000)->setFilter(array("answer"=>$ans))->setOrderBy(array("id"))->get();
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
        $smarty = SMARTY_GLOBAL::get();
        $smarty->assign("result", $this->result_for_render);

        $smarty->assign("current_user_id", CURRENT_USER::getInstance()->id);

        $pages = $this->getPagesArr("default",3);
        $smarty->assign("page_current", $this->page);
        $smarty->assign("pages", $pages);
        $smarty->assign("viewer", new viewer());

        return $smarty->fetch($this->path."answers.tpl");
    }

    public function remove_answer($id){
        $files = $this->getFiles($id);
        $path = dirname(__FILE__)."/../files/answer/";
        for ($i=0;$i<count($files);$i++){
            unlink($path.$files[$i]['filename']);
        }
        $obj = new dbl_answer_files();
        $obj->setFilter(array("answer"=>$id))->delete();

        $obj = new dbl_liked();
        $obj->setFilter(array("obj"=>"answer", "obj_id"=>$id))->delete();

        $obj = new dbl_answer();
        $obj->setFilter(array("id"=>$id))->delete();

        return 1;
    }


}