<%@page pageEncoding="UTF-8" contentType="text/html" trimDirectiveWhitespaces="true"%>
<%@include file="package/initialization.jspf" %>
<bundle:layout page="views/layouts/packageLayout.jsp">
    <bundle:variable name="head">
        <title>${app:escape(form.name)}</title>
    </bundle:variable>
    <h3><span class="fa ${app:escape(form.getAttribute('Image Class').value)}"></span> ${app:escape(form.name)}</h3>
    <div class="errors"></div>
    <div>
        <app:bodyContent/>
    </div>
</bundle:layout>
