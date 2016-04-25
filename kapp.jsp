<%@page pageEncoding="UTF-8" contentType="text/html" trimDirectiveWhitespaces="true"%>
<%@include file="bundle/initialization.jspf" %>
<%@include file="bundle/router.jspf" %>


<bundle:layout page="${bundle.path}/layouts/layout.jsp">
    <bundle:variable name="head">
        <title>Kinetic Data ${text.escape(kapp.name)}</title>
    </bundle:variable>
    <c:import url="${bundle.path}/partials/tabs.jsp" charEncoding="UTF-8"/>
    
    <div class="tab-content">
        <div role="tabpanel" class="tab-pane active" id="tab-home">
            <div class="row">
                <div class="col-md-8">
                    <h2>Service Items</h2>
                    <%-- For each of the categories --%>
                    <c:forEach items="${kapp.categories}" var="category">
                        <c:set var="formsStatusActive" value="${FormHelper.getFormsByStatus(category,'Active')}"/>
                        <%-- If the category is not hidden --%>
                        <c:if test="${fn:toLowerCase(category.getAttributeValue('Hidden')) ne 'true' && not empty formsStatusActive}">
                            <%-- Show the first x number of forms of the category --%>
                            <h3>${text.escape(category.name)}</h3>
                            <div class="row">
                                <div class="category">
                                    <c:forEach var="categoryForm" items="${formsStatusActive}" begin="0" end="8">
                                        <c:if test="${categoryForm.getCategory(category.slug).name == category.name}">
                                            <%-- Render the form panel --%>
                                            <c:set scope="request" var="thisForm" value="${categoryForm}"/>
                                            <c:import url="${bundle.path}/partials/formCard.jsp" charEncoding="UTF-8" />
                                        </c:if>
                                    </c:forEach>
                                </div>
                            </div>
                        </c:if>
                    </c:forEach>
                    <c:set var="uncategorizedForms" value="${FormHelper.getUncategorizedForms(kapp)}"/>
                    <c:if test="${not empty uncategorizedForms}">
                        <div class="category uncategorized">
                                <h3>Uncategorized Forms </h3>
                            <div class="row">
                                <c:forEach items="${uncategorizedForms}" var="form">
                                    <c:set scope="request" var="thisForm" value="${form}"/>
                                    <c:import url="${bundle.path}/partials/formCard.jsp" charEncoding="UTF-8" />
                                </c:forEach>
                            </div>
                        </div>
                    </c:if>
                    <c:set var="formsStatusNew" value="${FormHelper.getFormsByStatus(kapp,'New')}"/>
                    <c:if test="${not empty formsStatusNew}">
                        <div class="category uncategorized">
                                <h3>Forms Status New</h3>
                            <div class="row">
                                <c:forEach items="${formsStatusNew}" var="form">
                                    <c:set scope="request" var="thisForm" value="${form}"/>
                                    <c:import url="${bundle.path}/partials/formCard.jsp" charEncoding="UTF-8" />
                                </c:forEach>
                            </div>
                        </div>
                    </c:if>
                </div>
                <div class="col-md-3 col-md-offset-1 hidden-xs" id="social-column" >
                    <h2>Sidebar Items</h2>
                    <c:choose>
                        <c:when test="${not empty kapp.getAttributeValue('Sidebar Html')}">
                            ${kapp.getAttributeValue('Sidebar Html')}
                        </c:when>
                        <c:otherwise>
                            <a class="twitter-grid" href="https://twitter.com/_/timelines/672792909733842945">A Collection on Twitter</a>
                            <script async src="https://platform.twitter.com/widgets.js"></script>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </div>
</bundle:layout>
