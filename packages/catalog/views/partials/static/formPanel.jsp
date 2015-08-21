<%@page pageEncoding="UTF-8" contentType="text/html" trimDirectiveWhitespaces="true"%>
<%@include file="../../../package/initialization.jspf" %>
<div class="panel">
    <div class="panel-body">
        <a href="${bundle.kappLocation}/${thisForm.slug}">
            <span class="fa ${app:escape(thisForm.getAttribute('Image Class').value)}"/>
        </a>
    </div>
    <div class="panel-footer clearfix">${app:escape(thisForm.name)}</div>
</div>
