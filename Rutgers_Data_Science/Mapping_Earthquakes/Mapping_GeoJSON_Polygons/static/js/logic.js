console.log("working");

// We create the streets tile layer that will be the background of our map.
let streets = L.tileLayer('https://api.mapbox.com/styles/v1/mapbox/streets-v11/tiles/{z}/{x}/{y}?access_token={accessToken}', {
attribution: 'Map data © <a href="https://www.openstreetmap.org/">OpenStreetMap</a> contributors, <a href="https://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, Imagery (c) <a href="https://www.mapbox.com/">Mapbox</a>',
	maxZoom: 18,
	accessToken: API_KEY
});

// We create the dark view tile layer that will be an option for our map.
let dark = L.tileLayer('https://api.mapbox.com/styles/v1/mapbox/dark-v10/tiles/{z}/{x}/{y}?access_token={accessToken}', {
attribution: 'Map data © <a href="https://www.openstreetmap.org/">OpenStreetMap</a> contributors, <a href="https://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, Imagery (c) <a href="https://www.mapbox.com/">Mapbox</a>',
	maxZoom: 18,
	accessToken: API_KEY
});

// We create the light view tile layer that will be an option for our map.
let light = L.tileLayer('https://api.mapbox.com/styles/v1/mapbox/light-v10/tiles/{z}/{x}/{y}?access_token={accessToken}', {
attribution: 'Map data © <a href="https://www.openstreetmap.org/">OpenStreetMap</a> contributors, <a href="https://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, Imagery (c) <a href="https://www.mapbox.com/">Mapbox</a>',
	maxZoom: 18,
	accessToken: API_KEY
});

// We create the stellite streets view tile layer that will be an option for our map.
let satelliteStreets = L.tileLayer('https://api.mapbox.com/styles/v1/mapbox/satellite-streets-v11/tiles/{z}/{x}/{y}?access_token={accessToken}', {
attribution: 'Map data © <a href="https://www.openstreetmap.org/">OpenStreetMap</a> contributors, <a href="https://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, Imagery (c) <a href="https://www.mapbox.com/">Mapbox</a>',
	maxZoom: 18,
	accessToken: API_KEY
});


// Create a base layer that holds both maps.
let baseMaps = {
	"Street": streets,
	"Satellite Streets": satelliteStreets,
	"Dark": dark,
	"Light": light
  };

// Create the map object with center, zoom level and default layer.
let map = L.map('mapid', {
	center: [43.7, -79.3],
	zoom: 11,
	layers: [satelliteStreets]
});

// Pass our map layers to a layer control object to switch between layers
L.control.layers(baseMaps).addTo(map);

//import Toronto data
const torontoHoods = "https://raw.githubusercontent.com/UnixBear/DataScience_Bootcamp/Mapping_GeoJSON_Polygons/Rutgers_Data_Science/Mapping_Earthquakes/Mapping_GeoJSON_Polygons/torontoNeighborhoods.json" 

//creating a style for the linestrings
const myStyle = {
    color: "red",
    weight: 1

}
// Grabbing GeoJson data
d3.json(torontoHoods).then(function(data) {
    console.log(data);
    // Create a GeoJSON layer with the retrieved data
    var mLayer = L.geoJson(data, {
        style: myStyle,
        onEachFeature: function(feature,layer) {
            layer.bindPopup("<h2>Neighborhood: " + feature.properties.AREA_NAME + "</h2>");
        }
    });
    mLayer.addTo(map);
});


