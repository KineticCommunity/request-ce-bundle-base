<%@page pageEncoding="UTF-8" contentType="text/html" trimDirectiveWhitespaces="true"%>
<%@include file="../bundle/initialization.jspf" %>
<c:if test="${!(identity.anonymous)}">
    <section class="menu">
        <ul class="nav nav-pills">
            <c:set var="pageHome" value="${kapp.getForm('home')}" scope="page"/>
            <li id="home">
                <a href="${bundle.kappLocation}">Home</a>
            </li>
            <li id="request" class="submissiontable">
                <a href="${bundle.kappLocation}?page=requests">My Requests</a>
            </li>
            <li id="approval" class="submissiontable">
                <a href="${bundle.kappLocation}?page=approval">My Approvals</a>
            </li>
            <li id="closed" class="submissiontable">
                <a href="${bundle.kappLocation}?page=closed">Closed Submissions</a>
            </li>
        </ul>
    </section>
</c:if>