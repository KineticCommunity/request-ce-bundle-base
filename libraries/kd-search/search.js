/**
KD-Search CE

**Completed 1/18/2016 Brian Peterson
- Clear Table and List before updating data within them.  Use case: search is performed a second time without clearing the results from first search.

**Completed 2/11/2016
- Added clearOnClick functionality and functions to Bridge parameters
- Changed how the list elements are created to better support use in IE

**TODO
- clear table and list when performing search.  Currently results stay when running the search.  IE one results returned in second search.
- Is there an equivilant to BUNDLE.config.commonTemplateId
- How is the templateId (Slug) provided to the Bridge?

**/
(function($) {
    // create the KDSearch global object
    KDSearch = typeof KDSearch == "undefined" ? {} : KDSearch;
    // Create a scoped alias to simplify references
    var search = KDSearch;
   
    /**
     * Define default properties for the Search configurations
     * Reduces need to include all properties in a search configuration.  
     * Each Search config my overide these values by including a value of its own.
     * execute: {Function} Function which will execute the search
     * Other properties are used by Datatables.net or its Responsive Plugin.
     */
    /* Define default properties for defaultsBridgeDataTable object. */
    var defaultsBridgeDataTable = {
        execute: performBridgeRequestDataTable,
		resultsContainer : '<table cellspacing="0" class="table dataTable table-striped table-bordered nowrap dtr-inline">',
        bridgeConfig:{
//			templateId: BUNDLE.config.commonTemplateId
		},
		// Properties specific to DataTables
		paging: true,
        info: true,
        searching: true,
		responsive: {
            details: {
                type: 'column',
            }
		},
    };
    
    /* Define default properties for defaultsBridgeList object. */
    var defaultsBridgeList = {
        execute: performBridgeRequestList,
		resultsContainer : '<div>',
    };
   

    /**
     * Executes the search for the configured search object.
     * @param {Obj} Search configuration object.
	 * @param {Ojb} Configuration object to over ride first param.
     */
	search.executeSearch = function(searchObj1, searchObj2) {
		var configObj=$.extend( true, {}, searchObj1, searchObj2 );
		configObj = search.initialize(configObj);
		if(configObj.execute){
			configObj.execute();
		}	
    };

    /**
     * Initialize the searchConfig Object 
     * @param {Object} Configuration object(s)
     */
    search.initialize = function(obj){
        // Initialize each the configurations based on the type property 
            if(obj.type=="BridgeDataTable"){
                // Entend defaults into the configuration
                obj=$.extend( {}, defaultsBridgeDataTable, obj );
                // Create a table element for Datatables and add to DOM
				obj=initializeResultsContainer(obj);  
            }
            else if(obj.type=="BridgeList"){
                // Entend defaults into the configuration
                obj=$.extend( {}, defaultsBridgeList, obj );
                // Create a results element for Datatables and add to DOM
				obj=initializeResultsContainer(obj); 
            }
			return obj
    }
	
    /**
     * Used to execute objects configured as defaultBridgeDataTable
     */
     function performBridgeRequestDataTable(){
		var configObj = this;
		if(configObj.before){configObj.before();};
		convertDataToColumns(configObj);
		//Retrieve and set the Bridge parameter values using JQuery
        var parameters = {};
		$.each(configObj.bridgeConfig.parameters, function(i,v){
            if(typeof v == "function"){
				parameters[i] = v();
			}
			if(typeof v == "string"){
				parameters[i]=$(configObj.bridgeConfig.parameters[i]).val();
			}
		});
		// Retrieve Bridge Search Attributes from Search Object
		if(typeof configObj.bridgeConfig.attributes == "undefined"){
			configObj.bridgeConfig.attributes = [];
			$.each(configObj.data, function( k, v ){
				configObj.bridgeConfig.attributes.push(k)
			})
		}
//        var templateId = (configObj.bridgeConfig.templateId && configObj.bridgeConfig.templateId!="null") ? configObj.bridgeConfig.templateId : clientManager.templateId;
        //create the connector necessary to connect to the bridge
//        var connector = new KD.bridges.BridgeConnector({templateId: templateId});
		K('bridgedResource['+configObj.bridgeConfig.model+']')	.load({
			attributes: configObj.bridgeConfig.attributes, 
			values: parameters,
			success: function(response) {
				configObj.dataArray = [];
				configObj.response=response;
				if($(configObj.response).size() > 0 || !configObj.success_empty){
					// Execute success callback
					if(configObj.success){configObj.success();}
					// Only one record returned
					if(typeof configObj.processSingleResult != "undefined" && configObj.processSingleResult && $(configObj.response).size() == 1){
						var resultsObj = {};
						// Iterate through the data configuration of the search object
						$.each(configObj.data, function( k, v ){
							// Check for Bridge Search response that correlates to the key
							if (configObj.response.constructor == Object){  // result from single Bridge
								var objVal = configObj.response[k];
							}
							else if (configObj.response.constructor == Array){  // result from multiple Bridge
								var objVal = configObj.response[0][k];
							}
							else{
								var objVal = '';
							}
							resultsObj[k] = objVal;
						});
						setValuesFromResults(configObj.data, resultsObj);
						if(configObj.clickCallback){configObj.clickCallback(resultsObj);}
					}
					// More than 1 record returned
					else if(typeof configObj.processSingleResult == "undefined" || !configObj.processSingleResult || $(configObj.response).size() > 1){    
						//Iterate through row results to retrieve data
						$.each(configObj.response, function(i,record){
							var obj = {};
							//Iterate through the configured columns to match with data returned from bridge
							$.each(configObj.data, function(attribute, attributeObject){
								if (typeof record[attribute] != "undefined"){
									if (attributeObject["date"] == true && typeof attributeObject["moment"] != "undefined") {
										var attributeValue = moment(record[attribute]).format(attributeObject["moment"]);
									} else {
										var attributeValue = record[attribute];
									}
								}
								else{
									var attributeValue = '';
								}
								obj[attribute] = attributeValue;
							});
							configObj.dataArray.push(obj);
						});
						// Append Column to beginning of table contain row expansion for responsive Plugin
						if(configObj.responsive){
							configObj.columns.unshift({
								defaultContent: '',
								className: 'control',
								orderable: false,
							});
						}
						// Create DataTable Object.
						createDataTable(configObj);
					}
				}				
				// No records returned
				else{
					if(configObj.success_empty){configObj.success_empty();}
				}
				if(configObj.complete){configObj.complete();}
			},
			error: function(response) {
				if(configObj.error){configObj.error();}
				if(configObj.complete){configObj.complete();}
			}
		});
													
    }	

    /**
     * Used to execute objects configured as defaultBridgeList
     */
    function performBridgeRequestList(){
        var configObj = this;
		if(configObj.before){configObj.before();};
        //Retrieve and set the Bridge parameter values using JQuery
        var parameters = {};
		$.each(configObj.bridgeConfig.parameters, function(i,v){
            if(typeof v == "function"){
				parameters[i] = v();
			}
			if(typeof v == "string"){
				parameters[i]=$(configObj.bridgeConfig.parameters[i]).val();
			}
		});
		// Retrieve Bridge Search Attributes from Search Object
		if(typeof configObj.bridgeConfig.attributes == "undefined"){
			configObj.bridgeConfig.attributes = [];
			$.each(configObj.data, function( k, v ){
				configObj.bridgeConfig.attributes.push(k)
			})
		}
//        var templateId = (configObj.bridgeConfig.templateId && configObj.bridgeConfig.templateId!="null") ? configObj.bridgeConfig.templateId : clientManager.templateId;
        //create the connector necessary to connect to the bridge
//        var connector = new KD.bridges.BridgeConnector({templateId: templateId});
		K('bridgedResource['+configObj.bridgeConfig.model+']')	.load({
			attributes: configObj.bridgeConfig.attributes, 
			values: parameters,
			success: function(response) {
					configObj.response=response;
					if($(configObj.response).size() > 0 || !configObj.success_empty){
						// Execute success callback
						if(configObj.success){configObj.success();}
	       				// Only one record returned
						if(typeof configObj.processSingleResult != "undefined" && configObj.processSingleResult && $(configObj.response).size() == 1 && configObj.response != null){
							if (configObj.response.constructor == Object){  // result from single Bridge
								var objVal = configObj.response;
							}
							else if (configObj.response.constructor == Array){  // result from multiple Bridge
								var objVal = configObj.response[0];
							}
							setValuesFromResults(configObj.data, objVal);
						}
	       				// More than one record returned
	       				else if(typeof configObj.processSingleResult == "undefined" || !configObj.processSingleResult || ($(configObj.response).size() > 1 && configObj.response != null)){    
							this.$resultsList = $('<ul/>').attr('id','resultList');
							var self = this; // reference to this in current scope
							//Iterate through row results to retrieve data
	                        $.each(configObj.response, function(i,record){
								self.$singleResult = $('<li/>').attr('id', 'result');
								//Iterate through the configured columns to match with data returned from bridge
	                            $.each(configObj.data, function(attribute, attributeObject){
									if (typeof record[attribute] != "undefined"){
	                                    var title ="";
										if(attributeObject["title"]){
											var $title = $('<div/>').addClass("title " + attributeObject['className']).html(attributeObject["title"]);
											self.$singleResult.append($title);
										}
										if (attributeObject["date"] == true && typeof attributeObject["moment"] != "undefined") {
	                                        var attributeValue = moment(record[attribute]).format(attributeObject["moment"]);
	                                    } else {
											var $value = $('<div/>').addClass(attributeObject['className']).html(attributeValue);
											self.$singleResult.append($value); 
											self.$singleResult.data(attribute,record[attribute])
	                                    }
	                                }

								});
								self.$resultsList.append(self.$singleResult);
	                        });
							$("#"+configObj.resultsContainerId).empty().append(this.$resultsList);
							$("#"+configObj.resultsContainerId).off().on( "click", 'li', function(event){
								setValuesFromResults(configObj.data, $(this).data());
								if(configObj.clickCallback){configObj.clickCallback($(this).data());};
								if(configObj.clearOnClick || typeof configObj.clearOnClick == "undefined"){
									$("#"+configObj.resultsContainerId).empty();
								}
							});
	                    }
					}
					else{
						if(configObj.success_empty){configObj.success_empty();}
					} 
					if(configObj.complete){configObj.complete();}
                },
				error: function(response){
					if(configObj.error){configObj.error();}
					if(configObj.complete){configObj.complete();}
				}
            }); 
    }
 
    
    /**
     * Code in kd_client.js is preventing the backspace from working on $('.dataTables_filter input'). stopPropigation allows backspace to work.  
     */
    $('body').on('keydown', '.dataTables_filter input', function( event ) {
      event.stopPropagation();
    });
    
   	/****************************************************************************
								PRIVATE HELPERS / SHARED FUNCTIONS							   
	****************************************************************************/

	/**
	* Set Values from selected row
	* @params {Object} data config object
	* @params {Object} data returned from selection.
	*/
    function setValuesFromResults(configData, results){ //rowCallback
        $.each(configData, function( k, v){
			var field = K('field['+v["setField"]+']');
            if(v["setField"]!="" && typeof v["setField"] != "undefined" && field){
				field.value(results[k]);
            }
			// If callback property exists
			if(v.callback){v.callback(results[k]);}
        });
    }

    /**
     * Returns Search Object
	 * Creates resultsContainer and adds it to DOM based on Search Config
     * @param {Object} Search Object
     */	
	function initializeResultsContainer(obj){
		if($("#"+obj.resultsContainerId).length == 0){
			// Create resultsContainer
			if(typeof obj.resultsContainer == "string"){ // if string
				obj.resultsContainer = $(obj.resultsContainer).attr('id',obj.resultsContainerId);
			}
			else if(typeof obj.resultsContainer == "function"){ // if function
				obj.resultsContainer = obj.resultsContainer().attr('id',obj.resultsContainerId);
			}
			// Append to DOM
			if(obj.appendTo instanceof $){ // if jQuery Obj
				obj.appendTo.append(obj.resultsContainer);
			}
			else if(typeof obj.appendTo == "string"){ // if string
				obj.appendTo = $(obj.appendTo).appendTo(obj.resultsContainer);
			}
			else if(typeof obj.appendTo == "function"){ // if function
				obj.appendTo = obj.appendTo().append(obj.resultsContainer);
			}
			return obj;
		}
		return obj;
	}
	
	/**
     * Returns object containing data from row
     * @param {Object} table
	 * @param {Object} row 
     */
	function dataTableRowToObj(table, row){
		var selectedRow = $(row).closest('tr');		
		return table.row(selectedRow).data();
	}


	/**
	* Convert the "data" property into "columns", necessary for DataTables.
	* @param {Object} Search Object to convert
	*/
	function convertDataToColumns(obj){
		obj.columns = [];		
		$.each(obj.data, function(attribute, attributeObject){
			attributeObject["data"] = attribute;
			obj.columns.push(attributeObject)
		});
    }
	
	/**
	* Create a TableTable using a Search Object
	* @param {Object} Search Object used to create the DataTable
	*/
	function createDataTable(configObj){
		// Set property to destroy any DataTable which may already exist.
		configObj.destroy = true;
		configObj.tableObj = $('#'+configObj.resultsContainerId).DataTable( configObj );
		configObj.tableObj.rows.add(configObj.dataArray).draw();
		// Bind Click Event based on where the select attribute extists ie:<tr> or <td>
		$('#'+configObj.resultsContainerId).off().on( "click", 'td', function(event){
			// Ensure user has not clicked on an element with control class used by the responsive plugin to expand info
			if(!$(this).hasClass('control')){
				// Get closest row which is a parent row.
				var row = $(this).closest('tr');
				if(row.hasClass('child')){
					row = row.prev('tr.parent')
				}
				// Convert selected row into a Results Obj 
				var resultsObj = dataTableRowToObj(configObj.tableObj, row);
				// Set results based on Search config
				setValuesFromResults(configObj.data, resultsObj);
				if(configObj.clickCallback){configObj.clickCallback(resultsObj);}
				// Destroy DataTable and empty container in case columns change.
				configObj.tableObj.destroy();
				if(configObj.clearOnClick || typeof configObj.clearOnClick == "undefined"){
					$('#'+configObj.resultsContainerId).empty();
				}
			}
		});
	}
	
	/****************************************************************************
								PUBlIC FUNCTIONS							   
	****************************************************************************/
	
	/**
    * Returns string with uppercase first letter
    * @param {String} Value to be give uppercase letter
    */
    search.ucFirst = function(str){
        var firstLetter = str.substr(0, 1);
        return firstLetter.toUpperCase() + str.substr(1);
    }
})(jQuery);
