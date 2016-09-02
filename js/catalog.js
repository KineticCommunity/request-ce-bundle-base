/**
 * Forms Search using Twitter Typeahead. Prefetch all accessible forms
 * for the Kapp.
**/

(function($, moment, _){
    // UTILITY METHODS

    /**
     * Returns an Object with keys/values for each of the url parameters.
     *
     * @returns {Object}
     */
    bundle.getUrlParameters = function() {
       var searchString = window.location.search.substring(1), params = searchString.split("&"), hash = {};
       for (var i = 0; i < params.length; i++) {
         var val = params[i].split("=");
         hash[unescape(val[0])] = unescape(val[1]);
       }
       return hash;
    };

    var locale = window.navigator.userLanguage || window.navigator.language;
    moment.locale(locale);
    $(function(){
      if (!$('.navbar-form .typeahead').length){
        return;
      }
      var matcher = function(strs) {
        return function findMatches(query, callback) {
            var matches, substringRegex;
            matches = [];
            substrRegex = new RegExp(query, 'i');
            $.each(strs, function(i, str) {
              if (substrRegex.test(str)) {
                matches.push(str);
              }
            });
            callback(matches);
        };
      };
      var formNames = [];
      var forms = {};
      $.get(window.bundle.apiLocation() + "/kapps/" + window.bundle.kappSlug() + "/forms", function( data ) {
        forms = data.forms;
        $.each(forms, function(i,val) {
          formNames.push(val.name);
          forms[val.name] = val;
        });
      });
      $('.navbar-form .typeahead').typeahead({
          highlight:true
        },{
          name: 'forms',
          source: matcher(formNames),
        }).bind('typeahead:select', function(ev, suggestion) {
          window.location.replace(window.bundle.kappLocation() + "/" + forms[suggestion].slug)
      });
    });

    $(function(){
        var currentId = bundle.getUrlParameters().page;

        if (currentId === 'approvals'){
            renderTable({
                table: '#approvalTable',
                jsonFileName: 'tableRecords.json',
                type: 'Approval',
                coreState: ['Draft','Submitted'],
                length: 1000,
                serverSide: false,
            });
        }
        if(currentId === 'requests'){
            renderTable({
                table: '#requestsTable',
                jsonFileName: 'tableRecords.json',
                type: 'Service',
                excludeTypes: ['Template','Approval'],
                coreState: ['Draft','Submitted'],
                length: 1000,
                serverSide: false,
            });
        }
        if(currentId == 'closed'){
            $('#closedTable').removeData('pageTokens');
            renderTable({
                table: '#closedTable',
                jsonFileName: 'paginatedRecords.json',
                coreState: ['Closed'],
                length: 10,
                serverSide: true,
            });
        }

        /* We are using the page load to set some visual cues so the user know what tab they are on
         */
        if(currentId === undefined){
            $('#home').addClass('active');
        }else{
            $('#'+currentId).addClass('active');
            var currentIdPosition = $('#'+currentId).position();
            if(currentIdPosition){
                $('#tab-nav').scrollLeft($('#'+currentId).position().left);
            }
        }
    });
    function renderTable(options){
        $.ajax({
            method: 'get',
            url: buildAjaxUrl(options),
            dataType: "json",
            contentType: 'application/json',
            success: function(data, textStatus, jqXHR){
                $.fn.dataTable.moment('MMMM Do YYYY, h:mm:ss A');
                records = $.extend(data, {
                    responsive: {breakpoints: [
                        { name: 'desktop', width: Infinity },
                        { name: 'tablet',  width: 1024 },
                        { name: 'fablet',  width: 768 },
                        { name: 'phone',   width: 480 }
                    ]},
                    "destroy": true,
                    "order": [[ 0, "desc" ]],
                    "bSort": options.serverSide ? false : true,
                    "pagingType": options.serverSide ? "simple" : "simple_numbers",
                    "dom": options.serverSide ? '<"top"l><"dataTables_datRange">t<"bottom"p><"clear">' : 'l<"dataTables_dateRange">ftip',
                    "language": {"search":""},
                    "pageLength": options.serverSide ? options.length : 10,
                    "createdRow": function (row, data) {
                        $(row).find('td.data-moment').each(function(index, td) {
                            $(td).text(moment($(td).text()).format('MMMM Do YYYY, h:mm:ss A'));
                        });
                        $(row).find('td.data-link').each(function(index, td) {
                            if(data.State == "Draft"){
                                $(td).html("<a href='"+window.bundle.spaceLocation()+"/submissions/"+data.Id+"'>"+data.Submission+"</a>");
                            }else{
                                $(td).html("<a href='"+window.bundle.kappLocation()+"?page=submission&id="+data.Id+"'>"+data.Submission+"</a>");
                            }
                        });
                    },
                });
                var table = $(options.table).DataTable(records);

                /* After the table has been built we are adding an html element that has a dropdown list so that a user can select a number of days back
                 * to retrieve the list from.
                 */
                addSegmentedControls(options)
                if(options.serverSide){
                    serverOptions(options,data);
                }
            },
            complete: function(){
                $('.dataTables_filter input').addClass('form-control');
                $('.dataTables_filter input').attr('placeholder', 'Filter...');
            }
        });
    }
    /* This fucntion builds a Url to be used by the ajax call.
     * The intention is to pass parameters to this function to make the url configurable.
     * This gives the ability to use the same piece of code to configure multiple queries.
    */

    function buildAjaxUrl(options){
        var url = bundle.kappLocation() + "?partial=" +options.jsonFileName;
        if(options.type === 'Approval'){
            url += '&values[Assigned Individual]='+identity;
        }else{
            url += '&createdBy='+identity+'&requestedFor='+identity;
        }
        if(options.coreState !== undefined){
            $.each(options.coreState, function(k,v){
                url += '&coreState='+v;
            });
        }
        if(options.excludeTypes !== undefined){
            $.each(options.excludeTypes, function(k,v){
                url += '&excludeTypes='+v;
            });
        }
        if(options.type !== undefined){
            url += '&type='+options.type;
        }
        if(options.start !== undefined){
            url += '&start=' + options.start;
        }
        if(options.length !== undefined){
            url += '&limit=' + options.length;
        }
        if(options.token && options.token() !== undefined){
            url += '&pageToken='+options.token();
        }
        if(options.end !== undefined && options.end !== null){
            url += '&end='+options.end;
        }
        return url;
    }

    function addSegmentedControls(options){
        /* We use the DOM: property in dataTables to create the div.dataTables_dateRange element.
         * Then we build up the html.  We are using a Jquery plugin to render a segmented control to the dom.
         */
        $('div.dataTables_dateRange').html('<select class="segment-select"><option value="1">1 year</option><option value="2">Custom</option><option value="3">View All</option></select>');
       
        /* This is required to initialize the Jquery Plugin "Segmented Control" */
        $(".segment-select").Segment();
        
        addDateRangeDropdown();
                               
        /* The active state to be re-added to the correct segment of the segmented controls every time the table is rebuild.
         * We remove the active state from the defult option.
         */
        if(options.state !== undefined){
            $('[data-segment] .option').removeClass('active')
            $('[data-segment] .option[value="'+options.state+'"]').addClass('active');
        }
        /* On click of a segmented control we set the value of the selected segement to a state variable on our options object.
         */
        $('[data-segment]').on('click',function(){
            options.state = $('[data-segment] .active').attr('value');
            /* When a new option is selected we rebuild the table.  We have to delete the old tokens from the object and remove the data-nextPageTokens attribute.
             * We do this so that the token store is clear and the display of the Previous and Next button behaves correctly if we are displaying the table with server-side pagination
             */
            if(options.state === "1"){
                delete options.token;
                $(options.table).removeData('nextPageTokens');
                renderTable($.extend({},options,{
                    start: moment().subtract(1,"year").format(),
                }));
            }else if(options.state === "2"){
                $('#get-date-range').off().on('click',function(){
                    if($('#date_timepicker_start').val() !== ""){
                        renderTable($.extend({},options,{
                            start: $('#date_timepicker_start').val() ? new Date($('#date_timepicker_start').val()).toISOString() : null,
                            end: $('#date_timepicker_end').val() ? new Date($('#date_timepicker_end').val()).toISOString() : null
                        }));
                    }else{
                        $('.date-range li').notifie({type:'alert',severity:'info',message:'A start date is Required.'});
                    }
                });
            }else if(options.state === "3"){
                delete options.token;
                $(options.table).removeData('nextPageTokens');
                renderTable($.extend({},options,{
                    start: "",
                }));
            }
        });

    }
    
    /* Split out the logic to build up a dropdown menu for selecting a date range for submissions to display in the dataTable.
     * This would have been much cleaner with BootStrap 4.
     */
    function addDateRangeDropdown(){
        
        /* The Jquery plugin "Segmented Controls" adds the controls to the DOM dynamically so we need to add the dropdown class after they have been rendered.
         * We also add the ul that will be the dropdown menu to the appropriate segment.
         * To prevent the menu from closing when the DatePickers are selected we have to override the toggle behavior.
         */
        $('[data-segment]').addClass('dropdown');
        $('[data-segment] .option[value="2"]').attr('id','custom-date-range')
                                              .addClass('dropdown-toggle')
                                              .after('<ul class="dropdown-menu date-range" aria-labelledby="custom-date-range"><li><p><input placeholder="Starting Date" id="date_timepicker_start" type="text" value=""><input placeholder="Ending Date" id="date_timepicker_end" type="text" value=""><input value="Go" id="get-date-range" type="button" class="btn btn-default"></p></li></ul>')
                                              .on('click', function(){
                                                $('#custom-date-range').parent().toggleClass('open')
                                              });
                                              
        /* This listener is checking to see if there is a click event outside of the dropdown menu so that it can close the menu.
         */                                      
        $('body').on('click', function (e) {
            if (!$('div.ui-segment.dropdown').is(e.target) 
                && $('div.ui-segment.dropdown').has(e.target).length === 0 
                && $('.open').has(e.target).length === 0
            ) {
                $('div.ui-segment.dropdown').removeClass('open');
            }
        });
        
        /* This builds the start and end calanders that open when the Start and End Date inputs are clicked. */
        jQuery('#date_timepicker_start').datetimepicker({
            format:'Y/m/d',
            onShow:function( ct ){
                this.setOptions({
                    maxDate:jQuery('#date_timepicker_end').val()?jQuery('#date_timepicker_end').val():false
                })
            },
            timepicker:false
        });
        jQuery('#date_timepicker_end').datetimepicker({
            format:'Y/m/d',
            onShow:function( ct ){
                this.setOptions({
                    minDate:jQuery('#date_timepicker_start').val()?jQuery('#date_timepicker_start').val():false
                })
            },
            timepicker:false
        });
    }

    /*  This code is to override dataTables default behavior.
     *  This is done because dataTables uses an offset token for pagination but core does has the concept of page tokens.
    */
    function serverOptions(options,data){
        // For server side pagination we are collecting the nextpagetoken metadata that is attached to submissions return object.
        // The token is added to an array that is attached to the table elements data property.
        if ($(options.table).data('nextPageTokens') === undefined) {
            $(options.table).data('nextPageTokens', []);
        }
        $(options.table).data('nextPageTokens').push(data.nextPageToken);
        var arr = $(options.table).data('nextPageTokens');
        var token = _.last(arr);

        /*  If the table DOM element has a 'nextPageTokens' data attribute array that has a token in it then we remove the disabled class from the Next button.
         *  When the Next button is clicked the current object is extended to add the next page token (of the next page) parameter that will be appended to the URL.
         */
        if(token !== ''){
            $(options.table+'_next').removeClass('disabled');
            // Add click event to next button, if serverSide property is set to true, to allow pagination to addintional results.
            $(options.table+'_next').on('click',function(){
                renderTable($.extend({},options,{
                    token: function(){
                        return token;},
                }));
            });
        }

        // TODO: should we and a refresh button?
        // Do a $.pop() action will be required to remove the next page token from the nextPageTokens array.

        /*  If the table DOM element has a 'nextPageTokens' data attribute greater than one then we remove the disabled class from the Previous button.
         *  When the Previous button is clicked the current object is extended to add the next page tokens (of the privous page) parameter that will be appended to the URL.
         */
        if(arr.length > 1){
            $(options.table+'_previous').removeClass('disabled');
            // Add click event to previous button, if serverSide property is set to true, to allow pagination to previous results.
            $(options.table+'_previous').on('click',function(){
                // To move to a previous page two $.pop() actions required.
                // One to remove the next page token and One to remove the current page token from the nextPageTokens array.
                $(options.table).data('nextPageTokens').pop();
                $(options.table).data('nextPageTokens').pop();
                // We rebuild that table with the values of the previous page including any new rows of data.
                renderTable($.extend({},options,{
                    token: function(){
                        token = _.last(arr);
                        return token;},
                }));
            });
        }
        /* Sets the number of rows displayed with the select option menu.  We have to delete the old tokens from the object and remove the data-nextPageTokens attribute.
         * We do this so that the token store is clear and the display of the Previous and Next button behaves correctly
         */
        $(options.table+'_length').change(function(){
            delete options.token;
            $(options.table).removeData('nextPageTokens');
            renderTable($.extend({},options,{
                length: $(options.table+'_length option:selected').val(),
            }));
        });
    };

    // PAGE LOAD EVENTS
    $(function(){
        // Display error message if authentication error is found in URL.  This happens if login credentials fail.
        if(window.location.search.substring(1).indexOf('authentication_error') !== -1){
            $('form').notifie({type:'alert',severity:'info',message:'Invalid username or password'});
        };

        //  Add the query parameter to the search field on the search page
        if(bundle.getUrlParameters().page === 'search'){
            $('.predictiveText').val(bundle.getUrlParameters().q)
        }

         // Moment-ify any elements with the data-moment attribute
        $('[data-moment]').each(function(index, item) {
            var element = $(item);
            element.html(moment(element.text()).format('MMMM Do YYYY, h:mm:ss A'));
        });
    });

    /*----------------------------------------------------------------------------------------------
     * BUNDLE.CONFIG OVERWRITES
     *--------------------------------------------------------------------------------------------*/

    /**
     * Overwrite the default field constraint violation error handler to use Notifie to display the errors above the individual fields.
     */
    bundle.config = bundle.config || {};
    bundle.config.renderers = bundle.config.renderers || {};
    bundle.config.renderers.fieldConstraintViolations = function(form, fieldConstraintViolations) {
        _.each(fieldConstraintViolations, function(value, key){
            $(form.getFieldByName(key).wrapper()).notifie({
                message: value.join("<br>"),
                exitEvents: "click"
            });
        });
    }
    bundle.config.renderers.submitErrors = function(response) {
        $('[data-form]').notifie({
            message: 'There was a ' + response.status + ' : "' + response.statusText + '" error.' ,
            exitEvents: "click"
        });
    }
    
})(jQuery, moment, _);
