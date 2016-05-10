<%@page pageEncoding="UTF-8" contentType="text/html" trimDirectiveWhitespaces="true"%>
<%@include file="../bundle/initialization.jspf" %>
<c:choose>
    <%-- 
        If the form is being rendered in "embedded" mode, 
    --%>
    <c:when test="${param.embedded != null}">
        <%-- 
            Yield to the the form body content (the form head content is included in form body 
            content in this case).
        --%>
        <bundle:yield/>
        <script>
            window.identity = '${identity.username}'
        </script>
    </c:when>
    <%-- 
        If the form is being rendered in "normal" mode, 
    --%>
    <c:otherwise>
        <%-- 
            Delegate to the primary layout. 
        --%>
        <bundle:layout page="layout.jsp">
            <%-- 
                Set the primary layout head content to Include the form display page head content 
                and the custom head content.
            --%>
            <bundle:variable name="head">
                <bundle:yield name="head"/>
                <app:formHeadContent/>
            </bundle:variable>
            <%-- 
                Yield to the form body content. 
            --%>
            <bundle:yield/>
        </bundle:layout>
    </c:otherwise>
</c:choose>
