<%@page pageEncoding="UTF-8" contentType="text/html" trimDirectiveWhitespaces="true"%>
<%@include file="../bundle/initialization.jspf" %>
<bundle:layout page="${bundle.path}/layouts/layout.jsp">
    <bundle:variable name="head">
        <title>Kinetic Data ${text.escape(kapp.name)}</title>
    </bundle:variable>
    <c:import url="${bundle.path}/partials/tabs.jsp" charEncoding="UTF-8"/>
    <%--Tables are built on page load using dataTables library and an ajax call to the tableRecords.json.jsp page in the bundle.
        In catalog.js an object to render the table is configured on page load and the mathod renderTable is called.  --%>
    <div role="tabpanel" class="tab-pane">
        <div class="row title-header">
            <h3 class="col-md-4">My Requests</h3>
            <div class="dropdown col-md-8">
                <input id="1-year-date-range" class="btn btn-default" type="button" value="1 Year">
                <input id="custom-date-range" class="btn btn-default " type="submit" value="Custom">
                <span id="section-date-range" class="hidden">
                    <input id="date_timepicker_start" class="btn btn-default" placeholder="Starting Date"  type="text" value="">
                    <input id="date_timepicker_end" class="btn btn-default" placeholder="Ending Date"  type="text" value="">
                </span>
                <input id="view-all-date-range" class="btn btn-default" type="submit" value="View All">
            </div>
        </div>
        <table id="requestsTable" class="table table-striped table-hover">
           
        </table>
    </div>
</bundle:layout>