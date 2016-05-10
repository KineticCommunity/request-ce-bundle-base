<%@page pageEncoding="UTF-8" contentType="text/html" trimDirectiveWhitespaces="true"%>
<%@include file="../bundle/initialization.jspf" %>
<bundle:layout page="${bundle.path}/layouts/layout.jsp">
    <bundle:variable name="head">
        <title>Kinetic Data ${text.escape(kapp.name)}</title>
    </bundle:variable>
    <c:import url="${bundle.path}/partials/tabs.jsp" charEncoding="UTF-8"/>
    
        <div role="tabpanel" class="tab-pane" id="tab-test">
             <h3>Complete Submissions</h3>
            <table id="closedTable" class="table table-striped table-hover">
                <c:import url="${bundle.path}/partials/submissions.jsp" charEncoding="UTF-8"/>
            </table>
        </div>
</bundle:layout>