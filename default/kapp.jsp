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
                            <c:import url="partials/categoryForms.jsp" charEncoding="UTF-8"/>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div role="tabpanel" class="tab-pane" id="tab-requests">
            <h1>Identity: ${identity.username}</h1>
            <c:import url="partials/submissionsByKapp.jsp" charEncoding="UTF-8" />
        </div>
    </div>



    <app:bodyContent/>
</bundle:layout>
