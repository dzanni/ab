<?php
// Include soap request class
require_once('guayaquillib/data/requestOem.php');
require_once('extender.php');

// Create request object
$request = new GuayaquilRequestOEM($_GET['c'], $_GET['ssd'], Config::$catalog_data);
if (Config::$useLoginAuthorizationMethod) {
    $request->setUserAuthorizationMethod(Config::$userLogin, Config::$userKey);
}

// Append commands to request
$request->appendGetCatalogInfo();
if (@$_GET['spi2'] == 't')
    $request->appendGetWizard2();

// Execute request
$data = $request->query();

// Check errors
if ($request->error != '') {
    echo $request->error;
} else {
    $cataloginfo = $data[0]->row;

    foreach ($cataloginfo->features->feature as $feature) {
        switch ((string)$feature['name']) {
            case 'vinsearch':
                include('forms/vinsearch.php');
                break;
            case 'framesearch':
                $formframe = $formframeno = '';
                include('forms/framesearch.php');
                break;
            case 'wizardsearch2':
                $wizard = $data[1];
                include('forms/wizardsearch2.php');
                break;
        }
    }

    if ($cataloginfo->extensions->operations) {
        foreach ($cataloginfo->extensions->operations->operation as $operation) {
            if ($operation['kind'] == 'search_vehicle') {
                include('forms/operation.php');
            }
        }
    }
}
?> 
