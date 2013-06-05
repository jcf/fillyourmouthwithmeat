var map;

google.maps.visualRefresh = true

function initialize() {
  var latLng, mapOptions, map, marker;

  latLng = new google.maps.LatLng(51.538717, -0.108266);
  mapOptions = {
    zoom: 18,
    center: latLng,
    mapTypeId: google.maps.MapTypeId.HYBRID
  };

  map = new google.maps.Map(
    document.getElementById('map-canvas'),
    mapOptions);

  info = new google.maps.InfoWindow({
    content: $('#info').html(),
    maxWidth: 600
  });

  marker = new google.maps.Marker({
    position: latLng,
    map: map,
    title: 'Hello World!'
  });

  // google.maps.event.addListener(marker, 'click', function() {
  //   info.open(map,marker);
  // });

  // setTimeout(function() { info.open(map, marker) }, 1000);
}

google.maps.event.addDomListener(window, 'load', initialize);
