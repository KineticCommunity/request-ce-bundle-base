<%@page pageEncoding="UTF-8" contentType="text/html" trimDirectiveWhitespaces="true"%>
<%@include file="bundle/initialization.jspf" %>
<bundle:layout page="layouts/layout.jsp">
    <bundle:variable name="head">
        <title>${text.escape(space.name)} Kapps</title>
    </bundle:variable>

    <h1>${text.escape(space.name)} Kapps</h1>
    <ul>
        <c:forEach var="kapp" items="${space.kapps}">
            <li><strong>${text.escape(kapp.name)}:</strong> <a href="${bundle.spaceLocation}/${kapp.slug}">user</a> | <a href="${bundle.spaceLocation}/app/#/${kapp.slug}/activity/overview">manage</a></li>
        </c:forEach>
    </ul>
</bundle:layout>
