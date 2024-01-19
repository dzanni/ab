<?php
class db_lib extends PDO{
    const TABLE_NAME = "";
    private $filter = "";
    private $SQL_params = array("select_fields"=>"","join_tables"=>"","join_tables_where_condition"=>"");
    private $params = array();
    private $paramsSQL = array();
    private $orderBy = array("id");
    protected $start = 0;
    protected $page = 1;
    protected $colOnPage = 20;
    public $result;
    public $debug;
    public $error;
    public $errorInfo;
    private $SQL;
    public $SQL_debug;
    protected $col;
    protected $db;
    protected $tableName = "";
    private $sql_filter_add = "";
    private $security_filter = "";
    private $security_params = array();
    private $security_paramsSQL = array();
    private $groupBy = '';
    private $having = '';
    public $user_filter;

    function __construct($dbh = 0) {
        if($dbh == 0){
            $this->db = DB::getInstance();
        }else{
            $this->db = $dbh;
        }

    }

    public function getById($id){
        $this->setFilter(array("id"=>$id))->get();
        if (count($this->result)){
            return $this->result[0];
        }else{
            return array();
        }
    }

    public function setTableName($tableName){
        $this->tableName = $tableName;
        return $this;
    }

    public function setGroupBy($group_by){
        $this->groupBy = $group_by;
        return $this;
    }
    public function setHaving($having){
        $this->having = $having;
        return $this;
    }

    private function getTableName(){
        if ($this->tableName <> ""){
            return $this->tableName;
        }else{
            return static::TABLE_NAME;
        }
    }

    public function setSecurityFilter($filter){
        $filterParsed = self::parseFilter($filter);
        $this->security_filter = $filterParsed['query'];
        $this->security_params = $filterParsed['params'];
        $this->security_paramsSQL = $filterParsed['paramsSQL'];
        return $this;
    }
    public function setFilter($filter){
        $this->user_filter = $filter;
        /* EXAMPLE
         * $filter = array(
            "<id"=>"23",
            "LIKE=title"=>"%es%",
            "!IN=id"=>"1,2,3,4",
            array(
                "LOGIC" => "OR",
                ">id"=>"0",
                "IN=title"=>"'test1','test2'"
            )
        );*/

        $filterParsed = self::parseFilter($filter);

        $this->filter = $filterParsed['query'];
        $this->params = $filterParsed['params'];
        $this->paramsSQL = $filterParsed['paramsSQL'];
        return $this;
    }

    private function getOrderAndLimit(){
        $res = "";
        if (count($this->orderBy) > 0){
            $res.= " ORDER BY ".implode(",",$this->orderBy);
        }
        if ($this->start !== null && $this->colOnPage !== null){
            $res.= " LIMIT $this->start, $this->colOnPage";
        }
        return $res;
    }

    private function getGroupBy(){
        if ($this->groupBy){
            return " GROUP BY $this->groupBy";
        }
    }

    private function getHaving(){
        if ($this->having){
            return " HAVING $this->having ";
        }
    }

    public function setOrderBy($orderBy = array()){
        for($i=0;$i<count($orderBy);$i++){
            $str = str_replace(" DESC","",$orderBy[$i]);
            if ($str <> $orderBy[$i]){
                $orderBy[$i] = self::preg_field($str)." DESC";
            }else{
                $orderBy[$i] = self::preg_field($orderBy[$i]);
            }
        }
        $this->orderBy = $orderBy;
        return $this;
    }

    public function setLimit($start,$colOnPage){
        $this->start = preg_replace("/[^0-9]/","",$start);
        $this->colOnPage = preg_replace("/[^0-9]/","",$colOnPage);
        return $this;
    }
    public function setCol($colOnPage){
        $this->colOnPage = preg_replace("/[^0-9]/","",$colOnPage);
        return $this;
    }

    public function setPage($page){
        $page = preg_replace("/[^0-9]/","",$page);
        $this->page = $page;
        $this->start = ($this->page-1)*$this->colOnPage;
        return $this;
    }

    public function getPage(){
        return $this->page;
    }

    public function getPagesCol(){
        if ($this->col === null){
            $this->col();
        }
        if ($this->col > 0){
            return ceil($this->col/$this->colOnPage);
        }else{
            return 0;
        }
    }

    public function getPagesArr($current="default", $skip = false){
        /**
         * @var int $skip если задано, то покажет столько страниц до и столько после текущей
         */
        if ($current == "default") $current = $this->page;
        $pages = array();
        $show = true;
        $showLatest = true;

        $colPages = $this->getPagesCol();
        for($i=0;$i<$colPages;$i++){
            $page = $i+1;
            if ($skip > 0){
                if ($page > 1 && $page < $colPages && ($page > $current+$skip || $page < $current-$skip)){
                    $show = false;
                }else{
                    $show = true;
                }
            }
            if ($show){
                if ($showLatest <> $show){
                    $pages[] = array("page"=>"...","active"=>false,"skip"=>true);
                }
                $pages[] = array("page"=>$page,"active"=>$page==$current?true:false);
            }
            $showLatest = $show;
        }
        return $pages;
    }

    public function set_SQL_filter($SQL){
        $this->sql_filter_add = $SQL;
        return $this;
    }
    public function get_SQL_filter(){
        return $this->sql_filter_add;
    }

    private function getSQL_Filter(){
        $filter_join = $this->getSQL_join_tables_where_condition();
        $sql = array($filter_join, $this->filter, $this->security_filter, $this->sql_filter_add);
        $q = array();
        foreach ($sql as $s){
            if ($s <> "") $q[] = " $s ";
        }
        $sql = implode(" AND ", $q);
        if (trim($sql) <> ""){
            return " WHERE $sql ";
        }else{
            return '';
        }
           /* $AND = "";
        if ($filter_join <> "" AND $this->filter <> "" ){
            $AND = " AND ";
        }
        if ($filter_join.$AND.$this->filter <> ""){
            return " WHERE $filter_join $AND $this->filter ";
        }
        return "";*/
    }

    public function getSQL_debug(){

    }

    public function setTableJoin( $join_tables, $join_tables_where_condition){
        $this->SQL_params["join_tables"] = $join_tables;
        $this->SQL_params["join_tables_where_condition"] = $join_tables_where_condition;
        return $this;
    }

    public function setSelectFields( $select_fields){
        $this->SQL_params["select_fields"] = $select_fields;
        return $this;
    }

    public function removeJoin(){
        $this->SQL_params["join_tables"] = "";
        $this->SQL_params["join_tables_where_condition"] = "";
        return $this;
    }
    public function removeSelectFields(){
        $this->SQL_params["select_fields"] = "";
        return $this;
    }

    private function getSQL_tables(){
        if ($this->SQL_params['join_tables'] == ""){
            return $this->getTableName();
        }else{
            return $this->SQL_params['join_tables'];
        }
    }

    private function getSQL_select_fields(){
        if ($this->SQL_params['select_fields'] == ""){
            return $this->getTableName().".*";
        }else{
            return $this->SQL_params['select_fields'];
        }
    }

    private function getSQL_join_tables_where_condition(){
        if ($this->SQL_params['join_tables_where_condition'] == ""){
            return "";
        }else{
            return $this->SQL_params['join_tables_where_condition'];
        }
    }

    // SELECT tovar.id, tovar2.* FROM tovar LEFT JOIN tovar2 ON t1.id = t2.tovar
    public function get(){

        $this->SQL = "SELECT ".$this->getSQL_select_fields()." FROM ".$this->getSQL_tables()." ".$this->getSQL_Filter().$this->getGroupBy().$this->getHaving().$this->getOrderAndLimit();

       // exit($this->SQL);
        $stml = $this->db->prepare($this->SQL);
        $this->SQL_debug = $this->getRealSQL();


        if ($stml->execute(array_merge($this->params, $this->security_params))){
            $this->result = $stml->fetchAll(PDO::FETCH_ASSOC);
            $this->error = 0;
            $this->errorInfo = "";
            return true;
        }else{
            $this->errorInfo = $stml->errorInfo();
            print_r($this->errorInfo);
            $this->error = 1;
            $this->result = 0;
            return false;
        }
    }

    public function col(){

        if ($this->groupBy){
            $this->SQL = "SELECT count(DISTINCT ".$this->getTableName().".$this->groupBy) AS col FROM ".$this->getSQL_tables()." ".$this->getSQL_Filter();
        }else{
            $this->SQL = "SELECT count(".$this->getTableName().".id) AS col FROM ".$this->getSQL_tables()." ".$this->getSQL_Filter();
        }

        $stml = $this->db->prepare($this->SQL);
        $this->SQL_debug = $this->getRealSQL();


        $this->result = "";
        if ($stml->execute(array_merge($this->params, $this->security_params))){
            $data = $stml->fetchAll(PDO::FETCH_ASSOC);
            $this->col = $data[0]['col'];
            $this->error = 0;
            $this->errorInfo = "";
            return $this->col;
        }else{
            $this->errorInfo = $stml->errorInfo();
            $this->error = 1;
            return -1;
        }
    }

    public function chg( $values = array()){

        $params = array();
        $paramsSQL = array();
        foreach($values AS $key => $value){
            $params[] = $value;
            $paramsSQL[] = self::preg_field($key)." = ?";
        }
        if (count($params)){
            $paramsSQL = implode(",", $paramsSQL);

            $this->SQL = "UPDATE ".$this->getTableName()." SET $paramsSQL ".$this->getSQL_Filter();
            for($i=0;$i<count($this->params);$i++){
                $params[] = $this->params[$i];
            }
            for($i=0;$i<count($this->security_params);$i++){
                $params[] = $this->security_params[$i];
            }

            $stml = $this->db->prepare($this->SQL);
            $this->SQL_debug = "not supporting";

            //echo '<pre>';print_r($params);exit();
            if ($stml->execute($params)){
                $this->result = $stml->rowCount();
                $this->error = 0;
                $this->errorInfo = "";
                return true;
            }else{
                $this->errorInfo = $stml->errorInfo();
                print_r($this->errorInfo);
                $this->error = 1;
                $this->result = 0;
                return false;
            }
        }
    }

    private function getRealSQL(){
        $q = $this->SQL;
        $res = "";
        $q = explode("?", $q);
        for($i=0;$i<count($q);$i++){
            $res.=$q[$i].$this->paramsSQL[$i]." ";
        }
        return $res;
    }

    static function parseFilter($filter){
        $operand = "AND";
        $query = array();
        $params = array();
        $paramsSQL = array();

        if (count($filter)){
            foreach ($filter as $key => $value){
                if (is_array($value)){
                    $tmp = self::parseFilter($value);
                    for($i=0;$i<count($tmp['params']);$i++){
                        $params[] = $tmp['params'][$i];
                        $paramsSQL[] = $tmp['paramsSQL'][$i];
                    }
                    $query[] = "(".$tmp['query'].")";
                }else {
                    if ($key == "LOGIC") {
                        $operand = $value;
                    } else {
                        $quote = false;
                        $addParam = true;
                        $parseFieldGetLogic = self::parseFieldGetLogic($key);
                        $field = self::preg_field($parseFieldGetLogic['field']);
                        if ($parseFieldGetLogic['logic'] == "IN" || $parseFieldGetLogic['logic'] == "NOT IN") {
                            $query[] = "$field " . $parseFieldGetLogic['logic'] . " ($value)";
                            $addParam = false;
                        } elseif($parseFieldGetLogic['logic'] == "MATCH"){
                            $query[] = $value;
                            $addParam = false;
                        } else {
                            $query[] = "$field " . $parseFieldGetLogic['logic'] . " ?";
                            if (!is_numeric($value)) {
                                $quote = true;
                            }
                        }
                        if($addParam){
                            if ($quote){
                                $paramsSQL[] = "'".$value."'";
                            }else{
                                $paramsSQL[] = $value;
                            }
                            $params[] = $value;
                        }
                    }
                }
            }
        }
        $query = implode(" ".$operand." ",$query);
        return array("query"=>$query,"params"=>$params,"paramsSQL"=>$paramsSQL);
    }
    static function parseFieldGetLogic($field){
        $logic = self::getLogicVariants();
        foreach($logic as $key => $value){
            $tmpName = preg_replace("/^$key/","",$field);
            if ($tmpName <> $field){
                return array("field" => $tmpName, "logic" => $value);
            }
        }
        return array("field" => $field, "logic" => "=");
    }
    static function getLogicVariants(){
        return array(
            "!=" => "!=",
            "LIKE=" => "LIKE",
            "IN=" => "IN",
            "!LIKE=" => "NOT LIKE",
            "!IN=" => "NOT IN",
            ">=" => ">=",
            "<=" => "<=",
            ">" => ">",
            "<" => "<",
            "MATCH=" => "MATCH",
        );
    }

    public function insert_local_table($values = array())
    {
        $dbh = DB::getInstance();

        $params = array();
        $paramsSQL = array();
        $paramsSQL2 = array();
        foreach ($values as $key => $value) {
            $params[] = $value;
            $paramsSQL[] = self::preg_field($key);
            $paramsSQL2[] = "?";
        }
        if (count($params)){
            $paramsSQL = implode(",", $paramsSQL);
            $paramsSQL2 = implode(",", $paramsSQL2);
            //echo "<pre>";print_r($params);exit();
            //exit("INSERT INTO ".static::TABLE_NAME." ($paramsSQL) VALUES ($paramsSQL2)");
            $stml = $dbh->prepare("INSERT INTO ".$this->getTableName()." ($paramsSQL) VALUES ($paramsSQL2)");

            if ($stml->execute($params)){
                return $dbh->lastInsertId();
            }else{
                print_r($stml->errorInfo());
            }
        }
        return false;
    }

    static function insert($values = array())
    {
        $dbh = DB::getInstance();

        $params = array();
        $paramsSQL = array();
        $paramsSQL2 = array();
        foreach ($values as $key => $value) {
            $params[] = $value;
            $paramsSQL[] = self::preg_field($key);
            $paramsSQL2[] = "?";
        }
        if (count($params)){
            $paramsSQL = implode(",", $paramsSQL);
            $paramsSQL2 = implode(",", $paramsSQL2);
            //echo "<pre>";print_r($params);exit();
            //exit("INSERT INTO ".static::TABLE_NAME." ($paramsSQL) VALUES ($paramsSQL2)");
            $stml = $dbh->prepare("INSERT INTO ".static::TABLE_NAME." ($paramsSQL) VALUES ($paramsSQL2)");

            if ($stml->execute($params)){
                return $dbh->lastInsertId();
            }else{
                print_r($stml->errorInfo());
            }
        }
        return false;
    }

	static function chg_by_id( $values = array(), $id)
    {
        $dbh = DB::getInstance();

        $params = array();
        $paramsSQL = array();
        foreach($values AS $key => $value){
            $params[] = $value;
            $paramsSQL[] = self::preg_field($key)." = ?";
        }
        if (count($params)){
            $paramsSQL = implode(",", $paramsSQL);
            $params[] = $id;
            $stml = $dbh->prepare("UPDATE ".static::TABLE_NAME." SET $paramsSQL WHERE id = ?");
            if ($stml->execute($params)){
                return true;
            }
        }
        return false;
    }

    public function delete() {
        $this->SQL = "DELETE FROM ".$this->getTableName().$this->getSQL_Filter();
        $stml = $this->db->prepare($this->SQL);
        $params = array();
        for($i=0;$i<count($this->params);$i++){
            $params[] = $this->params[$i];
        }
        for($i=0;$i<count($this->security_params);$i++){
            $params[] = $this->security_params[$i];
        }
        $this->SQL_debug = "not supporting";
        if ($stml->execute($params)){
            $this->result = $stml->rowCount();
            $this->error = 0;
            $this->errorInfo = "";
            return true;
        }else{
            $this->errorInfo = $stml->errorInfo();
            print_r($this->errorInfo);
            $this->error = 1;
            $this->result = 0;
            return false;
        }
    }

    static function delete_by_id($id)
{
    $dbh = DB::getInstance();
    $stml = $dbh->prepare("DELETE FROM ".static::TABLE_NAME." WHERE id = ?");
    if ($stml->execute(array($id))){
        return 1;
    }
    return false;
}

    static function preg_field($field){
        $test = str_replace("NOPARSE_","",$field);
        if ($test != $field){
            return $test;
        }
	    return preg_replace("/[^0-9a-zA-Z\-_\.]/","",$field);
    }

    static function get_field_by_table_and_id($table, $field, $id)
    {
        $dbh = DB::getInstance();
        $stml = $dbh->prepare("SELECT $field FROM $table WHERE id = ?");
        if ($stml->execute(array($id))){
            $data = $stml->fetchAll(PDO::FETCH_ASSOC);
            return $data[0][$field];
        }
        return "Не указана";
    }
}
