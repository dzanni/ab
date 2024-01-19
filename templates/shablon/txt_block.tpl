{if $LB_edit}
    {assign var=data_lb_type_id value=$data.landing_block_type_id}
    <div class="cs_block_element" data-id="{$data.id}" data-title="{$LB_base.$data_lb_type_id}">
{/if}
{if $data.landing_block_type_id > 0}
    {assign var="block" value=$data.landing_block}
    <div id="block{$data.landing_block_type_id}"></div>
    {if $ADMIN_URL}
        {include file="{$ADMIN_URL}landing/block{$data.landing_block_type_id}.tpl"}
    {else}
        {include file="landing/block{$data.landing_block_type_id}.tpl"}
    {/if}
{else}
    {if $data.text || count($data.pictures) || count($data.files)}
        <div class="{if !$firmPage}container-fluid{else}content__block{/if}">
            <div class="pageData text_block" data-key="{$k}">
                {$data.text}
            </div>
        </div>
    {/if}
{/if}
{if $LB_edit}</div>{/if}