const url = "https://api.spacexdata.com/v2/launchpads";

d3.json(url).then(receivedData => console.log(receivedData));

//to get the full name of VAFB SLC 3W
d3.json(url).then(spaceXResults => console.log(spaceXResults[0].full_name))

//to output the latitude/longitude of each site
d3.json(url).then(spaceXResults => spaceXResults.map(locat => console.log([locat.location.latitude, locat.location.longitude])))



