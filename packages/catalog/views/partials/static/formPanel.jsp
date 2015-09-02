<%@page pageEncoding="UTF-8" contentType="text/html" trimDirectiveWhitespaces="true"%>
<%@include file="../../../package/initialization.jspf" %>
<jsp:useBean id="random" class="java.util.Random" scope="application" />
<div class="panel">
    <div class="panel-body">
        <a href="${bundle.kappLocation}/${thisForm.slug}">
          <span class="fa fa-${['adjust','bank','cloud','desktop','eye','file-image-o','globe'][random.nextInt(6)]}"/>

        </a>
    </div>
    <div class="panel-footer clearfix">
      <a href="${bundle.kappLocation}/${thisForm.slug}">
        ${app:escape(thisForm.name)}
      </a>
    </div>
</div>
