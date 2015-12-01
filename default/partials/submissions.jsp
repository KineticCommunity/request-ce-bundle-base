<%@page pageEncoding="UTF-8" contentType="text/html" trimDirectiveWhitespaces="true"%>
<%@include file="../bundle/initialization.jspf" %>
<table class="table table-striped table-hover">
    <thead>
        <tr>
            <th class="date">Created At</th>
            <th>Form</th>
            <th class="nosort">Submission</th>
            <th>Created By</th>
            <th>State</th>

        </tr>
    </thead>
    <tbody>
        <c:forEach items="${submissionsList}" var="submission">
            <tr>
                <td>${submission.createdAt}</td>
                <td>${app:escape(submission.form.name)}</td>
                <td><a href="${bundle.spaceLocation}/submissions/${submission.id}">${submission.label}</a></td>
                <td>${app:escape(submission.createdBy)}</td>
                <td>${submission.coreState}</td>
            </tr>
        </c:forEach>
    </tbody>
</table>
