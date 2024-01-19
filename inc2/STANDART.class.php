<?php
class STANDART{
    static function parseCode($detailCode){
        return trim(mb_strtoupper(preg_replace("/[^а-яА-ЯA-Za-z0-9]/", "", $detailCode), "UTF-8"));
    }

    static function parseSearch($txt){
        return mb_ereg_replace("[^Ёё\-\.\,А-Яа-я A-Za-z]","", $txt);
    }
}