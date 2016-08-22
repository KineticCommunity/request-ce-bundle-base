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

//commented out 7/22/16 remove by 12/01/16 if no side effects are found.
//    var locale = window.navigator.userLanguage || window.navigator.language;
//    moment.locale(locale);
//    $(function(){
//      if (!$('.navbar-form .typeahead').length){
//        return;
//      }
//      var matcher = function(strs) {
//        return function findMatches(query, callback) {
//            var matches, substringRegex;
//            matches = [];
//            substrRegex = new RegExp(query, 'i');
//            $.each(strs, function(i, str) {
//              if (substrRegex.test(str)) {
//                matches.push(str);
//              }
//            });
//            callback(matches);
//        };
//      };
//      var formNames = [];
//      var forms = {};
//      $.get(window.bundle.apiLocation() + "/kapps/" + window.bundle.kappSlug() + "/forms", function( data ) {
//        forms = data.forms;
//        $.each(forms, function(i,val) {
//          formNames.push(val.name);
//          forms[val.name] = val;
//        });
//      });
//      $('.navbar-form .typeahead').typeahead({
//          highlight:true
//        },{
//          name: 'forms',
//          source: matcher(formNames),
//        }).bind('typeahead:select', function(ev, suggestion) {
//          window.location.replace(window.bundle.kappLocation() + "/" + forms[suggestion].slug)
//      });
//    });


    /**
     * Applies the Jquery DataTables plugin to a rendered HTML table to provide
     * column sorting and Moment.js functionality to date/time values.
     *
     * @param {String} tableId The id of the table element.
     * @returns {undefined}
     */
    //commented out 7/22/16 remove by 12/01/16 if no side effects are found.
//    function submissionsTable (tableId) {
//        $('#'+tableId).DataTable({
//            dom: '<"wrapper">t',
//            columns: [ { defaultContent: ''}, null, null, null, null ],
//            columnDefs: [
//                {
//                    render: function ( cellData, type, row ) {
//                        var span = $('<a>').attr('href', 'javascript:void(0);');
//                        var iso8601date = cellData;
//                        $(span).text(moment(iso8601date).fromNow())
//                                .attr('title', moment(iso8601date).format('MMMM Do YYYY, h:mm:ss A'))
//                                .addClass('time-ago')
//                                .data('toggle', 'tooltip')
//                                .data('placement', 'top');
//                        var td = $('#'+tableId+' td:contains('+cellData+')');
//                        td.html(span);
//                        return td.html();
//                    },
//                    targets: 'date'
//                },
//                {
//                    orderable: false,
//                    targets: 'nosort'
//                }
//            ]
//        });
//    }

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
                    "dom": options.serverSide ? '<"top"l><"dataTables_date">t<"bottom"p><"clear">' : 'l<"dataTables_date">ftip',
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
                //addDateDropdown(options)
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
        if(options.backDate !== undefined){
            url += '&date=' + options.backDate;
        }
        if(options.length !== undefined){
            url += '&limit=' + options.length;
        }
        if(options.token && options.token() !== undefined){
            url += '&pageToken='+options.token();
        }
        return url;
    }

    function addDateDropdown(options){
        /*  We use the DOM: property in dataTables to create the div.dataTables_date element.
        *   Then we build up the html; the <label> tag was added to give the new element a similar style to the other elements around the table.
        */
        $('div.dataTables_date').html('<label>Over <select class="form-control-inline"> <option value="30">30</option> <option value="60">60</option> <option value="90">90</option> </select> &nbsp;Days</label>');

        // The dropdown needs to be readded to dataTables every time the table is rebuild so we need to set the displayed option to the last option the user selected.
        if(options.backDate !== undefined){
            $('div.dataTables_date select').val(options.backDate);
        }

        /* When a new option is selected we rebuild the table.  We have to delete the old tokens from the object and remove the data-nextPageTokens attribute.
         * We do this so that the token store is clear and the display of the Previous and Next button behaves correctly
         */
        $('div.dataTables_date').change(function(){
            delete options.token;
            $(options.table).removeData('nextPageTokens');
            renderTable($.extend({},options,{
                backDate: $('div.dataTables_date option:selected').val(),
            }));
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
