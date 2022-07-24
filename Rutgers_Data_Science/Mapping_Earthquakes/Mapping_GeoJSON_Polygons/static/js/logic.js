console.log("working");

// We create the tile layer that will be the background of our map.
let streets = L.tileLayer('https://api.mapbox.com/styles/v1/mapbox/dark-v10/tiles/{z}/{x}/{y}?access_token={accessToken}', {
attribution: 'Map data © <a href="https://www.openstreetmap.org/">OpenStreetMap</a> contributors, <a href="https://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, Imagery (c) <a href="https://www.mapbox.com/">Mapbox</a>',
    maxZoom: 18,
    accessToken: API_KEY
});

//this is a satellite background version of the map
let satelliteStreets = L.tileLayer('https://api.mapbox.com/styles/v1/mapbox/satellite-streets-v11/tiles/{z}/{x}/{y}?access_token={accessToken}', {
    attribution: 'Map data © <a href="https://www.openstreetmap.org/">OpenStreetMap</a> contributors, <a href="https://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, Imagery (c) <a href="https://www.mapbox.com/">Mapbox</a>',
    maxZoom: 18,
    accessToken: API_KEY
});

// Create the map object with center at Toronto, zoom level and default layer.
let map = L.map('mapid', {
    center: [44.0, -80.0],
    zoom: 11,
    layers: [streets]
});


//this is a container/base layer for both maps
let baseMaps = {
    "Streets": streets,
    "Satellite Streets": satelliteStreets
};

// Pass our layers into our layers control and add the layers control to the map
L.control.layers(baseMaps).addTo(map);

//import Toronto data
const torontoData = "https://raw.githubusercontent.com/UnixBear/DataScience_Bootcamp/Mapping_GeoJSON_Linestrings/Rutgers_Data_Science/Mapping_Earthquakes/Mapping_GeoJSON_Linestrings/torontoRoutes.json" 

//creating a style for the linestrings
const myStyle = {
    color: "FFFACD",
    weight: 2
}
// Grabbing GeoJson data
d3.json(torontoData).then(function(data) {
    console.log(data);
    // Create a GeoJSON layer with the retrieved data
    var myLayer = L.geoJson(data, {
        
        style: myStyle,
        onEachFeature: function (feature, layer) {
            layer.bindPopup("</h2>Airline:" + feature.properties.airline + "</h2><hr><h2>Destination: " + feature.properties.dst + "</h2>");
        }
    });
    myLayer.addTo(map)

});

