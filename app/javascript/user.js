
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
      // results[0].geometry.location
      if (results[0]) {
        new google.maps.Map(target, {
          center: results[0].geometry.location,
          zoom: 15,
          mapTypeId: 'hybrid',
        });
      } else {
        alert('No results found');
        return;
      }
    });
  });

}

window.addEventListener("load", initMap);