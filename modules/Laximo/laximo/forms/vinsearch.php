<?php

echo '<h1>'.CommonExtender::LocalizeString('SearchByVIN').'</h1>';

include('guayaquillib'.DIRECTORY_SEPARATOR.'render'.DIRECTORY_SEPARATOR.'catalog'.DIRECTORY_SEPARATOR.'vinsearchform.php');

class VinSearchExtender extends CommonExtender
{
    function FormatLink($type, $dataItem, $catalog, $renderer)
    {  
		return '/Poisk-po-VIN/?vin=$vin$&c='.$catalog.'&ssd=&ft=findByVIN&sr=1&type=vehicles'; 
    }   
}

$renderer = new GuayaquilVinSearchForm(new VinSearchExtender());
echo $renderer->Draw(array_key_exists('c', $_GET) ? $_GET['c'] : '', $cataloginfo, @$formvin);

echo '<br><br>';

?>


