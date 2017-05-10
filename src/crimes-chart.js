//----------SERVICE-----------
const CrimesChartModule = (function() {

    let Chart = require('chart.js/src/chart.js');

    function CrimesComponent() {

        const me = this;

        me.chartOptions = {
            chartTitle: 'Crimes Against Women',
            chartDataLabels: [],
            chartDataSets: []
        };

        const _apiUrl = 'https://data.gov.in/node/89971/datastore/export/json';

        var CrimesState;
        (function (CrimesState) {
            CrimesState[CrimesState["STATE"] = 1] = "STATE";
            CrimesState[CrimesState["UT"] = 2] = "UT";
            CrimesState[CrimesState["STATE_TOTAL"] = 3] = "STATE_TOTAL";
            CrimesState[CrimesState["UT_TOTAL"] = 4] = "UT_TOTAL";
        })(CrimesState || (CrimesState = {}));

        let STATES_LIST = [
          'ANDHRA PRADESH',
          'ARUNACHAL PRADESH',
          'ASSAM',
          'BIHAR',
          'CHHATTISGARH',
          'GOA',
          'GUJARAT',
          'Haryana',
          'Himachal Pradesh',
          'Jammu & Kashmir',
          'Jharkhand',
          'Karnataka',
          'Kerala',
          'Madhya Pradesh',
          'Maharashtra',
          'Manipur',
          'Meghalaya',
          'Mizoram',
          'Nagaland',
          'Odisha',
          'Punjab',
          'Rajasthan',
          'Sikkim',
          'Tamil Nadu',
          'Telangana',
          'Tripura',
          'Uttar Pradesh',
          'Uttarakhand',
          'West Bengal'
        ];

        let UNION_TERRITORIES_LIST = [
          'ANDAMAN AND NICOBAR ISLANDS',
          'CHANDIGARH',
          'DADAR AND NAGAR HAVELI',
          'DAMAN AND DIU',
          'DELHI',
          'LAKSHADWEEP',
          'PUDUCHERRY'
        ];

        let MISC_KEYWORDS = {
          'FOR_STATE'  : ['TOTAL (STATES)'],
          'FOR_UT'     : ['TOTAL (UTs)'],
          'FOR_CRIMES' : ['TOTAL CRIMES AGAINST WOMEN']
        };

        const StateCrimesModel = {
          id: function(data, fields, index) {
            return index;
          },
          stateInfo: function(data, fields) {
            let stateType = null;
            let stateName = data[0];

            STATES_LIST.map(function(state) {
              if (state.toLowerCase() === stateName.toLowerCase()) {
                stateType = CrimesState[1];
              }
            });
            UNION_TERRITORIES_LIST.map(function(ut) {
              if (ut.toLowerCase() === stateName.toLowerCase()) {
                stateType = CrimesState[2];
              }
            });
            MISC_KEYWORDS.FOR_STATE.map(function(miscState) {
              if (miscState.toLowerCase() === stateName.toLowerCase()) {
                stateType = CrimesState[3];
              }
            });
            MISC_KEYWORDS.FOR_UT.map(function(miscUt) {
              if (miscUt.toLowerCase() === stateName.toLowerCase()) {
                stateType = CrimesState[4];
              }
            });

            return {
              type: stateType,
              name: stateName
            };
          },
          crimeInfo: function(data, fields) {
            return {
              type: fields[1].label,
              label: data[1],
              byMaleBelow18Y: {
                label: fields[2].label,
                value: data[2]
              },
              byMaleBetween18To30Y: {
                label: fields[4].label,
                value: data[4]
              },
              byMaleBetween30To45Y: {
                label: fields[6].label,
                value: data[6]
              },
              byMaleBetween45To60Y: {
                label: fields[8].label,
                value: data[8]
              },
              byMaleAbove60Y: {
                label: fields[10].label,
                value: data[10]
              }
            };
          }
        };

        const _objectBasedMap = (objectMap) =>
          (dataList, fieldList) =>
            dataList.map((data, index) =>
              Object.keys(objectMap).reduce((memo, key) => {
                memo[key] = objectMap[key].apply(objectMap, [data, fieldList, index]);
                  return memo;
              }, {}));

        const _simpleData = _objectBasedMap(StateCrimesModel);

        me.getCrimeData = function() {

            let xhr = new XMLHttpRequest();
            xhr.open('GET', _apiUrl);
            xhr.setRequestHeader('Accept', 'application/json');
            xhr.send(null);

            xhr.onreadystatechange = function() {
                const DONE = 4;
                const OK = 200;
                if (xhr.readyState === DONE) {
                    if (xhr.status === OK) {
                        const response = JSON.parse(xhr.responseText);
                        me.crimesData = _simpleData(response.data, response.fields);
                        // me.accidentsClass = new AccidentInCitiesData(me.accidentsData);
                        me.setChartOptions();
                        me._barComponent = new BarChartComponent(me.chartOptions);
                        me._barComponent.waitingForChartData();
                    }
                }
            };

        };

        me.setChartOptions = function() {
            clearChartOptions();
            let filteredData = me.getFilteredDataByStateAndTotalCrime();

            me.setChartDataLabels(filteredData);
            me.setChartDataSets(filteredData);
        };

        me.getFilteredDataByStateAndTotalCrime = () => {
          return me.crimesData.filter(function (obj) {
            return obj.stateInfo.type === CrimesState[1] && obj.crimeInfo.label === MISC_KEYWORDS.FOR_CRIMES[0];
          });
        }

        function clearChartOptions() {
          me.chartOptions.chartDataLabels.length = 0;
          me.chartOptions.chartDataSets.length = 0;
        }

        me.setChartDataLabels = (filteredData) => {
            let STATES_ARRAY = Object.keys(filteredData).map(val => filteredData[val].stateInfo.name);
            this.chartOptions.chartDataLabels.push(STATES_ARRAY);
        }

        me.setChartDataSets = function(filteredData) {
          let CRIME_BY_MALE_BELOW_18Y = Object.keys(filteredData).map(val => filteredData[val].crimeInfo.byMaleBelow18Y.value);
          let ds1 = {
            label: filteredData[0].crimeInfo.byMaleBelow18Y.label,
            data: CRIME_BY_MALE_BELOW_18Y,
            backgroundColor: 'rgba(255,99,132,1)'
          };
          this.chartOptions.chartDataSets.push(ds1);

          let CRIME_BY_MALE_BETWEEN_18TO30Y = Object.keys(filteredData).map(val => filteredData[val].crimeInfo.byMaleBetween18To30Y.value);
          let ds2 = {
            label: filteredData[0].crimeInfo.byMaleBetween18To30Y.label,
            data: CRIME_BY_MALE_BETWEEN_18TO30Y,
            backgroundColor: 'rgba(234, 124, 58, 1)'
          };
          this.chartOptions.chartDataSets.push(ds2);

          let CRIME_BY_MALE_BETWEEN_30TO45Y = Object.keys(filteredData).map(val => filteredData[val].crimeInfo.byMaleBetween30To45Y.value);
          let ds3 = {
            label: filteredData[0].crimeInfo.byMaleBetween30To45Y.label,
            data: CRIME_BY_MALE_BETWEEN_30TO45Y,
            backgroundColor: 'rgba(111, 113, 114, 1)'
          };
          this.chartOptions.chartDataSets.push(ds3);

          let CRIME_BY_MALE_BETWEEN_45TO60Y = Object.keys(filteredData).map(val => filteredData[val].crimeInfo.byMaleBetween45To60Y.value);
          let ds4 = {
            label: filteredData[0].crimeInfo.byMaleBetween45To60Y.label,
            data: CRIME_BY_MALE_BETWEEN_45TO60Y,
            backgroundColor: 'rgba(252, 190, 42, 1)'
          };
          this.chartOptions.chartDataSets.push(ds4);

          let CRIME_BY_MALE_ABOVE_60Y = Object.keys(filteredData).map(val => filteredData[val].crimeInfo.byMaleAbove60Y.value);
          let ds5 = {
            label: filteredData[0].crimeInfo.byMaleAbove60Y.label,
            data: CRIME_BY_MALE_ABOVE_60Y,
            backgroundColor: 'rgba(68, 113, 192, 1)'
          };
          this.chartOptions.chartDataSets.push(ds5);
        };

    }

    function BarChartComponent({chartTitle, chartDataSets, chartDataLabels}) {

        var me = this;
        me.chartWrapper = document.getElementsByClassName('bar-chart')[0];

        function _initBarChartOptions() {
            Chart.defaults.global.elements.rectangle.borderWidth = 0;
            Chart.defaults.global.maintainAspectRatio = false;
        };

        me.waitingForChartData = function () {
            _initBarChartOptions();
            if (chartDataLabels.length > 0) {
                createBarChart();
            }
        };

        function createBarChart() {
            let ctx = me.chartWrapper.getContext('2d');
            me.barChart = new Chart(ctx, {
                type: 'bar',
                data: {
                    labels: chartDataLabels[0],
                    datasets: chartDataSets
                },
                options: {
                    title: {
                        display: true,
                        text: chartTitle
                    },
                    legend: {
                        position: 'bottom',
                        labels: {
                            fontColor: 'rgb(0, 0, 0)',
                            boxWidth: 20
                        }
                    },
                    scales: {
                        yAxes: [
                            {
                                ticks: {
                                    beginAtZero: true
                                }
                            }
                        ],
                        xAxes: [
                            {
                                categoryPercentage: 1,
                                barPercentage: 0.5
                            }
                        ]
                    }
                }
            });
        }

        return me;

    }

    var crimeComponent = new CrimesComponent();

    return {getCrimeData: crimeComponent.getCrimeData};

})();

export default CrimesChartModule;
