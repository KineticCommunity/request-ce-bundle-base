<%@page pageEncoding="UTF-8" contentType="text/html" trimDirectiveWhitespaces="true"%>
<%@include file="bundle/initialization.jspf" %>
<c:set var="submission" value="${Submissions.retrieve(param.submission_id)}" scope="page"/>
<section class="menu">
    <div class="row">
        <div class="col-xs-12">
            <h3>
                <a href='${bundle.kappLocation}'>Return to catalog</a>
            </h3>
        <div>
    </div>
</section>
<section class="timeline">
    <div class="row">
        <div class="col-xs-4">
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
        <div class="col-xs-8">
            <div class="timeline-block">
              <c:forEach var="run" items="${TaskRuns.find(submission)}">
                <ul>
                    <c:forEach var="task" items="${run.tasks}">
                      <li class="timeline-status">
                          <div class="timeline-status-content">
                              <h4>${text.escape(task.name)}</h4>
                              <h5>${text.escape(task.createdAt)}</h5>
                              <p>${text.escape(task.results)}</p>
                          </div>
                      </li>
                    </c:forEach>
                </ul>
              </c:forEach>
            </div>
        </div>
    </div>

</section>
