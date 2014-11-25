window.onload = function() {

  L.mapbox.accessToken = 'pk.eyJ1IjoieWJpbnN0b2NrIiwiYSI6InhNejJyTGMifQ.nwKk32P-nORfMexmd3-N8Q';
  var geocoder = L.mapbox.geocoder('mapbox.places-v1'),
      map = L.mapbox.map('map', 'ybinstock.k1nk0dji');
  var markers = L.mapbox.featureLayer().addTo(map);
  window.markers = markers;

  var gControl = L.mapbox.geocoderControl('mapbox.places-v1', {
    keepOpen: true
  });

  map.addControl(gControl);

  // Credit Foursquare
  map.attributionControl
    .addAttribution(
      '<a href="https://foursquare.com/">Places data from Foursquare</a>'
      );

  gControl.on('found', function(data){
    geocoder.query(data.results.query[0], showMap);
  });

  function showMap(err, data) {
    // The geocoder can return an area, like a city, or a
    // point, like an address. Here we handle both cases,
    // by fitting the map bounds to an area or zooming to a point.
    if (data.lbounds) {
      map.fitBounds(data.lbounds);
    } else if (data.latlng) {
      map.setView([data.latlng[0], data.latlng[1]], 20);
    }

    // Foursquare API Info
    var CLIENT_ID = '2Y4EQC1YYKRBP5RBXDJQ0G0PDGN050FFWUSGGDQWLCJ0US4Y';
    var CLIENT_SECRET = 'QPNTB3ODMPEE40IOKEUSECVKQ5ZBQCICVCNWE35JKKQDM4RN';

    // https://developer.foursquare.com/start/search
    var API_ENDPOINT1 = function () {
      return $.getJSON("https://api.foursquare.com/v2/venues/search",{
        client_id: CLIENT_ID,
        client_secret: CLIENT_SECRET,
        v:'20130815',
        //callback: '?',
        ll: map.getCenter().lat +',' + map.getCenter().lng,
        categoryId: '52f2ab2ebcbc57f1066b8b19'
      });
    };

    var API_ENDPOINT2 = function () {
      return $.getJSON("https://api.foursquare.com/v2/venues/search",{
        client_id: CLIENT_ID,
        client_secret: CLIENT_SECRET,
        v:'20130815',
        //callback: '?',
        ll: map.getCenter().lat +',' + map.getCenter().lng,
        categoryId: '4bf58dd8d48988d12e941735'
      });
    };

    var API_ENDPOINT3 = function () {
      return $.getJSON("https://api.foursquare.com/v2/venues/search",{
        client_id: CLIENT_ID,
        client_secret: CLIENT_SECRET,
        v:'20130815',
        //callback: '?',
        ll: map.getCenter().lat +',' + map.getCenter().lng,
        categoryId: '4bf58dd8d48988d1f9941735'
      });
    };

    var API_ENDPOINT4 = function () {
      return $.getJSON("https://api.foursquare.com/v2/venues/search",{
        client_id: CLIENT_ID,
        client_secret: CLIENT_SECRET,
        v:'20130815',
        //callback: '?',
        ll: map.getCenter().lat +',' + map.getCenter().lng,
        categoryId: '52f2ab2ebcbc57f1066b8b19'
      });
    };

    $.when(
      API_ENDPOINT1('hardware store'),
      API_ENDPOINT2('police stations'),
      API_ENDPOINT3('food'),
      API_ENDPOINT4('weapons')
    ).done(function(result1,result2,result3,result4){
      var venues = [];
      venues = venues.concat(result1[0].response.venues);
      venues = venues.concat(result2[0].response.venues);
      venues = venues.concat(result3[0].response.venues);
      venues = venues.concat(result4[0].response.venues);

      venues = venues.map(function(el) {
        return {
          "type":"Feature",
          "geometry": {
            "coordinates": [
              el.location.lng,
              el.location.lat
            ],
           "type": "Point"
          },
          "properties": {
            "title": el.name,
            "category": el.categories[0].name,
            "id": el.id,
            "address": el.location.address,
            "icon": {
              "iconUrl": el.categories[0].icon.prefix+'bg_32'+el.categories[0].icon.suffix,
              "iconSize": [32, 32], // size of the icon
              "iconAnchor": [25, 25], // point of the icon which will correspond to marker's location
              "popupAnchor": [0, -25], // point from which the popup should open relative to the iconAnchor
              "className": "dot"
            }
          }
        };
      });

      // Set a custom icon on each marker based on feature properties.
      markers.on('layeradd', function(e) {
        var marker = e.layer,
            feature = marker.feature,
            properties = feature.properties;

        marker.setIcon(L.icon(feature.properties.icon));

        var foursquareLink = $("<a></a>")
          .text(properties.title)
          .attr("href", "https://foursquare.com/v/" + properties.id)
          .css("font-weight", "bold");

        var addButton = $("<br> <button onclick='hideOverlay();'> Save to favorites</button>");
          addButton.on("click", (function (place) {
            return function () {
              addlocation(place);
            };
          })(properties));

        var buttonContainer = $("<div>")
          .append(foursquareLink, addButton)
          .get(0);

        marker.bindPopup(buttonContainer);
      });

      markers.setGeoJSON(venues);

      var typesObj = {};
      var types = [];
      var features = markers.getGeoJSON();
      for (var i = 0; i < features.length; i++) {
        typesObj[features[i].properties['category']] = true;
      }
      for (var k in typesObj) types.push(k);

      var checkboxes = [];

      // Find and store a variable reference to the list of filters.
      var filters = document.getElementById('filters');

      // Create a filter interface.
      for (var i = 0; i < types.length; i++) {
        // Create an an input checkbox and label inside.
        var item = filters.appendChild(document.createElement('div'));
        var checkbox = item.appendChild(document.createElement('input'));
        var label = item.appendChild(document.createElement('label'));
        checkbox.type = 'checkbox';
        checkbox.id = types[i];
        checkbox.checked = true;
        // create a label to the right of the checkbox with explanatory text
        label.innerHTML = types[i];
        label.setAttribute('for', types[i]);
        // Whenever a person clicks on this checkbox, call the update().
        checkbox.addEventListener('change', update);
        checkboxes.push(checkbox);
        if (i===types.length-1) {
          item.appendChild(document.createElement("br"));
          var button = item.appendChild(document.createElement('button'));
          button.innerHTML="Favorites";
          $("button").click(function(){
            window.location.href="/users/" + gon.current_user.id + "/locations/";
          });
        }
      }

      // This function is called whenever someone clicks on a checkbox and changes
      // the selection of markers to be displayed.
      function update() {
        var enabled = {};

        // Run through each checkbox and record whether it is checked. If it is,
        // add it to the object of types to display, otherwise do not.
        for (var i = 0; i < checkboxes.length; i++) {
          if (checkboxes[i].checked) {
            enabled[checkboxes[i].id] = true;
          }
        }

        markers.setFilter(function(feature) {
          return enabled[feature.properties.category];
        });
      }


      // Transform each venue result into a marker on the map.
      // for (var i = 0; i < venues.length; i++) {
      //   var venue = venues[i];
      //   var latlng = L.latLng(venue.location.lat, venue.location.lng);
      //   var foursquareLink = $("<a></a>")
      //     .text(venue.name)
      //     .attr("href", "https://foursquare.com/v/" + venue.id)
      //     .css("font-weight", "bold");

      //   var addButton = $("<br> <button onclick='hideOverlay();'> Save to favorites</button>");
      //     addButton.on("click", (function (place) {
      //       return function () {
      //         addlocation(place);
      //       };
      //     })(venue));

      //   var buttonContainer = $("<div>")
      //     .append(foursquareLink, addButton)
      //     .get(0);
      //   var marker = L.marker(latlng, {
      //       icon: L.icon({
      //         iconUrl: venue.categories[0].icon.prefix + '32' + venue.categories[0].icon.suffix
      //       })
      //     })
      //   .bindPopup(buttonContainer)
      //   .addTo(foursquarePlaces);
      // }
    });

    // Keep our place markers organized in a nice group.
    // var foursquarePlaces = L.layerGroup().addTo(map);

    addlocation = function(venue) {
      var token = $("meta[name='csrf-token']").attr("content");
      $.ajax({
        type: 'POST',
        url: "/users/" + gon.current_user.id + "/locations/",
        data: {
          location: {
            location_type: venue.category,
            name: venue.title,
            address: venue.address
          }
        },
        headers: {
          "X-CSRF-Token": token
        }
      }).done();

    };
  }
};