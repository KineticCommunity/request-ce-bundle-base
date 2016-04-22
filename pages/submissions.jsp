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

            