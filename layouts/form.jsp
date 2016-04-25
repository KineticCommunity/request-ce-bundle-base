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
            <bundle:variable name="head">
                <bundle:yield name="head"/>
            </bundle:variable>
            <bundle:yield/>
        </bundle:layout>
    </c:otherwise>
</c:choose>
<script>
    window.identity = '${identity.username}'
</script>