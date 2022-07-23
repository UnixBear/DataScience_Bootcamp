console.log("working");

// We create the tile layer that will be the background of our map.
let light = L.tileLayer('https://api.mapbox.com/styles/v1/mapbox/light-v10/tiles/{z}/{x}/{y}?access_token={accessToken}', {
attribution: 'Map data © <a href="https://www.openstreetmap.org/">OpenStreetMap</a> contributors, <a href="https://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, Imagery (c) <a href="https://www.mapbox.com/">Mapbox</a>',
    maxZoom: 18,
    accessToken: API_KEY
});


// Create the map object with center at Toronto, zoom level and default layer.
let map = L.map('mapid', {
    center: [44.0, -80.0],
    zoom: 2,
    layers: [light]
});

//this is a dark version of the map
let dark = L.tileLayer('https://api.mapbox.com/styles/v1/mapbox/dark-v10/tiles/{z}/{x}/{y}?access_token={accessToken}', {
    attribution: 'Map data © <a href="https://www.openstreetmap.org/">OpenStreetMap</a> contributors, <a href="https://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, Imagery (c) <a href="https://www.mapbox.com/">Mapbox</a>',
    maxZoom: 18,
    accessToken: API_KEY
});

//this is a container/base layer for both maps
let baseMaps = {
    Light: light,
    Dark: dark
};

// Pass our layers into our layers control and add the layers control to the map
L.control.layers(baseMaps).addTo(map);

//import Toronto data
 

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

