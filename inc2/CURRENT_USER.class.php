<?php
class CURRENT_USER{
    protected static $_instance;

    public $auth = false;
    public $auth_result = false;
    public $id;
    public $login;
    public $status;
    public $role;
    public $price_group;
    public $limit_otgruzki;
    public $kredit;
    public $nacenka;
    public $data;
    public $users;
    public $tel;
    public $name;
    public $role_GAK;
    public $GAK_region;
    public $balance;
    public $token;
    private $dbl_users;
    public $LB_edit_on_page;

    function __construct(){
        $this->get_user_auth_and_login();
        $this->mk_visit_score();
    }
    public static function getInstance() {
        if (self::$_instance === null) {
            self::$_instance = new self;
        }

        return self::$_instance;
    }
    private function __clone() {
    }

    private function __wakeup() {
    }

    private function referals(){
        if (isset($_GET['u_from'])){
            setcookie('u_from', $_GET['u_from'], time()+150*864000,"/");  /* срок действия 150 дней */
        }
    }

    private function mk_visit_score(){
        if ($this->id){
            if (!isset($_COOKIE['last_add'])){
                setcookie('last_add', time(), time()+864000,"/");  /* срок действия 1 день */
                dbl_score::add_score($this->id, "visit");
            }
        }
    }

    private function get_user_auth_and_login(){
        $this->referals();

        if (isset($_GET['exit_from_lk'])){
            unset($_SESSION['token']);
            unset($_SESSION['user']);
            unset($_SESSION['role']);
            setcookie('token', '', time()-50000,"/");
            return false;
        }
        if (!isset($_COOKIE['token']) && isset($_SESSION['token'])){
            setcookie('token', $_SESSION['token'], time()+150*864000,"/");  /* срок действия 150 дней */
        }elseif(isset($_COOKIE['token']) && isset($_SESSION['token']) && $_COOKIE['token'] <> $_SESSION['token']){
            setcookie('token', $_SESSION['token'], time()+150*864000,"/");  /* срок действия 150 дней */
        }elseif(isset($_COOKIE['token']) && !isset($_SESSION['token'])){
            $_SESSION['token'] = $_COOKIE['token'];
        }

        if (isset($_POST['mk_auth_init'])){
            return $this->Auth($_POST['login'],$_POST['pwd']);
        }elseif (isset($_SESSION['token'])){
            return $this->getByToken($_SESSION['token']);
        }
        return false;
    }

    private function setData(){
        foreach ($this->dbl_users->result[0] as $k => $v){
            if ($k == "data_json"){
                $this->data = json_decode($v, true);
            }else{
                $this->$k = $v;
            }
        }
        $u = new dbl_users();
        $u->setFilter(array("id"=>$this->id))->chg(array("last_activity"=>date("Y-m-d H:i:s")));
    }

    public function Auth($login, $pass, $use_capcha = true){
        if ($use_capcha && !recapcha_check::check()){
            $this->auth_result = 'Код капчи не прошёл проверку на сервере';
            return false;
        }

        $this->auth_result = 'Ошибка авторизации: неверная пара логин-пароль';
        $this->dbl_users = new dbl_users();

        $filter = array(
            array(
                "LOGIC" => "OR",
                "login"=>$login,
                "tel"=>"$login",
            )
        );

        // Переменную $filter вставили вместо (array("login"=>$login)

        if ($this->dbl_users->setFilter($filter)->col()){

            $this->dbl_users->get();
            if (password_verify($pass, $this->dbl_users->result[0]['pwd'])){
                if ($this->dbl_users->result[0]['status'] == -1){ // Для автозагрузки -- активируем при 1 ом входе
                    $user=new dbl_users();
                    $user->setFilter(array("id"=>$this->dbl_users->result[0]['id']))->chg(array("status"=>1));
                    $this->dbl_users->result[0]['status'] = 1;
                }
                // Для Autoboss разрешили вход при статусе 0, ранее было ($this->dbl_users->result[0]['status'] > 0)
                if ($this->dbl_users->result[0]['status'] >= 0){
                    $this->auth = true;
                    $this->setData();
                    $this->auth_result = false;
                    $token = $this->dbl_users->result[0]['token'];
                    if ($token == ''){
                        $token = $this::genToken($this->dbl_users->result[0]['login'],$this->dbl_users->result[0]['id']);
                        $user=new dbl_users();
                        $user->setFilter(array("id"=>$this->dbl_users->result[0]['id']))->chg(array("token"=>$token));
                    }
                    $_SESSION['token'] = $token;
                    setcookie('token', $_SESSION['token'], time()+150*864000,"/");  /* срок действия 150 дней */
                    return true;
                }else{
                    $this->auth_result = 'Ошибка авторизации: ваша учетная запись не активна или заблокирована';
                    return false;
                }
            }
        }
        return false;
    }

    public function getByToken($token){
        $this->dbl_users = new dbl_users();
        if ($this->dbl_users->setFilter(array("token"=>$token))->col()){
            $this->dbl_users->get();
            $this->auth = true;
            $this->setData();
            $this->get_LB_edit();
            return true;
        }
        return false;
    }

    private function get_LB_edit(){
        if ($_SERVER['SCRIPT_NAME'] == "/index.php"){
            // только для страниц, которые генерятся из главного index.php и идут через всю логику.
            // чтобы не отрабатывало на вызове CURRENT_USER из других отдельностоящих файлов
            if ($this->role > 0 || $this->checkAccessLB()){
                /* менеджер или администратор или владелец страницы компании с тарифом */
                require_once(dirname(__FILE__).'/../modules/LB_edit_on_page/LB_edit_on_page.class.php');
                $this->LB_edit_on_page = new LB_edit_on_page();
            }
        }
    }

    static function genToken($login, $id){
        return md5($login.time().$id).".".$id;
    }

    public function setUserParamAndSave($param, $value){
        if (isset($this->id) && isset($this->$param)){
            $user_chg = new dbl_users();
            $user_chg->setFilter(array("id"=>$this->id))->chg(array($param=>$value));
            $this->$param = $value;
            return 1;
        }else{
            return 0;
        }
    }

    private function checkAccessLB(){
        if (ROUTE::getInstance()->firmPage){
            $firm_id  = preg_replace("/[^0-9]/", "", $_GET['firm']);

            $firm = new dbl_firm();
            $firm->setSelectFields("id")->setFilter(array("id"=>$firm_id, "users"=>$this->id, ">tarif" => 0, "tarif_block" => 0));
           if ($firm->col()){
               return true;
           }
        }
        return false;

    }

}