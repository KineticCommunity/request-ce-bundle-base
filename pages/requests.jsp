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
        <h3>My Requests</h3>
        <div class="header__date-range">
            <label> Date Range:
                <select id="date-range">
                    <option value="1 Year">1 Year</option>
                    <option value="View All">View All</option>
                    <option value="Custom">Custom</option>
                </select>
            </label>
            <span id="section-date-range" class="hidden">
                <div id="date_timepicker_start" class="input-group">
                    <input id="date_timepicker_start_input" type="text" class="form-control" aria-describedby="basic-addon2">
                    <span class="input-group-addon" id="basic-addon2"><i class="fa fa-calendar"></i></span>
                </div>
                <div id="date_timepicker_end" class="input-group">
                    <input id="date_timepicker_end_input" type="text" class="form-control" aria-describedby="basic-addon2">
                    <span class="input-group-addon" id="basic-addon2"><i class="fa fa-calendar"></i></span>
                </div>
            </span>
        </div>
        <i id="spinner" class="fa fa-cog fa-spin fa-3x" style="text-align:center;width:100%;margin-top:15%"></i> 
        <table id="requestsTable" class="table table-striped table-hover">
            
        </table>
    </div>
</bundle:layout>