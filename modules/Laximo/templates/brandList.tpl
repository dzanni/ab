{foreach from=$brandList item=data} 
	<a href="?sr=1&type=catalog&c={$data.code}{if $data.features.wizardsearch2}&spi2=t{/if}&ssd=">{$data.brand}</a>
{/foreach}