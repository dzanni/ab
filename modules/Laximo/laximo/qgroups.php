﻿<?php

// Include soap request class
include('guayaquillib'.DIRECTORY_SEPARATOR.'data'.DIRECTORY_SEPARATOR.'requestOem.php');
// Include view class
include('guayaquillib'.DIRECTORY_SEPARATOR.'render'.DIRECTORY_SEPARATOR.'qgroups'.DIRECTORY_SEPARATOR.'default.php');
// Include view class
include('extender.php');

class QuickGroupsExtender extends CommonExtender
{
    function FormatLink($type, $dataItem, $catalog, $renderer)
    {
        if ($type == 'vehicle')
            $link = "?".'sr=1&type=vehicle&c='.$catalog.'&vid='.$renderer->vehicleid. '&ssd=' . $renderer->ssd;
        else
            $link = "?".'sr=1&type=qdetails&c='.$catalog.'&gid='.$dataItem['quickgroupid']. '&vid=' . $renderer->vehicleid. '&ssd=' . $renderer->ssd;

        return $link;
    }
}

// Create request object
$request = new GuayaquilRequestOEM($_GET['c'], $_GET['ssd'], Config::$catalog_data);
if (Config::$useLoginAuthorizationMethod) {
    $request->setUserAuthorizationMethod(Config::$userLogin, Config::$userKey);
}

// Append commands to request
$request->appendGetVehicleInfo($_GET['vid']);
$request->appendListQuickGroup($_GET['vid']);

// Execute request
$data = $request->query();

// Check errors
if ($request->error != '')
{
    echo $request->error;
}
else
{
		$vehicle = $data[0]->row;
        $groups= $data[1];

		echo '<h1>'.CommonExtender::FormatLocalizedString('CarName', $vehicle['name']).'</h1>';

		echo '<div id="pagecontent">';

        $renderer = new GuayaquilQuickGroupsList(new QuickGroupsExtender());
        echo $renderer->Draw($groups, $_GET['c'], $_GET['vid'], $_GET['ssd']);

	  echo '</div>';
}
?>