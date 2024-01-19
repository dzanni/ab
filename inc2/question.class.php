<?php

class question extends db_lib
{
    const TABLE_NAME = "quest";

    function __construct($dbh = 0)
    {
        parent::__construct($dbh);

        $this->setTableJoin("quest, users", "quest.user = users.id");
        $this->setSelectFields("quest.*, users.name AS name, users.family_name AS family_name");
    }
}