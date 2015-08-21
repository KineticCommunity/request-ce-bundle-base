<%@page pageEncoding="UTF-8" contentType="text/html" trimDirectiveWhitespaces="true"%>
<%@include file="../../../package/initialization.jspf" %>
<c:forEach items="${kapp.getCategory(param.category).forms}" var="categoryForm">
    <c:if test="${categoryForm.status eq 'New' || categoryForm.status eq 'Active'}">
        <li>
            <h3>
                <a href="${bundle.kappLocation}/${categoryForm.slug}">
                    <i class="fa ${categoryForm.getAttribute("Image Class").value} fa-fw"></i> ${app:escape(categoryForm.name)}</a>
            </h3>
            <c:if test="${not empty categoryForm.description}">
            <p>${categoryForm.description}</p>
            </c:if>
        </li>
    </c:if>
</c:forEach>
