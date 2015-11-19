<%@page pageEncoding="UTF-8" contentType="text/html" trimDirectiveWhitespaces="true"%>
<%@include file="packages/default/package/initialization.jspf" %>
<bundle:layout>
    <bundle:variable name="head">
        <title>${app:escape(space.name)} Kapps</title>
    </bundle:variable>

    <h1>${app:escape(space.name)} Kapps</h1>
    <ul>
        <c:forEach var="kapp" items="${space.kapps}">
            <li><a href="${bundle.spaceLocation}/${kapp.slug}">${app:escape(kapp.name)}</a></li>
        </c:forEach>
    </ul>
</bundle:layout>


