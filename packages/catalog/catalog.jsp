<%@page pageEncoding="UTF-8" contentType="text/html" trimDirectiveWhitespaces="true"%>
<%@include file="package/initialization.jspf" %>
<bundle:layout page="views/layouts/packageLayout.jsp">

    <bundle:variable name="head">
        <title>Kinetic Data ${app:escape(kapp.name)}</title>
    </bundle:variable>

    <div class="row">
        <div class="col-xs-12">
            <div class="row">
                <div class="col-md-8">
                    <c:import url="views/partials/static/categoryForms.jsp" charEncoding="UTF-8"/>
                </div>
            </div>
        </div>
    </div>

    <app:bodyContent/>
</bundle:layout>
