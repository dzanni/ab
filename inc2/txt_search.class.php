<?php
class txt_search{
    static function clearText($text) {
        $stemmer = new LinguaStemRu();
        $text = preg_replace("/[^\w\x7F-\xFF\s]/"," ",strip_tags($text));
        $text = explode(' ',$text);
        foreach ($text as $word) {
            $min_word=$stemmer->stem_word($word);
            $word_array[]=$min_word;
        }     ;
        $txt = str_replace(' R N',' ', mb_strtoupper(implode(' ',$word_array),"UTF-8"));
        return self::unique_words(self::remove_words($txt));
    }

    static function remove_words($txt){
        $txt = " $txt ";
        $txt = str_replace("/", " ", $txt);
        $array = array("НАСТОЯ","ВРЕМ", "-","ГОД","ВЫПУСК");
        foreach($array as $a){
            $txt = str_replace(" $a ", " ", $txt);
        }
        return trim($txt);
    }

    static function unique_words($txt){
        return implode(" ", array_unique(explode(" ", $txt)));
    }
}