<%@page pageEncoding="UTF-8" contentType="text/html" trimDirectiveWhitespaces="true"%>
<%@include file="bundle/initialization.jspf" %>
<bundle:layout page="layouts/layout.jsp">
    <bundle:variable name="head">
        <title>${app:escape(form.name)}</title>
    </bundle:variable>
    <div class='container'>
      <section class="page">
        <div class="page-header">
          <h1>${app:escape(form.name)}</h1>
        </div>
        <div class="errors"></div>
        <app:bodyContent/>
      </section>
    </div>
</bundle:layout>
