<?php
class model_options extends db_lib{
    const TABLE_NAME = "options_values";

    function __construct(){
        parent::__construct();

        $this->setTableJoin("options_values, options", "options_values.id_options = options.id");
        $this->setSelectFields("options_values.*, options.title AS title_options");
    }

}

