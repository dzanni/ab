<?php
echo '<h1>'.CommonExtender::LocalizeString('Search by wizard').'</h1>';

include('guayaquillib'.DIRECTORY_SEPARATOR.'render'.DIRECTORY_SEPARATOR.'wizard2'.DIRECTORY_SEPARATOR.'wizard.php');

class WizardExtender extends CommonExtender
{
    function FormatLink($type, $dataItem, $catalog, $renderer)
    {
        if ($type == 'vehicles') {
			return "?".'sr=1&type=vehicles&ft=findByWizard2&c='.$catalog.'&ssd='.$renderer->wizard->row['ssd'];
            //return 'vehicles.php?ft=findByWizard2&c='.$catalog.'&ssd='.$renderer->wizard->row['ssd'];
		}else
			return "?".'sr=1&type=wizard2&c='.$catalog.'&ssd=$ssd$';
            //return 'wizard2.php?c='.$catalog.'&ssd=$ssd$';
    }
}

class GuayaquilWizard2 extends GuayaquilWizard
{
	function DrawConditionDescription($catalog, $condition)
	{
		return '';
	}

	function DrawVehiclesListLink($catalog, $wizard)
	{
		return '';
	}
}

$renderer = new GuayaquilWizard2(new WizardExtender());
echo $renderer->Draw($_GET['c'], $wizard);

echo '<br><br>';

?>

