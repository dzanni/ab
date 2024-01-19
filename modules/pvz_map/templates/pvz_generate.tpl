<div id="map" style="height: 500px;"></div>

{if count($pvz_map->getPvz()) > 0}
    <div class="shops list">
        <div class="items">
            {foreach from=$pvz_map->getPvz() item=pvz}
                <div class="item clearfix js_show_on_map" data-id="{$pvz.id}">
                    <div class="image">
                            <img src="/downloads/pvz/{$pvz.id}.jpg" alt="{$pvz.name}" title="{$pvz.name}">
                    </div>
                    <div class="rubber">
                        <div class="title_metro">
                            <div class="title">{$pvz.name}</div>
                            <div class="metro"><i></i>{$pvz.metroStations}</div>
                        </div>
                        <div class="schedule_phone_email">
                            <div class="schedule">⏰ {$pvz.workhours}</div>
                            <div class="phone_email">
                                <div class="phone"><a rel="nofollow" href="tel:{$pvz.tel}">☎ {$pvz.tel}</a></div>
                            </div>
                        </div>
                    </div>
                </div>
            {/foreach}
        </div>
    </div>
{/if}
