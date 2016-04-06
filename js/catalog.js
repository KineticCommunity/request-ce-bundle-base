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
    /* set currentId as a global variable to be used in searchConfig.
     * we do this so that we can reuse the configuration code for multiple tables on the same page.*/ 
    var currentId = null;
    if(currentId != null){
    catalogTable = currentId;
    }
    //Request and Approval datatables 
    $(function(){
        $('.submissiontable').on('click',function(){
            currentId = $(this).attr('id');
          //  global.currentId = currentId;
            getSubmissions(currentId);
        });
    });
    function getSubmissions(currentId){
        $.ajax({
            method: 'get',
            contentType: 'application/json',
            url: bundle.apiLocation()+'/kapps/'+bundle.kappSlug()+'/submissions?include=form&type='+currentId,
            success: function(data, textStatus, jqXHR){
                var token = data.nextPageToken
                $('#'+currentId+'Table').DataTable({
                     destroy:true,
                     "processing": true,
                     "data": data.submissions,
                     "columns": [
                        { "data":function(data){return data.submittedAt} },
                        { "data":"form.name" },
                        { "data":"id"},
                        { "data":"submittedBy" },
                        { "data":"coreState"  }
                     ]
                 });
            },
        });
    }

})(jQuery);
