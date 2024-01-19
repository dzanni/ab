<?php

class new_tag extends db_lib
{
    const TABLE_NAME = "tag_from_user";

    function __construct($dbh = 0)
    {
        parent::__construct($dbh);

        $this->setTableJoin("tag_from_user, tags", "tag_from_user.parent_id = tags.id");
        $this->setSelectFields("tag_from_user.*, tags.title AS parent_title");
    }
}