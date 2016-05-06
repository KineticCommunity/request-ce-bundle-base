<%@page pageEncoding="UTF-8" contentType="text/html" trimDirectiveWhitespaces="true"%>
<%@include file="../bundle/initialization.jspf" %>
<c:catch var="submissionException">
    <c:set var="submission" value="${Submissions.retrieve(param.id)}" scope="page"/>
</c:catch>
<bundle:layout page="${bundle.path}/layouts/layout.jsp">
    <c:choose>
        <c:when test="${submissionException != null}">
            <h3>Unable to retrieve submission</h3>
        </c:when>
        <c:otherwise>
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
                                <dt>Submission:</dt>
                                <dd>${submission.label}</dd>
                                <dt>Request Date:</dt>
                                <dd data-moment>${time.format(submission.submittedAt)}</dd>
                                <dt>Type:</dt>
                                <dd>${submission.type.name}</dd>
                                <dt>Status:</dt>
                                <dd>${submission.coreState}</dd>
                            </dl>
                            <p>${submission.form.description}</p>
                        </div>
                    </div>
                    <div class="col-md-8 col-xs-12 ">
                        <div class="timeline-block">
                            <c:choose>
                                <c:when test="${kapp.hasAttribute('Task Server Url') && kapp.hasAttribute('Task Source Name')}">
                                    <c:catch var="taskRunException">
                                        <c:set var="runSet" value="${TaskRuns.find(submission)}" />
                                    </c:catch>
                                </c:when>
                                <c:otherwise>
                                    <c:set var="runSet" value="${[]}" />
                                </c:otherwise>
                            </c:choose>
                            <c:choose>
                                <c:when test="${taskRunException != null}">
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
                                </c:when>
                                <c:when test="${empty runSet}">
                                    <div class="no-data text-center" >
                                        <img src="${bundle.location}/images/empty-state.png" alt="">
                                        <h4 style="color:#999;">There are no tasks to display for this Submission</h4>
            
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <c:forEach var="run" items="${runSet}">
                                    <ul>
                                        <c:forEach var="task" items="${run.tasks}">
                                            <li class="timeline-status">
                                                <div class="timeline-status-content">
                                                    <h4>${text.escape(task.name)}</h4>
                                                    <h5 data-moment>${task.createdAt}</h5>
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
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
            </section>
        </c:otherwise>
    </c:choose>
</bundle:layout>
