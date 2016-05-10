<%@page pageEncoding="UTF-8" contentType="text/html" trimDirectiveWhitespaces="true"%>
<%@include file="../bundle/initialization.jspf" %>
<bundle:layout page="${bundle.path}/layouts/layout.jsp">
    <bundle:variable name="head">
        <title>Kinetic Data ${text.escape(kapp.name)}</title>
    </bundle:variable>
    <c:import url="${bundle.path}/partials/tabs.jsp" charEncoding="UTF-8"/>
    <%--Tables are built on page load using dataTables library and an ajax call.
        In catalog.js an object to render the table is configured on page load and the mathod renderTable is called.  --%>
    <div role="tabpanel" class="tab-pane" id="tab-requests">
        <h3>My Requests</h3>
        <table id="requestsTable" class="table table-striped table-hover">
            <thead>
                <tr>
                    <th class="date">Updated At</th>
                    <th>Form</th>
                    <th class="nosort">Submission</th>
                    <th>State</th>
                </tr>
            </thead>
        </table>
    </div>
</bundle:layout>