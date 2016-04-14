<%@page pageEncoding="UTF-8" contentType="application/json" trimDirectiveWhitespaces="true"%>
<%@include file="../bundle/initialization.jspf" %>
<%
    int x = 1;
    %>
<fmt:parseNumber var="length" type="number" value="${param.length}" />
<c:set scope="request" var="submissionsList" 
        value="${SubmissionHelper.retrieveRecentSubmissions('Template',length)}"/>


<json:object>
    <json:property name="token" value="${submissionList.nextPageToken}" />
    <json:property name="draw" value="${1}" />
    <json:property name="recordsTotal" value="${fn:length(submissionsList)}" />
    <json:property name="recordsFiltered" value="${fn:length(submissionsList)}" />
    <json:property name="header" value="${length}" />
    <json:array name="data">
        <c:forEach var="submission" items="${submissionsList}">
            <json:object>
                <json:property name="created_at" value="${submission.createdAt}" />
                <json:property name="form_name" value="${submission.form.name}" />
                <json:property name="submission_id" value="${submission.id}" />
                <json:property name="created_by" value="${submission.createdBy}" />
                <json:property name="state" value="${submission.coreState}" />
            </json:object>
        </c:forEach>
    </json:array>
</json:object>
