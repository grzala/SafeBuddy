var gssToRegions = {
	"S12000033": "Aberdeen City",
	"S12000034": "Aberdeenshire",
	"S12000041": "Angus",
	"S12000035": "Argyll & Bute",
	"Clackmannshire": "Clackmananshire",
	"Dumfries And Galloway": "Dumfries & Galloway",
	"S12000042": "Dundee City",
	"East Ayrshire": "East Ayshire",
	"S12000045": "East Dunbartonshire",
	"S12000010": "East Lothian",
	"S12000011": "East Renfrewshire",
	"S12000036": "City Of Edinburgh",
	"S12000013": "Eilean Siar",
	"S12000014": "Falkirk",
	"S12000015": "Fife",
	"S12000046": "Glasgow City",
	"S12000017": "Highland",
	"S12000018": "Inverclyde",
	"S12000019": "Midlothian",
	"S12000020": "Moray",
	"S12000021": "North Ayrshire",
	"S12000044": "North Lanarkshire",
	"S12000023": "Orkney Islands",
	"S12000024": "Perth & Kinross",
	"S12000038": "Renfrewshire",
	"S12000026": "Scottish Borders",
	"S12000027": "Shetland Islands",
	"S12000028": "South Ayrshire",
	"S12000029": "South Lanarkshire",
	"S12000030": "Stirling",
	"S12000039": "West Dunbartonshire",
	"S12000040": "West Lothian",
	
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
	$("#selected-region").text("You have selected: " + gssToRegions[d.properties.gss]);
	$("#select-region").show();
}
