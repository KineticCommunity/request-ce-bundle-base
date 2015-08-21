<%@page pageEncoding="UTF-8" contentType="text/html" trimDirectiveWhitespaces="true"%>
<%@include file="../../../../package/initialization.jspf" %>
<table id="datatable">
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
                <td><a href="${bundle.spaceLocation}/submissions/${submission.id}">${submission.id}</a></td>
            </tr>
        </c:forEach>
    </tbody>
</table>
