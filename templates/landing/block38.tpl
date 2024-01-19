<script src="https://api-maps.yandex.ru/2.1/?lang=ru-RU"></script>
<link rel="stylesheet" type="text/css" href="/modules/pvz_map/style/pvz_map.css">

<script>
    ymaps.ready(init);

    function init () {
        var myMap = new ymaps.Map('map', {
                center: [{if $block.0.center}{$block.0.center}{else}55.452082,37.370347{/if}],
                zoom: {if $block.0.zoom}{$block.0.zoom}{else}12{/if},
            controls: []
        });
        objectManager = new ymaps.ObjectManager({
            // Чтобы метки начали кластеризоваться, выставляем опцию.
            clusterize: true,
            // ObjectManager принимает те же опции, что и кластеризатор.
            gridSize: 32,
            clusterDisableClickZoom: true
        });

        // Чтобы задать опции одиночным объектам и кластерам,
        // обратимся к дочерним коллекциям ObjectManager.
        objectManager.objects.options.set('preset', 'islands#greenDotIcon');
        objectManager.clusters.options.set('preset', 'islands#greenClusterIcons');
        myMap.geoObjects.add(objectManager);

            objectManager.add({
                "type": "FeatureCollection",
                "features": [
                    {foreach from=$block.0.inner key=key item=data}
                    {if $data.geo}

                    {
                        "type": "Feature",
                        "id": {$key},
                        "geometry":{
                            "type": "Point",
                            "coordinates":[ {$data.geo} ]
                        },
                        "properties":{
                            "balloonContentHeader": `{$data.address}`,
                            "balloonContentBody": `<a class="make_road" href="https://yandex.ru/maps/?rtext=~{$data.geo}" target="_blank">Проложить маршрут</a>`,
                            "hintContent": `{$data.address}`
                        }
                    },
                    {/if}
                    {/foreach}

                ]
            });


            $(document).on("click", ".js_show_on_map", function (){

                var obj = objectManager.objects.getById($(this).data("id"));
                myMap.setCenter(obj.geometry.coordinates, 13);
                var objectState = objectManager.getObjectState($(this).data("id"));

                if (objectState.found && objectState.isShown) {
                    // Если объект попадает в кластер, открываем балун кластера с нужным выбранным объектом.
                    if (objectState.isClustered) {
                        objectManager.clusters.state.set('activeObject', objectManager.getById($(this).data("id")));
                        objectManager.clusters.balloon.open(objectState.cluster.id);
                    } else {
                        // Если объект не попал в кластер, открываем его собственный балун.
                        objectManager.objects.balloon.open($(this).data("id"));
                    }
                }
               // var destination = $("#map").offset().top;
               // $('html, body').animate({ scrollTop: destination }, 600);
            });

    }
</script>

{*<div class="page-inner page-comp03">*}
    {*<aside>*}
    {*</aside>*}
    {*<main>*}
        {*{if $right_block}*}
        {*<div class="comp__column">*}
            {*<div class="comp__block">*}
                {*{/if}*}
                <div class="content__block">
                    <div class="block__title">{$block.0.title}</div>
                    <div class="block__content">
                        <div class="maps__list">
                            {foreach from=$block.0.inner key=key item=data}
                                <a class="map__item js_show_on_map" data-id="{$key}">{$data.address}</a>
                            {/foreach}
                            <div class="map__include" id="map" style="height: 400px;">
                            </div>
                        </div>
                    </div>
                </div>
                {*{if $right_block}*}
            {*</div>*}
        {*</div>*}
        {*{/if}*}
    {*</main>*}
{*</div>*}

