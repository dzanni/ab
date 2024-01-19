<?php
require("../../start.php");

$pvz = new dbl_deliver();
$filter = array("active"=>1, "group_id"=>0);

if ($pvz->setFilter($filter)->col()){
    $pvz->setCol(500)->get();
    $json = array();
    $result_features = array();
    foreach ($pvz->result as $item) {
        $item['geo'] = preg_replace("/[^0-9\.,]/",'',$item['geo']);
        if ($item['geo']){
            $geo = explode(",",$item['geo']);
            if (count($geo) == 2){

                $txt = '<div class="metro"><i>м</i> '.$item['metroStations'].'</div>
<div class="schedule">⏰ '.$item['workhours'].'</div>
<div class="phone_email">
    <div class="phone"><a rel="nofollow" href="tel:{$pvz.tel}">☎ '.$item['tel'].'</a></div>
</div>';

                $result_features[] = array(
                    "type" => "Feature",
                    "id"=> $item['id'],
                    "geometry"=> array(
                        "type"=> "Point",
                        "coordinates"=> $geo,
                    ),
                    "properties" => array(
                        "balloonContentHeader" => $item['name'],
                        "balloonContentBody" => $txt,
                        // "balloonContentFooter" => "footer",
                        "clusterCaption" => $item['name'],
                        "hintContent" => $item['name'],
                    ),
                );
            }
        }

/*
        {"type": "Feature", "id": 0, "geometry": {"type": "Point", "coordinates": [55.831903, 37.411961]},
            "properties": {"balloonContentHeader": "<font size=3><b><a target='_blank' href='https://yandex.ru'>Здесь может быть ваша ссылка</a></b></font>",
            "balloonContentBody": "<p>Ваше имя: <input name='login'></p><p><em>Телефон в формате 2xxx-xxx:</em>  <input></p><p><input type='submit' value='Отправить'></p>",
            "balloonContentFooter": "<font size=1>Информация предоставлена: </font> <strong>этим балуном</strong>",
            "clusterCaption": "<strong><s>Еще</s> одна</strong> метка",
            "hintContent": "<strong>Текст  <s>подсказки</s></strong>"}},*/

    }

    $res = array(
        "type" => "FeatureCollection",
        "features" => $result_features,
    );

    echo json_encode($res, JSON_UNESCAPED_UNICODE);
}

