<?php
if ($_FILES) {
    require("../../start.php");
    require (dirname(__FILE__)."/autoload.php");
    if ($_FILES['upl']['name'] <> "") {
        $file = new dbl_messages_files();
        $insert = array(
            "data" => file_get_contents($_FILES['upl']['tmp_name']),
            "name" => $_FILES['upl']['name'],
            "type" => mime_content_type($_FILES['upl']['tmp_name']),
        );

        echo $file->insert_local_table($insert);
    }
    die;
}