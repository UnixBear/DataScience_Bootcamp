//import data from data.js
const tableData = data;
var tbody = d3.select("tbody");
function buildTable(data) {
    tbody.html("")
    data.array.forEach((dataRow) => {
        let row = tbody.append("tr");
        Object.values(dataRow).forEach((val) => {
            
        })
    });
}