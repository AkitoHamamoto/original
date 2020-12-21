

function initMap() {
  'user strict';

  let target = document.getElementById('target');
  let geocoder = new google.maps.Geocoder();

  document.getElementById('search').addEventListener('click', function() {
    geocoder.geocode({
      address: document.getElementById('address').value
    }, function(results, status) {
      if (status !== 'OK') {
        alert('Failed: ' + status);
        return;
      }
      if (results[0]) {
        new google.maps.Map(target, {
          center: results[0].geometry.location,
          zoom: 18,
          mapTypeId: 'hybrid'
        });

        map.addListener('click', function(e) {
          let marker = new google.maps.Marker({
            position: e.latLng,
            map: this,
            animation: google.maps.Animation.DROP
          });
          let infoWindow = new google.maps.InfoWindow({
            content: e.latLng.toString()
          });
          marker.addListener('click', function() {
            infoWindow.open(map, marker);
          });
        });

      } else {
        alert('No results found');
        return;
      }
    });
  });

}

window.addEventListener("turbolinks:load", initMap);