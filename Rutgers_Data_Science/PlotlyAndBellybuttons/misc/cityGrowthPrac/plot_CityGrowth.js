var sortedCites = cityGrowths.sort((a, b) => b["Increase_from_2016"] - a["Increase_from_2016"]);
var topFive = sortedCites.slice(0, 5);

var topFiveNames = topFive.map(city => city.City);
var topFiveGrowths = topFive.map(city => parseInt(city.Increase_from_2016));

//var sevenBiggestCities = cityGrowths.sort((a, b) => b.population - a.population).slice(0, 7);
//traceA = {
//    x: sevenBiggestCities.map(city => city.City),
//    y: sevenBiggestCities.map(city => parseInt(city.population)),
//    type: "bar",} 
//layout = {
//    xaxis: {title: "cities"},
//    yaxis: {title: "pop"}}
//Plotly.newPlot("bar-plot", [traceA], layout);

