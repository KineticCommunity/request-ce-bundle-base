<%@page pageEncoding="UTF-8" contentType="text/html" trimDirectiveWhitespaces="true"%>
<%@include file="../../../package/initialization.jspf" %>
<c:set scope="request" var="submissionsList" value="${submissions.searchByForm(searchForm, searchOptions)}"/>
<c:import url="views/partials/static/submissions/submissions.jsp" charEncoding="UTF-8"/>
