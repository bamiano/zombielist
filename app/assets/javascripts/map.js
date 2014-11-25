window.onload = function() {

  L.mapbox.accessToken = 'pk.eyJ1IjoieWJpbnN0b2NrIiwiYSI6InhNejJyTGMifQ.nwKk32P-nORfMexmd3-N8Q';
  var geocoder = L.mapbox.geocoder('mapbox.places-v1'),
      map = L.mapbox.map('map', 'ybinstock.k1nk0dji');

  var gControl = L.mapbox.geocoderControl('mapbox.places-v1', {
        keepOpen: true
    });

  map.addControl(gControl);

  // Credit Foursquare
  map.attributionControl
      .addAttribution('<a href="https://foursquare.com/">Places data from Foursquare</a>');

  gControl.on('found', function(data){
      // console.log(map.featureLayer.getGeoJSON());
      //console.log(data.results.query[0]);
      geocoder.query(data.results.query[0], showMap);
      console.log(map.featureLayer.getGeoJSON().features)
  });

 // Find and store a variable reference to the list of filters.
        var filters = document.getElementById('filters');
        // console.log("filters", filters);

      map.featureLayer.on('ready', function() {

        var typesObj = {};
        var types = ["supplies","food", "weapons", "hideouts"];
        var features = map.featureLayer.getGeoJSON().features;
        for (var i = 0; i < features.length; i++) {
          typesObj[features[i].properties['marker-symbol']] = true;
        }
        for (var k in typesObj) types.push(k);
        console.log(types)


        var checkboxes = [];



        // Create a filter interface.
        for (var i = 0; i < types.length; i++) {
          // Create an an input checkbox and label inside.
          var item = filters.appendChild(document.createElement('div'));
          var checkbox = item.appendChild(document.createElement('input'));
          var label = item.appendChild(document.createElement('label'));
          checkbox.type = 'checkbox';
          checkbox.id = types[i];
          checkbox.checked = true;
          // console.log("checkbox",checkbox);
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
          // console.log("update");
          var enabled = {};

          // Run through each checkbox and record whether it is checked. If it is,
          // add it to the object of types to display, otherwise do not.
          for (var i = 0; i < checkboxes.length; i++) {
            if (checkboxes[i].checked) {
              enabled[checkboxes[i].id] = true;
              }
          }
          console.log("enabled", enabled);

          map.featureLayer.setFilter(function(feature) {
            alert("WHEN DO YOU RUN????")
              console.log(feature);
            // If this symbol is in the list, return true. if not, return false.
            // The 'in' operator in javascript does exactly that: given a string
            // or number, it says if that is in a object.
            // "supplies" in  enabled
            // "food" in enabled
            // "weapons" in enabled
            // "hideouts" in enabled

            return (feature.properties['marker-symbol'] in enabled);
          });
        }
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

      $.when(API_ENDPOINT1('hardware store'), API_ENDPOINT2('police stations'),API_ENDPOINT3('food'),API_ENDPOINT4('weapons')).done(function(result1,result2,result3,result4){

          var venues = [];
          venues = venues.concat(result1[0].response.venues);
          venues = venues.concat(result2[0].response.venues);
          venues = venues.concat(result3[0].response.venues);
          venues = venues.concat(result4[0].response.venues);
          // console.log("venues", venues);


          // Transform each venue result into a marker on the map.
          for (var i = 0; i < venues.length; i++) {
            var venue = venues[i];
            var latlng = L.latLng(venue.location.lat, venue.location.lng);
            var foursquareLink = $("<a></a>")
              .text(venue.name)
              .attr("href", "https://foursquare.com/v/" + venue.id)
              .css("font-weight", "bold");

            var addButton = $("<br> <button onclick='hideOverlay();'> Save to favorites</button>");
              addButton.on("click", (function (place) {

                return function () {
                  addlocation(place);
                };
              })(venue));

            var buttonContainer = $("<div>")
              .append(foursquareLink, addButton)
              .get(0);
            var marker = L.marker(latlng, {
                icon: L.icon({
                  iconUrl: venue.categories[0].icon.prefix + '32' + venue.categories[0].icon.suffix
                })
              })
            .bindPopup(buttonContainer)
            .addTo(foursquarePlaces);
          }
      });


      // Keep our place markers organized in a nice group.
      var foursquarePlaces = L.layerGroup().addTo(map);

      var markers = L.mapbox.featureLayer().addTo(map);

      var geojson = [
          {
            "type": "Feature",
            "geometry": {
              "coordinates": [
                -123.37030649185,
                48.4253703539
              ],
              "type": "Point"
            },
            "properties": {
              "title": "Marina #2",
              "icon": {
                  "iconUrl": "/assets/kitten.jpg",
                  "iconSize": [50, 50], // size of the icon
                  "iconAnchor": [25, 25], // point of the icon which will correspond to marker's location
                  "popupAnchor": [0, -25], // point from which the popup should open relative to the iconAnchor
                  "className": "dot"
              }
            }
          },
          {
            "type": "Feature",
            "geometry": {
              "coordinates": [
                -122.4444937706,
                37.807478357821
              ],
              "type": "Point"
            },
            "properties": {
              "title": "Marina #3",
              "icon": {
                  "iconUrl": "/assets/kitten.jpg",
                  "iconSize": [50, 50], // size of the icon
                  "iconAnchor": [25, 25], // point of the icon which will correspond to marker's location
                  "popupAnchor": [0, -25], // point from which the popup should open relative to the iconAnchor
                  "className": "dot"
              }
            }
          }
      ];

      // Set a custom icon on each marker based on feature properties.
      markers.on('layeradd', function(e) {
          var marker = e.layer,
              feature = marker.feature;

          marker.setIcon(L.icon(feature.properties.icon));
      });

      markers.setGeoJSON(geojson);

  addlocation = function(venue) {
    // console.log("venue", venue);

    var token = $("meta[name='csrf-token']").attr("content");
    $.ajax({
      type: 'POST',
      url: "/users/" + gon.current_user.id + "/locations/",
      data: {
        location: {
          location_type: venue.categories[0].name,
          name: venue.name,
          address: venue.location.address
        }
      },
      headers: {
          "X-CSRF-Token": token
      }
    }).done();

  };

  }
  // closing onload function
};