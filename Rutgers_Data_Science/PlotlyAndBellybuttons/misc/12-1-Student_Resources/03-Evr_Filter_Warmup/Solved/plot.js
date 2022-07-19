// Filter the data for movies with an IMDb rating greater than 8.9
//  and then graph each title on the x-axis and the respective metascore on the y-axis.
const tableData = topMovies;


// 1. Use the filter method to create a custom filtering function
//  that returns the movies with a rating greater than 8.9
var bestMovies = tableData.filter(function(movie) {return movie.imdbRating > 8.9;});

// 2. Use filter() to pass the function as its argument

//  Check to make sure your are filtering your movies.

// 3. Use the map method with the arrow function to return all the filtered movie titles.
var bestTitles = bestMovies.map(movie => movie.title)
//  Check your filtered movie titles.

// 4. Use the map method with the arrow function to return all the filtered movie metascores.
var movieMetas = bestMovies.map(movie => movie.metascore)
//  Check your filtered movie metascores.

// 5. Create your trace.

var trace = {
    x: bestTitles,
    y: movieMetas,
    type: "bar"
};
// 6. Create the data array for our plot


// 7. Define our plot layout
var layout = {
    title: "top movies",
    xaxis: {title: "titles"},
    yaxis: {title: "metascores"}
}

// 8. Plot the chart to a div tag with id "bar-plot"
Plotly.newPlot("bar-plot", [trace], layout);
