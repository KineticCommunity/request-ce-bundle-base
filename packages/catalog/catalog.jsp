<%@page pageEncoding="UTF-8" contentType="text/html" trimDirectiveWhitespaces="true"%>
<%@include file="package/initialization.jspf" %>

<bundle:layout page="views/layouts/packageLayout.jsp">
    <bundle:variable name="head">
        <title>Kinetic Data ${app:escape(kapp.name)}</title>
    </bundle:variable>
    <section class="configbar">
        <ul class="nav nav-tabs">
            <c:set var="pageHome" value="${kapp.getForm('home')}" scope="page"/>
            <li role="presentation" class="${pageHome.name eq form.name ? 'active' : ''}">
                <a href="${bundle.kappLocation}"><i class="fa ${pageHome.getAttribute('Image Class').value}"></i> Home</a>
            </li>
            <c:set var="pageRequests" value="${kapp.getForm('my-requests')}" scope="page"/>
            <li role="presentation" class="${pageRequests.name eq form.name ? 'active' : ''}">
                <a href="${bundle.kappLocation}/my-requests"><i class="fa ${pageRequests.getAttribute('Image Class').value}"></i> My Requests</a>
            </li>
        </ul>
    </section>
    <div class="row">
        <div class="col-xs-12">
            <div class="row">
                <div class="col-md-8">
                    <c:import url="views/partials/static/categoryForms.jsp" charEncoding="UTF-8"/>
                </div>
            </div>
        </div>
    </div>
    <h1>Identity: ${identity.name}</h1>
    <c:import url="views/partials/static/submissionsByKapp.jsp" charEncoding="UTF-8" />

    <app:bodyContent/>
</bundle:layout>
