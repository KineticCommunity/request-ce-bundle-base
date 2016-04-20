<%@page pageEncoding="UTF-8" contentType="text/html" trimDirectiveWhitespaces="true"%>
<%@include file="../bundle/initialization.jspf" %>

<bundle:layout page="${bundle.path}/layouts/layout.jsp">
    <bundle:variable name="head">
        <title>Kinetic Data ${text.escape(kapp.name)}</title>
    </bundle:variable>

    <table id="serviceTable" class="table table-striped table-hover">
        <c:import url="${bundle.path}/partials/submissions.jsp" charEncoding="UTF-8"/>
    </table>
</bundle:layout>
<script>
  //Request and Approval datatables 
    $(function(){ 
        renderTable({
            table: '#serviceTable',
            type: 'Service',
            serverSide: false
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
                        { "data":"id"},
                        { "data":"submittedBy" },
                        { "data":"coreState"  },
                    ]
                });
                // Add click event to the rows of the DataTable that takes a users to the submission page for the selected submission
                $(options.table + ' tbody').on('click', 'tr', function () {
                    var data = table.row( this ).data();
                    window.location.href = window.bundle.kappLocation()+"?page=submission&id="+data.id;
                });
                
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
        var url = bundle.apiLocation()+'/kapps/'+bundle.kappSlug()+'/submissions?include=form&type='+options.type+'&submittedBy='+identity;
        if(options.serverSide){
            url += '&limit=10';
        }
        if(options.token && options.token() != "firstPage"){
            url += '&pageToken='+options.token();
        };
        return url;
    }
</script>
            