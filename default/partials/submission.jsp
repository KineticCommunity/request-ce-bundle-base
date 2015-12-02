<%@page pageEncoding="UTF-8" contentType="text/html" trimDirectiveWhitespaces="true"%>
<%@include file="../bundle/initialization.jspf" %>
<c:set var="submission" value="${submissions.retrieve(param.submission_id)}" scope="page"/>

<section class="timeline">
    <div class="content">
        <div class="row">
            <div class="col-xs-12">
              <p>
                <a href='${bundle.kappLocation}'>Return to catalog</a>
              </p>
            <div>
        </div>
        <div class="row">
            <div class="col-xs-4">
                <div class="item-meta">
                    <h1>${submission.form.name}</h1>
                    <h4>Label:</h4>
                    <h4>${submission.label}</h4>

                    <h4>Request Date:</h4>
                    <h4>${submission.submittedAt}</h4>

                    <h4>Status:</h4>
                    <h4>${submission.coreState}</h4>

                    <p>${submission.form.description}</p>
                </div>
            </div>
            <div class="col-xs-8">
                <div class="timeline">
                    <ul>
                        <c:forEach begin="0" end="2" varStatus="loop">
                            <li class="arrow-box">
                                <div class="arrow-box-content">
                                    <h4>WWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW</h4>
                                    <h4>task.getCreateDate</h4>
                                    <p class="font-bold gray">task.getResult('output')</p>
                                </div>
                            </li>
                            <li class="arrow-box">
                                <div class="arrow-box-content">
                                    <h4>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Nostrum distinctio, cumque ipsa placeat voluptas. Nam officiis voluptatibus ut architecto repellat voluptates dolor, molestias deserunt aliquid voluptate error, explicabo eveniet adipisci.</h4>
                                    <h4>task.getCreateDate</h4>
                                    <p class="font-bold gray">task.getResult('output')</p>
                                </div>
                            </li>
                        </c:forEach>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</section>
