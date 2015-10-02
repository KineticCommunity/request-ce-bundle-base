<%@page pageEncoding="UTF-8" contentType="text/html" trimDirectiveWhitespaces="true"%>
<%@include file="package/initialization.jspf" %>
<bundle:layout page="views/layouts/packageLayout.jsp">
    <bundle:variable name="head">
        <title>${app:escape(form.name)}</title>
    </bundle:variable>
    <section class="page">
      <div class="page-header">
        <h1>${app:escape(form.name)}</h1>
      </div>
      <div class='row'>
        <div class='col-xs-12'>
          <h5>Thank you for your submission</h5>
          <p><a href="${bundle.kappLocation}/${form.slug}">Submit again</a></p>
          <p><a href="${bundle.kappLocation}">Return to the catalog</a></p>
        </div>
      </div>
    </section>
</bundle:layout>
