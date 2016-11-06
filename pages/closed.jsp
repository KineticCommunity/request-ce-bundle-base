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
        <h3>Closed Submissions</h3>
        <div class="header__date-range col-sm-12">
            <label> Date Range:
                <select id="date-range" class="form-control input-sm">
                    <option value="1 Year">1 Year</option>
                    <option value="View All">View All</option>
                    <option value="Custom">Custom</option>
                </select>
            </label>
            <span id="section-date-range" class="hidden">
                <div id="date_timepicker_start">
                    <label class="control-label">Start</label>
                    <div  class="input-group">
                      <input id="date_timepicker_start_input" type="text" class="form-control" aria-describedby="basic-addon2" >
                      <span class="input-group-addon" id="basic-addon2"><i class="fa fa-calendar fa-fw"></i></span>
                    </div>

                </div>
                <div id="date_timepicker_end">
                  <label class="control-label">End</label>
                  <div class="input-group">
                    <input id="date_timepicker_end_input" type="text" class="form-control" aria-describedby="basic-addon2" >
                    <span class="input-group-addon" id="basic-addon2"><i class="fa fa-calendar fa-fw"></i></span>
                  </div>
                </div>
            </span>
        </div>
        <i id="spinner" class="fa fa-cog fa-spin fa-3x" style="text-align:center;width:100%;margin-top:15%"></i>
        <table id="closedTable" class="table table-striped table-hover">

        </table>
    </div>
</bundle:layout>
