<%@page pageEncoding="UTF-8" contentType="text/html" trimDirectiveWhitespaces="true"%>
<%@include file="../bundle/initialization.jspf" %>
<bundle:layout page="${bundle.path}/layouts/layout.jsp">

    <bundle:variable name="head">
        <title>${text.escape(space.name)} Search</title>
    </bundle:variable>


    <div class="search">
        <div class="visible-xs search-container">
            <form action="${bundle.kappLocation}" method="GET" role="form">
                <div class="form-group has-feedback">
                    <input type="hidden" value="search" name="page">
                    <input type="text" class="states form-control x" name="q" value="${param['q']}"/>
                </div>
            </form>
        </div>
        <div class="search-results">
            <h3>Search Results for '${text.escape(param['q'])}'</h3>
            <c:if test="${text.isNotBlank(param['q'])}">
                <ul>
                    <c:set scope="request" var="formsMatchSearch" value="${SearchHelper.filter(kapp.forms,param['q'])}"/>
                    <c:forEach var="form" items="${formsMatchSearch}">
                        <c:if test="${text.equals(form.type.name, 'Service') || text.equals(form.type.name, 'Template')}">
                            <li>
                                <h4>
                                    <a href="${bundle.kappLocation}/${form.slug}">
                                       ${form.name}
                                    </a>
                                </h4>
                                <c:if test="${not empty form.description}">
                                    <p>${form.description}</p>
                                </c:if>
                            </li>
                         </c:if>
                    </c:forEach>
                    <c:if test="${formsMatchSearch == null}">
                        <%--Use text escape to sanitize the output and prevent XXS attacks--%>
                        <h5>No results found for ${text.escape(param['q'])}.</h5>
                    </c:if>
                </ul>
            </c:if>
        </div>
    </div>
</bundle:layout>