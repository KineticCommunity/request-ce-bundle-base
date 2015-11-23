<%@page pageEncoding="UTF-8" contentType="text/html" trimDirectiveWhitespaces="true"%>
<%@include file="../bundle/initialization.jspf" %>
<table class="table table-striped table-hover">
    <thead>
        <tr>
            <th class="date">Created At</th>
            <th>Created By</th>
            <th>Form</th>
            <th>State</th>
            <th class="nosort">Submission</th>
        </tr>
    </thead>
    <tbody>
        <c:forEach items="${submissionsList}" var="submission">
            <tr>
                <td>${submission.createdAt}</td>
                <td>${app:escape(submission.createdBy)}</td>
                <td>${app:escape(submission.form.name)}</td>
                <td>${submission.coreState}</td>
                <!-- Convert this to submission.label after KCORE-335 is resolved. -->
                <td><a href="${bundle.spaceLocation}/submissions/${submission.id}">${submission.label}</a></td>
            </tr>
        </c:forEach>
    </tbody>
</table>
