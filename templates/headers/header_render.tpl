{foreach from=$APP->getHeaderVariants() item=header}
    {if $header.chg}
        <div class="techno">↓ Header ВАРИАНТ {$header.id} -
            <a class="js_chg_header_and_footer {if $header.selected}choosen{/if}" data-choice="{$header.id}" data-type="HEADER">
                {if !$header.selected}Выбрать{else}ВЫБРАН{/if}
            </a>
        </div>
	{/if}
	<header class="header ver_0{$header.ver}">
	    {include file="headers/header{$header.id}.tpl"}
	</header>
{/foreach}