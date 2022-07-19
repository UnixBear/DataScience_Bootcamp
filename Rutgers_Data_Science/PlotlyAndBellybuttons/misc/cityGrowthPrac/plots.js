var trace = {
    x: ["boohoorito", "piwhawhazza", "coward"],
    y: [10,10,5],
    type: "bar",
};
var trace2 = {
    labels: ["nonalcoholic beer", "nonalcoholic wine", "nonalcoholic martini", "nonalcoholic margarita", "ice tea", "nonalcoholic rum & coke", "nonalcoholic mai tai", "nonalcoholic gin & tonic"],
    values: [22.7, 17.1, 9.9, 8.7, 7.2, 6.1, 6.0, 4.6],
    type: "pie",
}
var trace3a = {
    x: [1, 2, 3, 4, 5],
    y: [1, 6, 3, 6, 1],
    mode: 'markers',
    type: 'scatter',
    name: 'Team A',
    text: ['A-1', 'A-2', 'A-3', 'A-4', 'A-5'],
    marker: { size: 12 },
}
var trace3b = {
    x: [1.5, 2.5, 3.5, 4.5, 5.5],
    y: [4, 1, 7, 1, 4],
    mode: 'markers',
    type: 'scatter',
    name: 'Team B',
    text: ['B-a', 'B-b', 'B-c', 'B-d', 'B-e'],
    marker: { size: 12 }
  };
var layout = {
    title: "deez Nuts",
    xaxis: { title: 'nuts' },
    yaxis: { title: 'deez' },
};

var layout2 = {
    title: "piechartcoholism",
    //xaxis: { title: "ooo gimme" },
    //yaxis: { title: "sadness" },
    
}

var layout3 = {
    xaxis: {
        range: [ 0.75, 5.25 ]
      },
      yaxis: {
        range: [0, 8]
      },
      title:'Data Labels Hover',
}
Plotly.newPlot("plotArea", [trace], layout);
Plotly.newPlot("plotArea2", [trace2], layout2);
Plotly.newPlot("plotArea3", [trace3a, trace3b], layout3);

