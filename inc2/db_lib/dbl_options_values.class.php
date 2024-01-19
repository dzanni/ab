<?php
class dbl_options_values extends db_lib
{
    const TABLE_NAME = "options_values";

    static function get_by_id($id, $selected_fields = "id, title, parent, id_options")
    {
        $c = new self();
        $c->setFilter(array("id" => $id))->setSelectFields($selected_fields)->get();
        if (count($c->result)) {
            return $c->result[0];
        }
        return false;
    }

    static function get_path_root($id, $selected_fields = "id, title, parent, id_options")
    {
        $result = array();
        $index_err = 0;
        while ($parent = self::get_by_id($id, $selected_fields)) {
            $result[] = $parent;
            $id = $parent['parent'];
            if ($index_err++ > 100) { /* предотвращаем потенциальное бесконечное зацикливание */
                return $result;
            }
        }

        return $result;
    }

    static function get_id_by_name_or_create($id_options, $value)
    {
        $obj = new self;
        $filter = array("id_options" => $id_options, "title" => $value);
        if ($obj->setFilter($filter)->col() == 0) {
            return $obj->insert_local_table($filter);
        } else {
            $obj->setSelectFields("id")->get();
            return $obj->result[0]['id'];
        }
    }
}
