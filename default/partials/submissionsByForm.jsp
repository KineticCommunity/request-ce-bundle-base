<%@page pageEncoding="UTF-8" contentType="text/html" trimDirectiveWhitespaces="true"%>
<%@include file="../bundle/initialization.jspf" %>
<c:set scope="request" var="submissionsList" value="${submissions.searchByForm(searchForm, searchOptions)}"/>
<c:import url="partials/submissions.jsp" charEncoding="UTF-8"/>
