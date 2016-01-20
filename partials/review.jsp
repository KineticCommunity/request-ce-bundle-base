<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page pageEncoding="UTF-8" contentType="text/html" trimDirectiveWhitespaces="true"%>
<%@include file="../bundle/initialization.jspf" %>

<div class="review">
    <ul class="nav nav-tabs">
        <c:set var="activePage" value="${param.review.isEmpty() ? pages.get(0) : param.review}"/>
        <c:forEach var="page" items="${pages}">
            <li class="${page == activePage ? "active" : ""}">
                <a href="${bundle.spaceLocation}/submissions/${submission.id}?review=${page}"
                   data-review="${page}">${page}</a>
            </li>
        </c:forEach>
    </ul>
</div>