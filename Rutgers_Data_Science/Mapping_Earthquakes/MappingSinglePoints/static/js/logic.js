console.log("working");

//Setting center of the map approximately between LAX and SFO [36.1733, -120.1794]
let map = L.map('mapid').setView([37.6213, -122.3790], 5);
        // We create the tile layer that will be the background of our map.
let streets = L.tileLayer('https://api.mapbox.com/styles/v1/mapbox/satellite-streets-v11/tiles/{z}/{x}/{y}?access_token={accessToken}', {
attribution: 'Map data © <a href="https://www.openstreetmap.org/">OpenStreetMap</a> contributors, <a href="https://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, Imagery (c) <a href="https://www.mapbox.com/">Mapbox</a>',
    maxZoom: 18,
    accessToken: API_KEY
});

// Then we add our 'graymap' tile layer to the map.
streets.addTo(map);

// import cities from cities.js
let cityData = cities
  
// Add a circle to the map around LA, CA
//L.circleMarker([34.0522, -118.2437], {
//    radius: 10,
//   color: 'black',
//    fillColor: '#ffffa1'
//}).addTo(map);


// This adds a marker with a popup showing each city's population
/*
cityData.forEach(function (city) {
    L.circleMarker(city.location, {
        radius: city.population / 200000,
        weight: 4,
        color: 'orange',
        //fillColor: '#ffffa1'
    }).addTo(map);
    L.marker(city.location)
        .bindPopup("<h2>" + city.city + ", " + city.state + "</h2> <hr> <h3>Population " + city.population.toLocaleString() + "</h3>")
        .addTo(map);
})*/

//these are the coordinates of LAX and SFO respectively
let line = [
    [33.9416, -118.4085],
    [37.6213, -122.3790],
    [40.7899, -111.9791],
    [47.4502, -122.3088]
  ];

//adding a marker over LAX and SFO
line.forEach(airport => L.marker(airport).addTo(map));
  
L.polyline(line, {
    color: "yellow"
}).addTo(map);
