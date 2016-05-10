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

    /**
     * Applies the Jquery DataTables plugin to a rendered HTML table to provide
     * column sorting and Moment.js functionality to date/time values.
     *
     * @param {String} tableId The id of the table element.
     * @returns {undefined}
     */
    function submissionsTable (tableId) {
        $('#'+tableId).DataTable({
            dom: '<"wrapper">t',
            columns: [ { defaultContent: ''}, null, null, null, null ],
            columnDefs: [
                {
                    render: function ( cellData, type, row ) {
                        var span = $('<a>').attr('href', 'javascript:void(0);');
                        var iso8601date = cellData;
                        $(span).text(moment(iso8601date).fromNow())
                                .attr('title', moment(iso8601date).format('MMMM Do YYYY, h:mm:ss A'))
                                .addClass('time-ago')
                                .data('toggle', 'tooltip')
                                .data('placement', 'top');
                        var td = $('#'+tableId+' td:contains('+cellData+')');
                        td.html(span);
                        return td.html();
                    },
                    targets: 'date'
                },
                {
                    orderable: false,
                    targets: 'nosort'
                }
            ]
        });
    }
    //Request and Approval datatables 
    $(function(){
        var currentId = bundle.getUrlParameters().page;
       
        if (currentId === 'approvals'){
            renderTable({
                table: '#approvalTable',
                type: 'Approval',
                coreState: ['Draft','Submitted'],
                serverSide: false,
            });
        }
        if(currentId === 'requests'){
            renderTable({
                table: '#requestsTable',
                type: 'Service',
                coreState: ['Draft','Submitted'],
                serverSide: false,
            });
        }
        if(currentId == 'closed'){
            $('#closedTable').removeData('pageTokens');
            renderTable({
                table: '#closedTable',
                coreState: ['Closed'],
                length: 10,
                serverSide: true,
            });
        }
        
        /* We are using the page load to set some visual cues so the user know what tab they are on*/
        if(currentId === undefined){
            $('#home').addClass('active');
        }else{
            $('#'+currentId).addClass('active');
        }
    });
    function renderTable(options){
        $.ajax({
            method: 'get',
            contentType: 'application/json',
            url: buildAjaxUrl(options),
            success: function(data, textStatus, jqXHR){
                
                $.fn.dataTable.moment('MMMM Do YYYY, h:mm:ss A');
                var table = $(options.table).DataTable({
                    "destroy": true,
                    "order": [[ 0, "desc" ]],
                    bSort: options.serverSide ? false : true,
                    destroy:true,
                    "pagingType": options.serverSide ? "simple" : "simple_numbers",
                    "dom": options.serverSide ? '<"top"l>t<"bottom"p><"clear">' : "lftip",
                    "data": data.submissions,
                    "language": {"search":""},
                    "pageLength": options.length,
                    "columns": [
                        { "data":function(data){return moment(data.updatedAt).format('MMMM Do YYYY, h:mm:ss A');} },
                        { "data":"form.name" },
                        { "data":function(data){
                                // This allows the submission id to be a url to the submission details display page or if the submission
                                // has a coreState of draft the url will link to the submission to be completed.
                                // TODO: use submission label instead of guid
                                if(data.coreState == "Draft"){
                                    var id = "<a href='"+window.bundle.spaceLocation()+"/submissions/"+data.id+"'>"+data.label+"</a>"; 
                                }else{
                                    var id = "<a href='"+window.bundle.kappLocation()+"?page=submission&id="+data.id+"'>"+data.label+"</a>"; 
                                }
                                return id;} },
                        { "data":"coreState"  },
                    ]
                });
                
                if(options.serverSide){
                    // For server side pagination we are collecting the nextpagetoken metadata that is attached to submissions return object.
                    // The token is added to an array that is attached to the table elements data property. 
                    if ($(options.table).data('nextPageTokens') === undefined) {
                        $(options.table).data('nextPageTokens', []); 
                    }
                    $(options.table).data('nextPageTokens').push(data.nextPageToken);
                    var arr = $(options.table).data('nextPageTokens');
                    var token = _.last(arr);
                    if(token !== null){
                        $(options.table+'_next').removeClass('disabled');
                        // Add click event to next button, if serverSide property is set to true, to allow pagination to addintional results.
                        $(options.table+'_next').on('click',function(){    
                            renderTable($.extend({},options,{
                                token: function(){
                                    return token;},
                            }));
                        });
                    }
                    if(arr.length > 1){
                        $(options.table+'_previous').removeClass('disabled');
                        // Add click event to previous button, if serverSide property is set to true, to allow pagination to previous results.
                        $(options.table+'_previous').on('click',function(){
                            $(options.table).data('nextPageTokens').pop();
                            $(options.table).data('nextPageTokens').pop();
                            renderTable($.extend({},options,{
                                token: function(){
                                    token = _.last(arr);
                                    return token;},
                            }));
                        });
                    }
                    /* Sets the number of rows displayed with the select option menu */
                    $(options.table+'_length').change(function(){
                        delete options.token;
                        $('#closedTable').removeData('pageTokens');
                        renderTable($.extend({},options,{
                            length: $(options.table+'_length option:selected').val(),
                        }));
                    });
                }
            },
            complete: function(){
                $('.dataTables_filter input').addClass('form-control');
                $('.dataTables_filter input').attr('placeholder', 'Filter...');
            }
        });
    }
    /* This fucntion build a Url to be used by the ajax call.
     * The intention is to be able to pass parameter to this function to have a configurable url so that we can have 
     * the ability to configure the query with the same piece of code*/
    function buildAjaxUrl(options){
        var url = bundle.apiLocation()+'/kapps/'+bundle.kappSlug()+'/submissions?include=form,details&timeline=updatedAt&createdBy='+identity;

        if(options.coreState !== undefined){
            $.each(options.coreState, function(k,v){
                url += '&coreState='+v; 
            });
        }
        if(options.type !== undefined){
            url += '&type='+options.type;
        }
        if(options.serverSide && options.length !== undefined){
            url += '&limit=' + options.length;
        }
        if(options.token && options.token() !== undefined){
            url += '&pageToken='+options.token();
        };
        return url;
    }
    
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
})(jQuery, moment, _);
   