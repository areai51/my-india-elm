//----------SERVICE-----------
const AccidentsChartModule = (function () {
    
    const _apiUrl = 'https://data.gov.in/node/735301/datastore/export/json';
	
	const AccidentInCitiesModel = {
	  id: function (data, fields, index) {
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
	
	const _objectBasedMap = (objectMap) =>
    (dataList, fieldList) =>
      dataList.map((data, index) =>
        Object.keys(objectMap).reduce((memo, key) => {
          memo[key] = objectMap[key].apply(objectMap, [data, fieldList, index]);
            return memo;
        }, {}));
	
	const _simpleData = _objectBasedMap(AccidentInCitiesModel);
    
    const getAccidentData = function (callback) {
        
        let xhr = new XMLHttpRequest();
        xhr.open('GET', _apiUrl);
		xhr.setRequestHeader('Accept', 'application/json');
        xhr.send(null);
        
        xhr.onreadystatechange = function () {
          const DONE = 4;
          const OK = 200;
          if (xhr.readyState === DONE) {
            if (xhr.status === OK) {
			  const response = JSON.parse(xhr.responseText);
			  console.log(_simpleData(response.data, response.fields));
            }
          }
        };
        
    };
    
  return {
    getAccidentData: getAccidentData
  };

})();

export default AccidentsChartModule;
