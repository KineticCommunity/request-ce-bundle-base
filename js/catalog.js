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
    /* */ 
    window.token = [];

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
                    if ($(options.table).data('pageTokens') === undefined) {
                        $(options.table).data('pageTokens', []); 
                    }
                    $(options.table).data('pageTokens').push(data.nextPageToken);
                }
                $(options.table).DataTable({
                    destroy:true,
                    "pagingType": options.serverSide ? "simple" : "simple_numbers",
                    "dom": options.serverSide ? '<"top"l>t<"bottom"p><"clear">' : "lftip",
                    "data": data.submissions,
                    "columns": [
                        { "data":function(data){return data.submittedAt} },
                        { "data":"form.name" },
                        { "data":"id"},
                        { "data":"submittedBy" },
                        { "data":"coreState"  },
                    ]
                });
            },
            complete: function(){
                if(options.serverSide){
                    $('.paginate_button').removeClass('disabled');
                    $('#testTable_next').on('click',function(){
                        renderTable({
                            table: '#testTable',
                            type: 'Template',
                            coreState: 'Closed',
                            serverSide: true,
                            token: function(){
                                var arr = $('#testTable').data('pageTokens');
                                var token = arr[arr.length-1];
                                return token;},
                        });
                    });
                }
            },
        });
    }
    /* This fucntion build a Url to be used by the ajax call.
     * The intention is to be able to pass parameter to this function to have a configurable url so that we can have 
     * the ability to configure the query with the same piece of code*/
    function buildAjaxUrl(options){
        var url = bundle.apiLocation()+'/kapps/'+bundle.kappSlug()+'/submissions?include=form&type='+options.type;
        if(options.serverSide){
            url += '&limit=10';
        }
        if(options.token){
            options.token();
        };
        return url;
    }
})(jQuery);
