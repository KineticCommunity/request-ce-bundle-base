<%@page pageEncoding="UTF-8" contentType="text/html" trimDirectiveWhitespaces="true"%>
<%@include file="../bundle/initialization.jspf" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="apple-touch-icon" sizes="76x76" href="${bundle.location}/default/images/apple-touch-icon.png">
        <link rel="icon" type="image/png" href="${bundle.location}/default/images/android-chrome-96x96.png" sizes="96x96">
        <link rel="icon" type="image/png" href="${bundle.location}/default/images/favicon-32x32.png" sizes="32x32">
        <link rel="icon" type="image/png" href="${bundle.location}/default/images/favicon-96x96.png" sizes="96x96">
        <link rel="icon" type="image/png" href="${bundle.location}/default/images/favicon-16x16.png" sizes="16x16">
        <link rel="shortcut icon" href="${bundle.location}/default/images/favicon.ico" type="image/x-icon"/>
        <app:headContent/>
            <bundle:stylepack>
            <bundle:style src="/app/bundles/${space.slug}/default/libraries/bootstrap/bootstrap.min.css" />
            <bundle:style src="/app/bundles/${space.slug}/default/css/default.css "/>
            </bundle:stylepack>
            <link href="${bundle.location}/default/libraries/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css"/>
            <bundle:scriptpack>
            <bundle:script src="/app/bundles/${space.slug}/default/libraries/bootstrap/bootstrap.min.js" />
            <bundle:script src="/app/bundles/${space.slug}/default/libraries/jquery-datatables/jquery.dataTables.js" />
            <bundle:script src="/app/bundles/${space.slug}/default/libraries/color-thief/color-thief.min.js" />
            <bundle:script src="/app/bundles/${space.slug}/default/js/catalog.js" />
            </bundle:scriptpack>
            <bundle:yield name="head"/>
            <style>
            <c:if test="${not empty kapp.getAttribute('logo-height-px')}">
            .navbar-brand {height:${kapp.getAttribute('logo-height-px').value}px;}
            </c:if>
            </style>
        </head>
        <body>
            <div class="view-port">
                <c:if test="${not empty identity}">
                <c:import url="partials/header.jsp" charEncoding="UTF-8"/>
                </c:if>
                <div class="container">
                    <bundle:yield/>
                </div>
                <c:import url="partials/footer.jsp" charEncoding="UTF-8"/>
            </div>
        </body>
    </html>