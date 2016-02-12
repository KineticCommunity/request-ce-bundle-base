<%@page pageEncoding="UTF-8" contentType="text/html" trimDirectiveWhitespaces="true"%>
<%@include file="bundle/initialization.jspf" %>

<bundle:layout page="${bundle.path}/layouts/layout.jsp">
    <div class="no-data">
        <h3>Kapp configuration is missing these attributes:</h3>
        <ul>
            <c:if test="${!kapp.hasAttribute('Task Server Url')}">
                <li>Task Server Url</li>
            </c:if>
            <c:if test="${!kapp.hasAttribute('Task Source Name')}">
                <li>Task Source Name</li>
            </c:if>
        </ul>
        <p>To update your configuration go to the <a href="${bundle.spaceLocation}/app/#/${kapp.slug}/setup/kapp/attributes">
        Kapp Attribute settings</a>.</p>
    </div>
</bundle:layout>