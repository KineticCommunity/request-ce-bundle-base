
<%@include file="../bundle/initialization.jspf" %>
<jsp:useBean id="random" class="java.util.Random" scope="application" />
<div class="col-sm-4">
    <div class="card small">
        <div class="card-content">
            <span class="fa ${empty thisForm.getAttribute('Icon') ? 'fa-star' : thisForm.getAttributeValue('Icon')} secondary-color"></span>
            <span class="card-title">
                <a href="${bundle.kappLocation}/${thisForm.slug}">
                    ${text.escape(thisForm.name)}
                </a>
            </span>
            <p>${text.escape(thisForm.description)}</p>

        </div>
        <div class="card-action clearfix">
            <a href="${bundle.kappLocation}/${thisForm.slug}">
                Submit Form
            </a>
        </div>
    </div>
</div>
