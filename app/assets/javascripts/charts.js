function createCrimesCouncilPieChart(crimes) {
	
	var title = "Crimes in: "+crimes[0].region;
	var data = []
	
	//clash years
	var newCrimes = {};
	for (var crime in crimes) {
		if (newCrimes[crimes[crime].group] == undefined) {
			newCrimes[crimes[crime].group] = 0;
		}
		newCrimes[crimes[crime].group] += crimes[crime].number;
	}
	
	for (var group in newCrimes) {
		data.push({
			name: group,
			y: newCrimes[group]
		});
	}
	
    $('#council').highcharts({
        chart: {
            plotBackgroundColor: null,
            plotBorderWidth: null,
            plotShadow: false,
            type: 'pie'
        },
        title: {
            text: title
        },
        tooltip: {
            pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
        },
        plotOptions: {
            pie: {
                allowPointSelect: true,
                cursor: 'pointer',
                dataLabels: {
                    enabled: true,
                    format: '<b>{point.name}</b>: {point.y:.0f} ',
                    style: {
                        color: (Highcharts.theme && Highcharts.theme.contrastTextColor) || 'black'
                    }
                }
            }
        },
        series: [{
            name: "Crimes",
            colorByPoint: true,
            data: data
        }]
    });
    
    return newCrimes;

}

function createCrimesAndOffencesRegionColumnChart(crimes, group) {
	
	//adjust title
	var title = group+" in: "+crimes[0].region;
	if(window.id == "all") {
		title = title.split(" ");
		title.splice(title.length-1, 1);
		title = title.join(" ")+" Scotland";
	}
	
	//filter crime type, clash same categories
	var newCrimes = [];
	for (crime in crimes) {
		if (crimes[crime].group == group) {
			newCrimes.push(crimes[crime]);
		}
	} crimes = newCrimes;
	
	var mainData = [];
	var drilldownData = [];
	var sums = {
		2009: 0,
		2010: 0,
		2011: 0,
		2012: 0,
		2013: 0,
		2014: 0
	};
	var drilldowns = {
		2009: [],
		2010: [],
		2011: [],
		2012: [],
		2013: [],
		2014: []
	};
	
	for (crime in crimes) {
		var y = crimes[crime].year;
		sums[y] += crimes[crime].number;
		var drilldown = [];
		
		var neu = true;
		
		for (d in drilldowns[y]) {
			if(drilldowns[y][d][0] == crimes[crime].category) {
				neu = false;
				drilldowns[y][d][1] += crimes[crime].number;
			}
		}
		if (neu) {
			drilldown.push(crimes[crime].category);
			drilldown.push(crimes[crime].number);
			drilldowns[y].push(drilldown);
		}
	} 
	
	for (key in sums) {
		mainData.push({
			name: key,
			y: sums[key],
			drilldown: key
		});
	}
	
	for (key in drilldowns) {
		drilldownData.push({
			name: key,
			id: key,
			data: drilldowns[key]
		});
	}
	
    // Create the chart
    $('#'+group.replace(/[\s,.]/g, "")).highcharts({
        chart: {
            type: 'column'
        },
        title: {
            text: title
        },
        subtitle: {
			text: 'Click on a column to see more details'
		},
        xAxis: {
            type: 'category'
        },
        yAxis: {
			title: {
				text: 'Total crimes'
			}
		},

        legend: {
            enabled: false
        },

        plotOptions: {
            series: {
                borderWidth: 0,
                dataLabels: {
                    enabled: true
                }
            }
        },

        series: [{
            name: group,
            colorByPoint: true,
            data: mainData
        }],
        drilldown: {
            series: drilldownData
        }
    });
}

function createCrimesRegionPieChart(crimes, year) {
	var newCrimes = [];
	var len = crimes.length;
	for (var i = 0; i < len; i++) {
		if (crimes[i].group != "Motor vehicle offences" && crimes[i].group != "Miscellaneous offences") newCrimes.push(crimes[i]);
	}
	return createRegionPieChart(newCrimes, "Crimes in: ", "crimes", 100, year);
}

function createCrimesAndOffencesRegionPieChart(crimes, year)  {
	return createRegionPieChart(crimes, "Crimes and Offences in: ", "crimes-and-offences", 200, year);
}

function createViolentRegionPieChart(crimes, year)  {
	var newCrimes = [];
	var len = crimes.length;
	for (var i = 0; i < len; i++) {
		if (crimes[i].group == "Non-sexual crimes of violence" || crimes[i].group == "Sexual offences") newCrimes.push(crimes[i]);
	}
	return createRegionPieChart(newCrimes, "Violent crimes in: ", "violent", 0, year);
}

function createRegionPieChart(crimes, title, id, limitLow, year) {

	var groups = [];
	var subgroups = {};
	var len = crimes.length;
	
	for (var i = 0; i < len; i++) {
		if(year == "all" || crimes[i].year == year) {
			var group = crimes[i].group;
			if(subgroups[group] == undefined) { //if crime category do not exist, create
				groups.push(group);
				subgroups[group] = {};
				subgroups[group]["name"] = [];
				subgroups[group]["number"] = [];
				subgroups[group]["sum"] = 0;
			}
			
			var index = subgroups[group]["name"].indexOf(crimes[i].category);
			
			if(index >= 0) {//prevent adding same category many times, sum numbers form same category
				subgroups[group]["number"][index] += crimes[i].number;
			} else {
				subgroups[group]["name"].push(crimes[i].category);
				subgroups[group]["number"].push(crimes[i].number);

			}
		}
	}
	
	for (var g in subgroups) {
		for (var number in subgroups[g]["number"]) {
			subgroups[g]["sum"] += subgroups[g]["number"][number]; //sum category to group
		}
	}

	var colors = Highcharts.getOptions().colors;
	var categories = groups;
	var data = [];
	var col = 0;
	for (var g in subgroups) {
		var division =  {
			y: subgroups[g]["sum"],
			color: colors[col],
			drilldown: {
				name: 'MSIE versions',
				categories: subgroups[g]["name"],
				data: subgroups[g]["number"],
				color: colors[col]
			}
		}
		col++;
		data.push(division);
	}
	var crimeData = [];
	var drilldownsData = [];
	var dataLen = data.length;


	// Build the data arrays
	for (var i = 0; i < dataLen; i++) {

		// add main data
		crimeData.push({
			name: categories[i],
			y: data[i].y,
			color: data[i].color
		});

		// add drilldown data
		var drillDataLen = data[i].drilldown.data.length;
		for (var j = 0; j < drillDataLen; j++) {
			var brightness = 0.2 - (j / drillDataLen) / 5;
			drilldownsData.push({
				name: data[i].drilldown.categories[j],
				y: data[i].drilldown.data[j],
				color: Highcharts.Color(data[i].color).brighten(brightness).get()
			});
		}
	}
	
	//adjust title
	title = title+crimes[0].region;
	if(window.id == "all") {
		title = title.split(" ");
		title.splice(title.length-1, 1);
		title = title.join(" ")+" Scotland";
	}

	// Create the chart
	$('#'+id).highcharts({
		chart: {
			type: 'pie'
		},
		title: {
			text: title
		},
		yAxis: {
			title: {
				text: 'Number of crimes'
			}
		},
		plotOptions: {
			pie: {
				shadow: false,
				center: ['50%', '50%']
			}
		},
		series: [{
			name: 'Crimes',
			data: crimeData,
			size: '60%',
			dataLabels: {
				formatter: function () {
					return this.y > limitLow ? this.point.name : null;
				},
				color: '#ffffff',
				distance: -30
			}
		}, {
			name: 'Versions',
			data: drilldownsData,
			size: '80%',
			innerSize: '60%',
			dataLabels: {
				formatter: function () {
					// display only if larger than limit
					return this.y > limitLow ? '<b>' + this.point.name + ':</b> ' + this.y : null;
				}
			}
		}]
	});
	return drilldownsData;
}
