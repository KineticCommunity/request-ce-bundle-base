<%@page pageEncoding="UTF-8" contentType="text/html" trimDirectiveWhitespaces="true"%>
<%@include file="../bundle/initialization.jspf" %>
<%--
    * /ID
    * /ID?embedded
--%>
<c:choose>
    <c:when test="${param.embedded != null}">
        <bundle:yield/>
    </c:when>
    <c:otherwise>
        <bundle:layout page="layout.jsp">
            <bundle:yield/>
        </bundle:layout>
    </c:otherwise>
</c:choose>