<?php
require_once(dirname(__FILE__)."/../core/cs_syn_index_search/inc/cs_syn_index_search.class.php");

class catalog_search_txt extends catalog {

    const TABLE_NAME = "tovar";
    private $search; // поисковый запрос
    private $search_syn; // массив запросов для текстового поиска, с учетом синонимов
    private $search_art; // поисковый запрос (номер ЗЧ)
    private $syn;    // синонимы поиска
    private $search_result_sql; // Массив результирующего SQL который потом будет объединяться UNION
    private $SQL_search;

    function __construct($dbh = 0) {
        parent::__construct($dbh);

        $cs_syn_index_search = new cs_syn_index_search();
        $cs_syn_index_search->setCol(1000);
        $cs_syn_index_search->get();
        $this->syn = $cs_syn_index_search->result;
    }

    private function protect($txtCode){
        $txtCode=  str_replace("SELECT", "", $txtCode);
        $txtCode= str_replace("DELETE", "", $txtCode);
        $txtCode= str_replace("INSERT", "", $txtCode);
        return $txtCode;
    }

    public function search($search){


        $this->search = mb_strtolower($this->protect($search));
        $this->search_art = codeSearch::parseCode($search);
        $this->set_syn();

        /* поиск по номеру зч (чистый) */
        if ($this->search_art != ''){
            $search_result_sql[] = $this->getSql("ROUND(1) AS REL"," AND tovar.artikul = '$this->search_art' ");
        }
        /* поиск по номеру 1C (чистый) */
        if ($this->search_art != ''){
            $search_result_sql[] = $this->getSql("ROUND(2) AS REL"," AND tovar.code_1c = '$this->search_art' ");
        }

        if (!(isset($_GET['by']) && $_GET['by'] == "article")) {

            /* поиск по наименованию в т.ч. по синонимам (чистые вхождения в начале строки) */
            $arr = array();
            foreach ($this->search_syn as $item) {
                $arr[] = "tovar.title LIKE '" . $item . " %'";
                /* отдельностоящее слово важно*/
            }
            $search_result_sql[] = $this->getSql("ROUND(4) AS REL", " AND (" . implode(" OR ", $arr) . ")   AND 
		tovar.active > 0 ");

            /* поиск по наименованию в т.ч. по синонимам (чистые вхождения в середине текста и в конце строки) */
            $arr = array();

            foreach ($this->search_syn as $item) {
                $arr[] = "tovar.title LIKE '% " . $item . " %' OR  
                tovar.title LIKE '% " . $item . "' 
            ";
                /* отдельностоящее слово важно*/
            }
            $search_result_sql[] = $this->getSql("ROUND(5) AS REL", " AND (" . implode(" OR ", $arr) . ")  AND 
				tovar.active > 0 ");

        }

        /* поиск по частичному соответствию фразы или номера зч */

        if ($this->search_art != '') {
            $arr = array("tovar.artikul LIKE '%" . $this->search_art . "%'");
        }

        if (!(isset($_GET['by']) && $_GET['by'] == "article")) {

            foreach ($this->search_syn as $item) {
                $arr[] = "tovar.title LIKE '%" . $item . "%' ";
                /* отдельностоящее слово важно*/
            }

        }
        $search_result_sql[] = $this->getSql("ROUND(6) AS REL"," AND (".implode(" OR ", $arr).")   AND 
		
		tovar.active > 0 ");

        if (!(isset($_GET['by']) && $_GET['by'] == "article")) {
            /* фразовый полнотекстовый поиск*/
            $searchTxtAgainst = txt_search::clearText($this->search);
            $searchWord = "+" . str_replace(" ", " +", $searchTxtAgainst);

            $search_result_sql[] = $this->getSql("ROUND(7) AS REL", " AND (
                (MATCH (`TXT_INDX`) AGAINST ('$searchWord' IN BOOLEAN MODE))
                )  AND 
		
		tovar.active > 0 ");
        }



        $this->SQL_search = (implode("
         UNION 
         ", $search_result_sql)  );


        return $this->col();
    }

    public function get(){
        $stml = $this->db->prepare("SELECT * FROM ($this->SQL_search ) Q1 
   GROUP BY Q1.id ORDER BY Q1.REL, Q1.price
LIMIT $this->start, $this->colOnPage");

        $stml->execute();
        $this->parse_get_result($stml->fetchAll(PDO::FETCH_ASSOC));
        return 1;
    }

    public function col(){
        if ($this->col) return $this->col;
        $stml = $this->db->prepare("SELECT count(DISTINCT(Q1.id)) as COL FROM ($this->SQL_search ) Q1");
        $stml->execute();
        $this->col = $stml->fetchAll(PDO::FETCH_ASSOC);
        $this->col = $this->col[0]['COL'];
        return $this->col;
    }
    private function getSql($REL, $ADD_SQL){
        // SEE in __construct catalog.class.php and copy logic if change

        $SQL_FILTER = $this->get_SQL_filter();
        if ($SQL_FILTER != ''){
            $SQL_FILTER = " AND $SQL_FILTER ";
        }

        return "SELECT $REL, tovar.*, firm.title AS fName, sellers.title AS sTitle
	FROM
		tovar, firm, sellers
	WHERE
		tovar.firm = firm.id AND tovar.sellers = sellers.id $SQL_FILTER
		$ADD_SQL ";
    }

    private function set_syn(){
        $this->search_syn = array($this->search);
        foreach ($this->syn as $syns) {
            $syns_arr = explode("~", $syns['syns']);
            foreach ($syns_arr as $word) {
                $word_lwr = mb_strtolower($word);
                $word_slashed_lwr = addslashes($word_lwr);
                $word_slashed_lwr = str_replace("/", "\/", $word_slashed_lwr);
                $preg_arr = array(
                    "/^" . $word_slashed_lwr . " /",
                    "/ " . $word_slashed_lwr . " /",
                    "/ " . $word_slashed_lwr . "$/",
                    "/^" . $word_slashed_lwr . "$/",
                );
                $tmp = preg_replace($preg_arr, "", $this->search);

                if ($tmp !== $this->search) {
                    foreach ($syns_arr as $add) {
                        if ($add != $word && $add!=''){
                            $this->search_syn[] = $add." ".$tmp;
                        }
                    }
                    break;
                }
            }
        }
    }
}