<%@page pageEncoding="UTF-8" contentType="text/html" trimDirectiveWhitespaces="true"%>
<%@include file="../../../package/initialization.jspf" %>
<%-- For each of the categories --%>
<c:forEach items="${kapp.categories}" var="category">
    <%-- If the category is not hidden, and it contains at least 1 form --%>
    <c:if test="${fn:toLowerCase(category.getAttribute('Hidden').value) ne 'true' && not empty category.forms}">
        <div class="category">
            <h3>${app:escape(category.name)}</h3>
            <div class="col-xs-12">
                <%-- Show the first x number of forms of the category --%>
                <c:forEach items="${category.forms}" var="categoryForm" begin="0" end="8">
                    <%-- Only show New or Active forms --%>
                    <c:if test="${categoryForm.status eq 'New' || categoryForm.status eq 'Active'}">
                        <%-- Render the form panel --%>
                        <c:set scope="request" var="thisForm" value="${categoryForm}"/>
                        <c:import url="views/partials/static/formPanel.jsp" charEncoding="UTF-8" />
                    </c:if>
                </c:forEach>
            </div>
        </div>
    </c:if>

</c:forEach>
<div class="category">
    <h3 class='uncategorized'>
        Uncategorized Forms
    </h3>
    <div class="col-xs-12">
        <c:forEach items="${kapp.forms}" var="form">
            <%-- Only show New or Active forms --%>
            <c:if test="${empty form.categories && (form.status eq 'New' || form.status eq 'Active')}">
                <%-- Render the form panel --%>
                <c:set scope="request" var="thisForm" value="${form}"/>
                <c:import url="views/partials/static/formPanel.jsp" charEncoding="UTF-8" />
            </c:if>
        </c:forEach>
    </div>
</div>
