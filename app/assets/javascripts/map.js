var gssToRegions = {
	"S12000033": ["Aberdeen City", 1],
	"S12000034": ["Aberdeenshire", 2],
	"S12000041": ["Angus", 3],
	"S12000035": ["Argyll & Bute", 4],
	"Clackmannanshire": ["Clackmannanshire", 5],
	"Dumfries And Galloway": ["Dumfries & Galloway", 6],
	"S12000042": ["Dundee City", 7],
	"East Ayrshire": ["East Ayshire", 8],
	"S12000045": ["East Dunbartonshire", 9],
	"S12000010": ["East Lothian", 10],
	"S12000011": ["East Renfrewshire", 11],
	"S12000036": ["City Of Edinburgh", 12],
	"S12000013": ["Eilean Siar", 13],
	"S12000014": ["Falkirk", 14],
	"S12000015": ["Fife", 15],
	"S12000046": ["Glasgow City", 16],
	"S12000017": ["Highland", 17],
	"S12000018": ["Inverclyde", 18],
	"S12000019": ["Midlothian", 19],
	"S12000020": ["Moray", 20],
	"S12000021": ["North Ayrshire", 21],
	"S12000044": ["North Lanarkshire", 22],
	"S12000023": ["Orkney Islands", 23],
	"S12000024": ["Perth & Kinross", 24],
	"S12000038": ["Renfrewshire", 25],
	"S12000026": ["Scottish Borders", 26],
	"S12000027": ["Shetland Islands", 27],
	"S12000028": ["South Ayrshire", 28],
	"S12000029": ["South Lanarkshire", 29],
	"S12000030": ["Stirling", 30],
	"S12000039": ["West Dunbartonshire", 31],
	"S12000040": ["West Lothian", 32],
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
	$("#selected-region").text(gssToRegions[d.properties.gss][0]);
	$("#select-region").show();
	$("#select-region").attr("href", "/regions/"+gssToRegions[d.properties.gss][1]);
}
