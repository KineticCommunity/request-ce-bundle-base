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
        <h3>My Approvals</h3>
        <table id="approvalTable" class="table table-striped table-hover">

        </table>
    </div>
</bundle:layout>