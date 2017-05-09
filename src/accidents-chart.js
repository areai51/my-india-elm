//----------SERVICE-----------
const AccidentsChartModule = (function() {

    let Chart = require('chart.js/src/chart.js');

    function AccidentInCitiesComponent() {

        const me = this;

        me.chartOptions = {
            chartTitle: 'Fatal Accidents',
            chartDataLabels: [],
            chartDataSets: []
        };

        // me._barComponent = new BarChartComponent();

        const _apiUrl = 'https://data.gov.in/node/735301/datastore/export/json';

        const AccidentInCitiesModel = {
            id: function(data, fields, index) {
                return index;
            },
            dataInfo: function(data, fields, index) {
                let info = {};

                if (fields) {
                    for (let i = 0; i < fields.length; i++) {
                        info['label_' + i] = fields[i].label;
                        info['data_' + i] = data[i];
                    }
                }

                return info;
            },
            cityName: function(data, fields, index) {
                let city = this.dataInfo(data, fields, index);
                return city.data_0;
            }
        };

        const _objectBasedMap = (objectMap) => (dataList, fieldList) => dataList.map((data, index) => Object.keys(objectMap).reduce((memo, key) => {
            memo[key] = objectMap[key].apply(objectMap, [data, fieldList, index]);
            return memo;
        }, {}));

        const _simpleData = _objectBasedMap(AccidentInCitiesModel);

        me.getAccidentData = function() {

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
                        me.accidentsData = _simpleData(response.data, response.fields);
                        me.accidentsClass = new AccidentInCitiesData(me.accidentsData);
                        me.setChartOptions();
                        me._barComponent = new BarChartComponent(me.chartOptions);
                        me._barComponent.waitingForChartData();
                    }
                }
            };

        };

        me.setChartOptions = function() {
            clearChartOptions();
            let CITIES_ARRAY = me.accidentsClass.getTotalCities();
            me.chartOptions.chartDataLabels.push(CITIES_ARRAY);

            me.setChartDataSets();
        };

        function clearChartOptions() {
          me.chartOptions.chartDataLabels.length = 0;
          me.chartOptions.chartDataSets.length = 0;
        }

        me.setChartDataSets = function() {
            let ds1 = {
                label: this.accidentsClass.getLabelsForFatalAccidentsByYear().y2011,
                data: this.accidentsClass.getTotalFatalAccidents2011(),
                backgroundColor: 'rgba(234, 124, 58, 1)'
            };
            me.chartOptions.chartDataSets.push(ds1);

            let ds2 = {
                label: this.accidentsClass.getLabelsForFatalAccidentsByYear().y2012,
                data: this.accidentsClass.getTotalFatalAccidents2012(),
                backgroundColor: 'rgba(252, 190, 42, 1)'
            };
            me.chartOptions.chartDataSets.push(ds2);

            let ds3 = {
                label: this.accidentsClass.getLabelsForFatalAccidentsByYear().y2013,
                data: this.accidentsClass.getTotalFatalAccidents2013(),
                backgroundColor: 'rgba(68, 113, 192, 1)'
            };
            me.chartOptions.chartDataSets.push(ds3);

            let ds4 = {
                label: this.accidentsClass.getLabelsForFatalAccidentsByYear().y2014,
                data: this.accidentsClass.getTotalFatalAccidents2014(),
                backgroundColor: 'rgba(112,170,75,1)'
            };
            me.chartOptions.chartDataSets.push(ds4);
        };

    }

    function AccidentInCitiesData(_accidentInCitiesData) {

        this._accidentInCitiesData = _accidentInCitiesData;

        this.getTotalCities = function() {
            return Object.keys(this._accidentInCitiesData).map(val => {
                return this._accidentInCitiesData[val].cityName;
            });
        };

        this.getLabelsForFatalAccidentsByYear = function() {
            let year = {};

            year['y2011'] = this._accidentInCitiesData[0].dataInfo.label_1;
            year['y2012'] = this._accidentInCitiesData[0].dataInfo.label_5;
            year['y2013'] = this._accidentInCitiesData[0].dataInfo.label_9;
            year['y2014'] = this._accidentInCitiesData[0].dataInfo.label_14;

            return year;
        };

        this.getLabelsForTotalAccidentsByYear = function() {
            let year = {};

            year['y2011'] = this._accidentInCitiesData[0].dataInfo.label_2;
            year['y2012'] = this._accidentInCitiesData[0].dataInfo.label_6;
            year['y2013'] = this._accidentInCitiesData[0].dataInfo.label_10;
            year['y2014'] = this._accidentInCitiesData[0].dataInfo.label_18;

            return year;
        };

        this.getTotalFatalAccidents2011 = function() {
            return Object.keys(this._accidentInCitiesData).map(val => {
                return this._accidentInCitiesData[val].dataInfo.data_1;
            });
        };

        this.getTotalAccidents2011 = function() {
            return Object.keys(this._accidentInCitiesData).map(val => {
                return this._accidentInCitiesData[val].dataInfo.data_2;
            });
        };

        this.getTotalFatalAccidents2012 = function() {
            return Object.keys(this._accidentInCitiesData).map(val => {
                return this._accidentInCitiesData[val].dataInfo.data_5;
            });
        };

        this.getTotalAccidents2012 = function() {
            return Object.keys(this._accidentInCitiesData).map(val => {
                return this._accidentInCitiesData[val].dataInfo.data_6;
            });
        };

        this.getTotalFatalAccidents2013 = function() {
            return Object.keys(this._accidentInCitiesData).map(val => {
                return this._accidentInCitiesData[val].dataInfo.data_9;
            });
        };

        this.getTotalAccidents2013 = function() {
            return Object.keys(this._accidentInCitiesData).map(val => {
                return this._accidentInCitiesData[val].dataInfo.data_10;
            });
        };

        this.getTotalFatalAccidents2014 = function() {
            return Object.keys(this._accidentInCitiesData).map(val => {
                return this._accidentInCitiesData[val].dataInfo.data_14;
            });
        };

        this.getTotalAccidents2014 = function() {
            return Object.keys(this._accidentInCitiesData).map(val => {
                return this._accidentInCitiesData[val].dataInfo.data_18;
            });
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

    var accidentComponent = new AccidentInCitiesComponent();

    return {getAccidentData: accidentComponent.getAccidentData};

})();

export default AccidentsChartModule;
