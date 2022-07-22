console.log("working");

let map = L.map('mapid', {
    center: [
        40.7, -94.5
    ],
    zoom: 4,
});
// We create the tile layer that will be the background of our map.
let streets = L.tileLayer('https://api.mapbox.com/styles/v1/mapbox/dark-v10/tiles/{z}/{x}/{y}?access_token={accessToken}', {
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
})

