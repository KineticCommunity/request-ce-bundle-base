<%@page pageEncoding="UTF-8" contentType="text/html" trimDirectiveWhitespaces="true"%>
<%@include file="../bundle/initialization.jspf" %>
<jsp:useBean id="random" class="java.util.Random" scope="application" />
<div class="col-sm-4">
    <div class="card small primary">
        <div class="card-content">
            <span class="fa fa-${['adjust','bank','cloud','desktop','eye','file-image-o','globe'][random.nextInt(6)]}"></span>
            <span class="card-title">
                <a href="${bundle.kappLocation}/${thisForm.slug}">
                    ${app:escape(thisForm.name)}
                </a>
            </span>
            <p>${app:escape(thisForm.description)}</p>
            
        </div>
        <div class="card-action clearfix">
            <a href="${bundle.kappLocation}/${thisForm.slug}">
                Submit Form
            </a>
        </div>
    </div>
</div>