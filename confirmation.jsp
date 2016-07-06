<%@page pageEncoding="UTF-8" contentType="text/html" trimDirectiveWhitespaces="true"%>
<%@include file="bundle/initialization.jspf" %>
<bundle:layout page="layouts/form.jsp">
    <bundle:variable name="head">
        <title>${text.escape(form.name)}</title>
    </bundle:variable>
    <section class="page">
        <div class="page-header">
            <h1>${text.escape(form.name)}</h1>
        </div>
        <div class='content'>
            <div class='row'>
                <div class="col-xs-12">
                    <%--  If no confirmation page is defined for the form,
                        use the default text below, otherwise use the page content.
                        An empty 'current page' means there is no page defined.
                    --%>
                    <c:choose>
                        <c:when test='${empty submission.currentPage}'>
                            <h4>Thank you for your submission</h4>
                            <p><a href="${bundle.kappLocation}/${form.slug}">Submit again</a></p>
                            <p><a href="${bundle.kappLocation}">Return to ${kapp.name}</a></p>
                        </c:when>
                        <c:otherwise>
                            <app:bodyContent/>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </section>
</bundle:layout>
