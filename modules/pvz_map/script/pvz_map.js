ymaps.ready(init);

function init () {
    var myMap = new ymaps.Map('map', {
        center: [59.942277659742146,30.348150021484326],
        zoom: 9,
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

    $.ajax({
        url: "/modules/pvz_map/ajaxData.php"
    }).done(function(objects) {
        objectManager.add(objects);


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
            var destination = $("#map").offset().top;
            $('html, body').animate({ scrollTop: destination }, 600);
        });


    });
}