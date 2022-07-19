function init() {
  var selector = d3.select("#selDataset");

  d3.json("samples.json").then((data) => {
    console.log(data);
    var sampleNames = data.names;
    sampleNames.forEach((sample) => {
      selector
        .append("option")
        .text(sample)
        .property("value", sample);
    });
})}

function optionChanged(newSample) {
  buildMetadata(newSample);
  //  buildCharts(newSample)
  console.log(newSample);
};

function buildMetadata(sample) {
  //greads the whole file and assigns it to data for access
  d3.json("samples.json").then((data) => {

    //copies the sample data's metadata into another object
    var metadata = data.metadata;

    // from the metadata object, filter by id only for the id 
    //that matches with the sample that was provided when
    //buildMetadata is called
    var resultsArray = metadata.filter(sampleObj => sampleObj.id == sample);

    //the entry we care about is in the first element
    var result = resultsArray[0];

    //we create a hook into the div/panel in which we plan to
    //display the information
    var PANEL = d3.select("#sample-metadata");

    //we set the element to equal nothing to clear out anything
    //that might still be there
    PANEL.html("");

    //we append a header tag "h6" and add the location info from
    //our metadata result as a template
    //PANEL.append("h6").append("strong").text("Location: " + result.location);

    //to iterate through all the metadata attributes, we want to break
    //them up into key/value pairs
    var keyvals = Object.entries(result);

    //iterate through each k/v pair and append the html to h6
    keyvals.forEach((pair) => {
      PANEL.append("h6").append("strong").text(`${pair[0].toUpperCase()}: ${pair[1]}`);
    })
  })
}
init();
