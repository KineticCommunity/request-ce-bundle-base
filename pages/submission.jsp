<%@page pageEncoding="UTF-8" contentType="text/html" trimDirectiveWhitespaces="true"%>
<%@include file="../bundle/initialization.jspf" %>
<c:set var="submission" value="${Submissions.retrieve(param.id)}" scope="page"/>

<bundle:layout page="${bundle.path}/layouts/layout.jsp">
    <section class="menu">
        <div class="row">
            <div class="col-xs-12">
                <h3>
                <a href='${bundle.kappLocation}/#tab-requests'>Return to catalog</a>
                </h3>
            </div>
        </div>
    </section>
    <section class="timeline">
        <div class="row">
            <div class="col-md-4 col-xs-12 ">
                <div class="submission-meta">
                    <h2>${submission.form.name}</h2>
                    <dl>
                        <dt>Label:</dt>
                        <dd>${submission.label}</dd>
                        <dt>Request Date:</dt>
                        <dd>${submission.submittedAt}</dd>
                        <dt>Status:</dt>
                        <dd>${submission.coreState}</dd>
                    </dl>
                    <p>${submission.form.description}</p>
                </div>
            </div>
            <div class="col-md-8 col-xs-12 ">
                <div class="timeline-block">
                    <c:catch var="taskRunException">
                        <c:forEach var="run" items="${TaskRuns.find(submission)}">
                        <ul>
                            <c:forEach var="task" items="${run.tasks}">
                                <li class="timeline-status">
                                    <div class="timeline-status-content">
                                        <h4>${text.escape(task.name)}</h4>
                                        <h5>${text.escape(task.createdAt)}</h5>
                                        <ul>
                                            <c:forEach var="entry" items="${task.messages}">
                                                <li>${text.escape(entry.message)}</li>
                                            </c:forEach>
                                        </ul>
                                    </div>
                                </li>
                            </c:forEach>
                        </ul>
                        </c:forEach>
                    </c:catch>
                    <c:if test="${taskRunException != null}">
                        <ul>
                            <li class="timeline-status">
                                <div class="timeline-status-content">
                                There was a problem retrieving post processing task information
                                for this submission.
                                <hr>
                                ${fn:escapeXml(taskRunException.message)}
                                </div>
                            </li>
                        </ul>
                    </c:if>
                </div>
            </div>
        </div>
    </section>
</bundle:layout>
