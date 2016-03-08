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
            <h3>Search Results for '${param['q']}'</h3>

            <c:if test="${text.isNotBlank(param['q'])}">
                <ul>
                    <c:set var="found" value="false" />
                    <c:forEach items="${kapp.forms}" var="form">
                        <c:if test="${text.equals(form.typeName, 'Service') || text.equals(form.typeName, 'Template')}">
                            <c:if test="${text.contains(text.downcase(form.name), text.downcase(param['q'])) || text.contains(text.downcase(form.description), text.downcase(param['q']))}">
                                <c:set var="found" value="true"/>
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
                        </c:if>
                    </c:forEach>
                    <c:if test="${found == "false"}">
                        <h5>No results found for ${param['q']}.</h5>
                    </c:if>
                </ul>
            </c:if>
        </div>
    </div>
</bundle:layout>