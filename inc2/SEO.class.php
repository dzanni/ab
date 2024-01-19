<?php
class SEO{
    protected static $_instance;
    public $title;
    public $keywords;
    public $description;
    public $H1;

    public function __construct(ROUTE $ROUTE)
    {
        if ($ROUTE->mainModule) // SEO PARAMS insert inside the module
            return false;
        if ($ROUTE->category >= 0){
            $category = new dbl_category();
            $category->setSelectFields("title,keywords,description,pageTitle,H1");
            $category->setFilter(array("id"=>$ROUTE->category))->get();

            $this->title = $category->result[0]['pageTitle'];
            $this->keywords = $category->result[0]['keywords'];
            $this->description = $category->result[0]['description'];
            $this->H1 = $category->result[0]['H1'];
            if ($this->H1 == ''){
                $this->H1 = $category->result[0]['title'];
            }
        }
    }

    public static function getInstance (ROUTE $ROUTE){
        if (self::$_instance === null) {
            self::$_instance = new self($ROUTE);
        }

        return self::$_instance;
    }
    private function __clone() {
    }

    private function __wakeup() {
    }
}