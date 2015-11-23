<%@page pageEncoding="UTF-8" contentType="text/html" trimDirectiveWhitespaces="true"%>
<%@include file="bundle/initialization.jspf" %>
<bundle:layout page="layouts/layout.jsp">
    <bundle:variable name="head">
        <title>${app:escape(form.name)}</title>
    </bundle:variable>
    <section class="timeline">
        <div class="content">
            <div class="row">
                <div class="col-xs-4">
                    <div class="item-meta">
                        <h1>submission.form.name</h1>
                        <h4>Request ID:</h4>
                        <h4>submission.id</h4>

                        <h4>Request Date:</h4>
                        <h4>submission.submittedAt</h4>

                        <h4>Status:</h4>
                        <h4>submission.coreState</h4>

                        <p>This could be instructions. This could be a brief description. This could also be a status update. Esto podría ser instrucciones. Esto podría ser una breve descripción. Esto también podría ser una actualización de estado. Kini mahimong mga panudlo. Kini mahimo nga usa ka mubo nga paghulagway. Kini mahimo usab nga usa ka status update.</p>
                    </div>
                </div>
                <div class="col-xs-8">
                    <div class="timeline">
                        <ul>
                            <c:forEach begin="0" end="10" varStatus="loop">
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
</bundle:layout>