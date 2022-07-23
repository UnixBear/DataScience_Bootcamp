console.log("working");

// Create the map object with center at the San Francisco airport.
let map = L.map('mapid').setView([30,30], 2);

// We create the tile layer that will be the background of our map.
let streets = L.tileLayer('https://api.mapbox.com/styles/v1/mapbox/navigation-night-v1/tiles/{z}/{x}/{y}?access_token={accessToken}', {
attribution: 'Map data © <a href="https://www.openstreetmap.org/">OpenStreetMap</a> contributors, <a href="https://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, Imagery (c) <a href="https://www.mapbox.com/">Mapbox</a>',
    maxZoom: 18,
    accessToken: API_KEY
});
// Then we add our 'graymap' tile layer to the map.
streets.addTo(map);

// import json data from github repo
let airportData = "https://raw.githubusercontent.com/UnixBear/DataScience_Bootcamp/Mapping_GeoJSON_Points/Rutgers_Data_Science/Mapping_Earthquakes/majorAirports.json";
// Grabbing GeoJson data
d3.json(airportData).then(function(data) {
    console.log(data);
    // Create a GeoJSON layer with the retrieved data
    var myLayer = L.geoJson(data, {
        style: function (feature) {
            return feature.properties.style;
        },
        onEachFeature: function (feature, layer) {
            layer.bindPopup("</h2>Airport ID" + feature.properties.id + "</h2><hr><h2>Airport Name: " + feature.properties.name + "</h2>");
        }
    });
    myLayer.addTo(map)

});

// Add GeoJSON data.
/*let sanFranAirport = {
    "type": "FeatureCollection", "features": [{
        "type": "Feature",
        "properties": {
            "id": "3469",
            "name": "San Francisco International Airport",
            "city": "San Francisco",
            "country": "United States",
            "faa": "SFO",
            "icao": "KSFO",
            "alt": "13",
            "tz-offset": "-8",
            "dst": "A",
            "tz": "America/Los_Angeles"
        },
        "geometry": {
            "type": "Point",
            "coordinates": [-122.375, 37.61899948120117]
        }
    }]
};
//Add the GeoJSON layer to the map and add data
L.geoJSON(sanFranAirport, {
    pointToLayer: function (feature, latlng) {
        console.log(feature);
        return L.marker(latlng)
            .bindPopup("<h2>" + feature.properties.name + "</h2> <hr> <h2>" + feature.properties.city + ", " + feature.properties.country + "</h2>");
    }
}).addTo(map);*/
