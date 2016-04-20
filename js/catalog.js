/**
 * Forms Search using Twitter Typeahead. Prefetch all accessible forms
 * for the Kapp.
**/
(function($){
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
        $('.submissiontable').on('click',function(){
            currentId = $(this).attr('id');
        
            if (currentId == 'approval'){
                renderTable({
                    table: '#approvalTable',
                    type: 'Approval',
                    serverSide: false
                });
            }
            if(currentId == 'service'){
                renderTable({
                    table: '#serviceTable',
                    type: 'Service',
                    serverSide: false,
                });
            } 
            if(currentId == 'test'){
                $('#testTable').removeData('pageTokens');
                renderTable({
                    table: '#testTable',
                    type: 'Template',
                    coreState: 'Closed',
                    serverSide: true,
                });
            }
        });
    });
    
    function renderTable(options){
        $.ajax({
            method: 'get',
            contentType: 'application/json',
            url: buildAjaxUrl(options),
            success: function(data, textStatus, jqXHR){
                if(options.serverSide){
                    var nextPageToken;
                    if(data.nextPageToken === null){
                        nextPageToken = "lastPage";
                    }else{
                        nextPageToken = data.nextPageToken;
                    }
                    $(options.table).data('nextPageToken', nextPageToken);
                    // For server side pagination we are collecting the nextpagetoken metadata that is attached to submissions return object.
                    // The token is added to an array that is attached to the table elements data property. 
                    if ($(options.table).data('pageTokens') === undefined) {
                        $(options.table).data('pageTokens', ["firstPage"]); 
                    }
                    var tokenArray = $(options.table).data('pageTokens');
                    if(!($.inArray(nextPageToken,tokenArray) > 0)){
                        $(options.table).data('pageTokens').push(nextPageToken);
                    }
                }
                var table = $(options.table).DataTable({
                    bSort: false,
                    destroy:true,
                    "pagingType": options.serverSide ? "simple" : "simple_numbers",
                    "dom": options.serverSide ? '<"top"l>t<"bottom"p><"clear">' : "lftip",
                    "data": data.submissions,
                    "columns": [
                        { "data":function(data){return moment(data.submittedAt).format('MMMM Do YYYY, h:mm:ss A');} },
                        { "data":"form.name" },
                        { "data":function(data){
                                // This allows the submission id to be a url to the submission details display page or if the submission
                                // has a coreState of draft the url will link to the submission to be completed.
                                //TODO: should draft have a different behavior than submitted or complete?
                                if(data.coreState == "Draft"){
                                    var id = "<a href='"+window.bundle.spaceLocation()+"/submissions/"+data.id+"'>"+data.id+"</a>"; 
                                }else{
                                    var id = "<a href='"+window.bundle.kappLocation()+"?page=submission&id="+data.id+"'>"+data.id+"</a>"; 
                                }
                                return id;} },
                        { "data":"createdBy" },
                        { "data":"coreState"  },
                    ]
                });
                // Add click event to the rows of the DataTable that takes a users to the submission page for the selected submission
//                We are in the process of switching from row to id selectors
//                $(options.table + ' tbody').on('click', 'tr', function () {
//                    var data = table.row( this ).data();
//                    window.location.href = window.bundle.kappLocation()+"?page=submission&id="+data.id;
//                });
                
                if(options.serverSide){
                    var arr = $(options.table).data('pageTokens');
                    var nextToken = $(options.table).data('nextPageToken')
                    var index = $.inArray(nextToken, arr);
                    
                    if($(options.table).data('nextPageToken') !== "lastPage"){
                        $(options.table+'_next').removeClass('disabled');
                        // Add click event to next button, if serverSide property is set to true, to allow pagination to addintional results.
                        $(options.table+'_next').on('click',function(){    
                            renderTable($.extend({},options,{
                                token: function(){
                                    var token = arr[index];
                                    return token;},
                            }));
                        });
                    }
                    if(index !== 1){
                        $(options.table+'_previous').removeClass('disabled');
                        // Add click event to previous button, if serverSide property is set to true, to allow pagination to previous results.
                        $(options.table+'_previous').on('click',function(){
                            renderTable($.extend({},options,{
                                token: function(){
                                    var token = arr[index-2];
                                    return token;},
                            }));
                        });
                    }
                }
            },
            complete: function(data){
                
            },
        });
    }
    /* This fucntion build a Url to be used by the ajax call.
     * The intention is to be able to pass parameter to this function to have a configurable url so that we can have 
     * the ability to configure the query with the same piece of code*/
    function buildAjaxUrl(options){
        var url = bundle.apiLocation()+'/kapps/'+bundle.kappSlug()+'/submissions?include=form,details&timeline=createdAt&type='+options.type+'&createdBy='+identity;
        if(options.serverSide){
            url += '&limit=10';
        }
        if(options.token && options.token() != "firstPage"){
            url += '&pageToken='+options.token();
        };
        return url;
    }
})(jQuery);
