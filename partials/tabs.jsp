<%@page pageEncoding="UTF-8" contentType="text/html" trimDirectiveWhitespaces="true"%>
<%@include file="../bundle/initialization.jspf" %>

<section class="menu">
    <ul class="nav nav-pills">
        <c:set var="pageHome" value="${kapp.getForm('home')}" scope="page"/>
        <li role="presentation" class="active">
            <a href="${bundle.kappLocation}">Home</a>
        </li>
        <li id="service" class="submissiontable" role="presentation">
            <a href="${bundle.kappLocation}?page=service">My Requests</a>
        </li>
        <li id="approval" class="submissiontable" role="presentation">
            <a href="${bundle.kappLocation}?page=approval">My Approvals</a>
        </li>
        <li id="test" class="submissiontable" role="presentation">
            <a href="${bundle.kappLocation}?page=complete">Complete Submissions</a>
        </li>
    </ul>
</section>
