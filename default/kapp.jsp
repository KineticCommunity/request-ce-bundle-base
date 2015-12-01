<%@page pageEncoding="UTF-8" contentType="text/html" trimDirectiveWhitespaces="true"%>
<%@include file="bundle/initialization.jspf" %>

<bundle:layout page="layouts/layout.jsp">
    <bundle:variable name="head">
        <title>Kinetic Data ${app:escape(kapp.name)}</title>
    </bundle:variable>
    <section class="menu">
        <ul class="nav nav-pills">
            <c:set var="pageHome" value="${kapp.getForm('home')}" scope="page"/>

            <li role="presentation" class="active">
                <a href="#tab-home" aria-controls="tab-home" role="tab" data-toggle="tab">Home</a>
            </li>
            <li role="presentation">
                <a href="#tab-requests" aria-controls="tab-requests" role="tab" data-toggle="tab">My Requests</a>
            </li>
        </ul>
    </section>
    <div class="tab-content">
        <div role="tabpanel" class="tab-pane active" id="tab-home">
            <div class="row">
                <div class="col-xs-12">
                    <div class="row">
                        <div class="col-md-8">
                            <h2>Service Items</h2>
                            <c:import url="partials/categoryForms.jsp" charEncoding="UTF-8"/>
                        </div>
                        <div class="col-md-4">
                            <h2>Sidebar</h2>
                            <a class="twitter-timeline" href="https://twitter.com/KineticData" data-widget-id="671770080775184385">Tweets by @KineticData</a> <script>!function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0],p=/^http:/.test(d.location)?'http':'https';if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src=p+"://platform.twitter.com/widgets.js";fjs.parentNode.insertBefore(js,fjs);}}(document,"script","twitter-wjs");</script>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div role="tabpanel" class="tab-pane" id="tab-requests">
            <h3>Identity: ${identity.username}</h3>
            <c:import url="partials/mySubmissions.jsp" charEncoding="UTF-8" />
        </div>
    </div>



    <app:bodyContent/>
</bundle:layout>
