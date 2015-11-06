var gssToRegions = {
	"S12000017": "Highland"
}

function createMap() {
	//Map dimensions (in pixels) 
	var width = $("#map-container").width(),
		height = $("#map-container").height(); // preferable 500, 600

	//Map projection
	var projection = d3.geo.conicEqualArea()
		.scale(4350.298352620922)
		.center([-4.184851064666469,56.816790336871]) //projection center
		.parallels([54.633219999999994,60.845853567653094]) //parallels for conic projection
		.rotate([4.184851064666469]) //rotation for conic projection
		.translate([0, height/2]) //translate to center the map in view

	//Generate paths based on projection
	var path = d3.geo.path()
		.projection(projection);

	//Create an SVG
	var svg = d3.select("#map-container").append("svg")
		.attr("width", width)
		.attr("height", height);

	//Group for the map features
	var features = svg.append("g")
		.attr("class","features");

	d3.json("/all_councils_topo.topojson",function(error,geodata) {
	  if (error) return console.log(error); //unknown error, check the console

	  //Create a path for each map feature in the data
	  features.selectAll("path")
		.data(topojson.feature(geodata,geodata.objects.layer1).features) //generate features from TopoJSON
		.enter()
		.append("path")
		.attr("d",path)
		.on("click",clicked);

	});
}

// Add optional onClick events for features here
// d.properties contains the attributes (e.g. d.properties.name, d.properties.population)
function clicked(d,i) {
	console.log(gssToRegions[d.properties.gss]);
}
