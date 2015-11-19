<%@page pageEncoding="UTF-8" contentType="text/html" trimDirectiveWhitespaces="true"%>
<%@include file="package/initialization.jspf" %>
<bundle:layout page="views/layouts/layout.jsp">
    <bundle:variable name="head">
        <title>${app:escape(space.name)} Kapps</title>
    </bundle:variable>

    <h1>${app:escape(space.name)} Kapps</h1>
    <ul>
        <c:forEach var="kapp" items="${space.kapps}">
            <li><strong>${app:escape(kapp.name)}:</strong> <a href="${bundle.spaceLocation}/${kapp.slug}">user</a> | <a href="${bundle.spaceLocation}/app">manage</a></li>
        </c:forEach>
    </ul>
</bundle:layout>
