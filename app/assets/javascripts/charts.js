function createCrimeRegionPieChart(crimes, year){
	var newCrimes = [];
	var len = crimes.length;
	for (var i = 0; i < len; i++) {
		if (crimes[i].group != "Motor vehicle offences" && crimes[i].group != "Miscellaneous offences") newCrimes.push(crimes[i]);
	}
	createRegionPieChart(newCrimes, "Crimes in: ", "crimes", 50, year);
}

function createCrimesAndOffencesRegionPieChart(crimes, year)  {
	createRegionPieChart(crimes, "Crimes and Offences in: ", "crimes-and-offences", 100, year);
}

function createViolentRegionPieChart(crimes, year)  {
	var newCrimes = [];
	var len = crimes.length;
	for (var i = 0; i < len; i++) {
		if (crimes[i].group == "Non-sexual crimes of violence" || crimes[i].group == "Sexual offences") newCrimes.push(crimes[i]);
	}
	createRegionPieChart(newCrimes, "Violent crimes in: ", "violent", 0, year);
}

function createRegionPieChart(crimes, title, id, limitLow, year) {
	$(function () {
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
		var versionsData = [];
		var dataLen = data.length;


		// Build the data arrays
		for (var i = 0; i < dataLen; i++) {

			// add browser data
			crimeData.push({
				name: categories[i],
				y: data[i].y,
				color: data[i].color
			});

			// add version data
			var drillDataLen = data[i].drilldown.data.length;
			for (var j = 0; j < drillDataLen; j++) {
				var brightness = 0.2 - (j / drillDataLen) / 5;
				versionsData.push({
					name: data[i].drilldown.categories[j],
					y: data[i].drilldown.data[j],
					color: Highcharts.Color(data[i].color).brighten(brightness).get()
				});
			}
		}

		// Create the chart
		$('#'+id).highcharts({
			chart: {
				type: 'pie'
			},
			title: {
				text: title+crimes[0].region
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
				data: versionsData,
				size: '80%',
				innerSize: '60%',
				dataLabels: {
					formatter: function () {
						// display only if larger than 1
						return this.y > limitLow ? '<b>' + this.point.name + ':</b> ' + this.y : null;
					}
				}
			}]
		});
	});

}
