<?php
//ini_set('display_errors', 1);
//error_reporting(E_ALL);

class Config {
    public static $ui_localization = 'ru'; // ru or en
    public static $catalog_data = 'ru_RU'; // en_GB or ru_RU

    public static $useLoginAuthorizationMethod = true;

    // login/key from laximo.ru
    public static $userLogin = "";
    public static $userKey = '';

    //public static $redirectUrl = '/search-code/?beginSearch=1&detailCode=$oem$';
    public static $redirectUrl = '/Poisk/?search=$oem$&beginSearch=Найти&by=article';

}
