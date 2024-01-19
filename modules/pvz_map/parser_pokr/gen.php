<?php
require("../../../start.php");
require_once(dirname(__FILE__) . "/phpQuery.php");

/*parse();
exit();*/

$arr = json_decode(file_get_contents("pokr_parsed.json"),true);

$arrContextOptions = array(
    "ssl" => array(
        "verify_peer" => false,
        "verify_peer_name" => false,
    ),
);

foreach ($arr as $item) {
    $deliver = new dbl_deliver();
    $filter = array("id"=>$item['ID']);

    /*[ID] => 508
            [LAT] => 59.802024
            [LON] => 30.633741
            [TEXT] =>
            [href] => /contacts/stores/508/
            [title] => Свердлова поселок, (на парковке магазина Пятерочка)
            [metro] => Ломоносовская
            [schedule] => 24 часа без выходных
            [phone] => 8 (931) 320-66-53
            [desc] => text
            [img] => /upload/resize_cache/iblock/814/210_143_2/8140d75ec58893cf1700403203cb6bb6.jpg
            [img_big] => /upload/iblock/814/8140d75ec58893cf1700403203cb6bb6.jpg
    */

    if (!$deliver->setFilter($filter)->col()){
        $img = $item['img'];
        $new_file = dirname(__FILE__)."/../../../downloads/pvz/".$item['ID'].".jpg";
        $res = copy('https://xn--h1ak5ao.xn--h1adanbfj8dvaf.xn--p1ai'.$img, $new_file, stream_context_create($arrContextOptions));
        if (!$res) {
            echo "<span style='color:red'>$img - не удалось скопировать</span><br>";
            exit();
        }
        $img = $item['img_big'];
        $new_file = dirname(__FILE__)."/../../../downloads/pvz/".$item['ID']."_big.jpg";
        $res = copy('https://xn--h1ak5ao.xn--h1adanbfj8dvaf.xn--p1ai'.$img, $new_file, stream_context_create($arrContextOptions));
        if (!$res) {
            echo "<span style='color:red'>$img - не удалось скопировать</span><br>";
            exit();
        }

        $add = array(
            "id" => $item['ID'],
            "name" => $item['title'],
            "metroStations" => $item['metro'],
            "geo" => $item['LAT'].",".$item['LON'],
            "workhours" => $item['schedule'],
            "tel" => $item['phone'],
            "prim" => $item['desc'],
        );
        $deliver->insert_local_table($add);
    }
}



exit();

function parse(){
    $arr = json_decode(file_get_contents("pokr_json.json"),true);
    $arr = $arr['t'];
    foreach ($arr as &$item) {
        $pq = phpQuery::newDocument($item['TEXT']);

        $item['href'] = $pq->find(".dark-color")->attr("href");
        $item['title'] = $pq->find(".dark-color")->text();
        $item['metro'] = $pq->find(".metro")->text();
        $item['schedule'] = "24 часа без выходных";
        $item['phone'] = trim(str_replace("☎","", $pq->find(".phone")->text()));

        $item['TEXT'] = '';

        $base_url = 'https://xn--h1ak5ao.xn--h1adanbfj8dvaf.xn--p1ai'.$item['href'];
        $data_page = send($base_url);
        $pq = phpQuery::newDocument($data_page);
        $item['desc'] = strip_tags($pq->find(".description")->html(),"<h1><h2><h3><h4><div><li><ol><ul><br><p>");
        $item['img'] = $pq->find(".detail .fancy img")->attr("src");
        $item['img_big'] = $pq->find(".detail .fancy")->attr("href");

    }
    file_put_contents("pokr_parsed.json",json_encode($arr, JSON_UNESCAPED_UNICODE));

    debug::d($arr);
}


function send($url) {
    $ch = curl_init($url);
    curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
    //curl_setopt($ch, CURLOPT_FOLLOWLOCATION, 1);
    curl_setopt($ch, CURLOPT_HEADER, 0);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
    return curl_exec($ch);
}