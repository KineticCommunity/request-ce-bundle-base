<%@page pageEncoding="UTF-8" contentType="text/html" trimDirectiveWhitespaces="true"%>
<%@include file="../bundle/initialization.jspf" %>
<bundle:variable name="head">
    <title>Kinetic Data ${app.
escape(kapp.name)}</title>
</bundle:variable>
<section class="menu">
    <ul class="nav nav-pills">
        <c:set var="pageHome" value="${kapp.getForm('home')}" scope="page"/>

        <li role="presentation" class="active">
            <a href="#tab-home" aria-controls="tab-home" role="tab" data-toggle="tab">Home</a>
        </li>
        <li role="presentation">
            <a href="#tab-requests" aria-controls="tab-requests" role="tab" data-toggle="tab">My Requests</a>
        </li>
        <li role="presentation">
            <a href="#tab-approvals" aria-controls="tab-approvals" role="tab" data-toggle="tab">My Approvals</a>
        </li>
    </ul>
</section>
<div class="tab-content">
    <div role="tabpanel" class="tab-pane active" id="tab-home">
        <div class="row">
            <div class="col-xs-12">
                <div class="row">
                    <div class="col-md-8">
                        <h2>Service Items</h2>
                        <%-- For each of the categories --%>
                        <c:forEach items="${kapp.categories}" var="category">
                            <%-- If the category is not hidden, and it contains at least 1 form --%>
                            <c:if test="${fn:toLowerCase(category.getAttribute('Hidden').value) ne 'true' && not empty category.forms}">
                                <div class="category">
                                    <h3>${app.
escape(category.name)}</h3>
                                    <div class="row">
                                        <%-- Show the first x number of forms of the category --%>
                                        <c:forEach items="${category.forms}" var="categoryForm" begin="0" end="8">
                                            <%-- Only show New or Active forms --%>
                                            <c:if test="${categoryForm.status eq 'New' || categoryForm.status eq 'Active'}">
                                                <%-- Render the form panel --%>
                                                <c:set scope="request" var="thisForm" value="${categoryForm}"/>
                                                <c:import url="partials/formCard.jsp" charEncoding="UTF-8" />
                                            </c:if>
                                        </c:forEach>
                                    </div>
                                </div>
                            </c:if>

                        </c:forEach>
                        <div class="category uncategorized">
                            <h3>
                                Uncategorized Forms
                            </h3>
                            <div class="row">
                                <c:forEach items="${kapp.forms}" var="form">
                                    <%-- Only show New or Active forms --%>
                                    <c:if test="${empty form.categories && (form.status eq 'New' || form.status eq 'Active')}">
                                        <%-- Render the form panel --%>
                                        <c:set scope="request" var="thisForm" value="${form}"/>
                                        <c:import url="partials/formCard.jsp" charEncoding="UTF-8" />
                                    </c:if>
                                </c:forEach>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <a class="twitter-grid" href="https://twitter.com/_/timelines/672792909733842945">A Collection on Twitter</a> <script async src="https://platform.twitter.com/widgets.js"></script>                    </div>
                </div>
            </div>
        </div>
    </div>
    <div role="tabpanel" class="tab-pane" id="tab-requests">
        <h3>My Requests</h3>
        <c:set scope="request" var="submissionsList" value="${submissions.searchByKapp(kapp, myHelper.requestsQueryOptions())}"/>
        <c:import url="partials/submissions.jsp" charEncoding="UTF-8"/>
    </div>
    <div role="tabpanel" class="tab-pane" id="tab-approvals">
        <h3>My Approvals</h3>
        <c:set scope="request" var="submissionsList" value="${submissions.searchByKapp(kapp, myHelper.approvalsQueryOptions())}"/>
        <c:import url="partials/submissions.jsp" charEncoding="UTF-8"/>
    </div>
</div>
