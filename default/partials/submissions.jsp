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
                <td>${app.
escape(submission.form.name)}</td>
                <td>
                  <c:choose>
                    <c:when test="${submission.coreState eq 'Draft'}">
                      <a href="${bundle.spaceLocation}/submissions/${submission.id}">${app.
escape(submission.label)}</a>
                    </c:when>
                    <c:otherwise>
                      <a href="${bundle.kappLocation}?submission_id=${submission.id}">${app.
escape(submission.label)}</a>
                    </c:otherwise>
                  </c:choose>
                </td>
                <td>${app.
escape(submission.createdBy)}</td>
                <td>${submission.coreState}</td>
            </tr>
        </c:forEach>
    </tbody>
</table>
