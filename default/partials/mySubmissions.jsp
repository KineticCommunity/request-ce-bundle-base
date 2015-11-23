<%@page pageEncoding="UTF-8" contentType="text/html" trimDirectiveWhitespaces="true"%>
<%@include file="../bundle/initialization.jspf" %>
<%
    com.kineticdata.core.authentication.Identity identity =
        (com.kineticdata.core.authentication.Identity) request.getAttribute("identity");
    java.util.Map<String,String[]> searchOptions = new java.util.HashMap<>();
    searchOptions.put("createdBy", new String[] {identity.getUsername()});
    request.setAttribute("searchOptions", searchOptions);
    searchOptions.put("end", new String[] {"2016-12-31T21:00:00.000Z"} );
    searchOptions.put("start", new String[] {"2015-01-01T21:00:00.000Z"} );
%>
<c:set scope="request" var="submissionsList" value="${submissions.searchByKapp(kapp, searchOptions)}"/>
<c:import url="partials/submissions.jsp" charEncoding="UTF-8"/>
