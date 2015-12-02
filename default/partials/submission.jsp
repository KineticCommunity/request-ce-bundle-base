<%@page pageEncoding="UTF-8" contentType="text/html" trimDirectiveWhitespaces="true"%>
<%@include file="../bundle/initialization.jspf" %>
<c:set var="submission" value="${submissions.retrieve(param.submission_id)}" scope="page"/>
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
                <ul>
                    <c:forEach begin="0" end="2" varStatus="loop">
                    <li class="timeline-status">
                        <div class="timeline-status-content">
                            <h4>WWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW</h4>
                            <h5>task.getCreateDate</h5>
                            <p>task.getResult('output')</p>
                        </div>
                    </li>
                    <li class="timeline-status">
                        <div class="timeline-status-content">
                            <h4>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Nostrum distinctio, cumque ipsa placeat voluptas. Nam officiis voluptatibus ut architecto repellat voluptates dolor, molestias deserunt aliquid voluptate error, explicabo eveniet adipisci.</h4>
                            <h5>task.getCreateDate</h5>
                            <p>task.getResult('output')</p>
                        </div>
                    </li>
                    </c:forEach>
                </ul>
            </div>
        </div>
    </div>
    
</section>