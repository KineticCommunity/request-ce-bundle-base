<%@page pageEncoding="UTF-8" contentType="text/html" trimDirectiveWhitespaces="true"%>
<%@include file="../bundle/initialization.jspf" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, height=device-height, initial-scale=1.0, maximum-scale=1.0">
        <link rel="apple-touch-icon" sizes="76x76" href="${bundle.location}/images/apple-touch-icon.png">
        <link rel="icon" type="image/png" href="${bundle.location}/images/android-chrome-96x96.png" sizes="96x96">
        <link rel="icon" type="image/png" href="${bundle.location}/images/favicon-32x32.png" sizes="32x32">
        <link rel="icon" type="image/png" href="${bundle.location}/images/favicon-96x96.png" sizes="96x96">
        <link rel="icon" type="image/png" href="${bundle.location}/images/favicon-16x16.png" sizes="16x16">
        <link rel="shortcut icon" href="${bundle.location}/images/favicon.ico" type="image/x-icon"/>
        <app:headContent/>

        <%-- Bundle stylepack and scriptpack create a minified and single file of referanced stylesheet and javascript
        Add ?debugjs to the end of your URL to view individual files --%>

        <bundle:stylepack>
            <bundle:style src="${bundle.location}/libraries/bootstrap/bootstrap.min.css" />
            <bundle:style src="${bundle.location}/libraries/notifie/jquery.notifie.css" />
            <bundle:style src="${bundle.location}/libraries/jquery-datatables/media/css/jquery.dataTables.css" />
            <bundle:style src="${bundle.location}/libraries/jquery-datatables/extensions/Responsive/css/responsive.dataTables.css" />
            <bundle:style src="${bundle.location}/css/master.css "/>
        </bundle:stylepack>
        <link href="${bundle.location}/libraries/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css"/>
        <bundle:scriptpack>
            <bundle:script src="${bundle.location}/libraries/jquery/jquery.min.js" />
            <bundle:script src="${bundle.location}/libraries/underscore/underscore-min.js" />
            <bundle:script src="${bundle.location}/libraries/bootstrap/bootstrap.min.js" />
            <bundle:script src="${bundle.location}/libraries/moment/moment-with-locales.js" />
            <bundle:script src="${bundle.location}/libraries/moment/moment-timezone.js" />
            <bundle:script src="${bundle.location}/libraries/jquery-datatables/media/js/jquery.dataTables.js" />
            <bundle:script src="${bundle.location}/libraries/jquery-datatables/extensions/Responsive/js/dataTables.responsive.js" />
            <bundle:script src="${bundle.location}/libraries/notifie/jquery.notifie.js" />
            <bundle:script src="${bundle.location}/libraries/typeahead/typeahead.min.js" />
            <bundle:script src="${bundle.location}/libraries/jquery-datatables/extensions/moment.js" />
            <bundle:script src="${bundle.location}/js/catalog.js" />
            <bundle:script src="${bundle.location}/js/review.js" />
        </bundle:scriptpack>

        <bundle:yield name="head"/>
        <style>
            <c:if test="${not empty kapp.getAttributeValue('Logo Height Px')}">
                .navbar-brand {
                    height:${kapp.getAttributeValue('Logo Height Px')}px;
                }
            </c:if>
        </style>
    </head>
    <body>
        <div class="view-port">
            <%-- Identity will be empty on root context page (/kinetic) --%>
            <c:if test="${not empty identity}">
                <c:import url="${bundle.path}/partials/header.jsp" charEncoding="UTF-8"/>
            </c:if>
            <div class="container">
                <bundle:yield/>
            </div>
            <c:import url="${bundle.path}/partials/footer.jsp" charEncoding="UTF-8"/>
        </div>
    </body>
    <script>
        window.identity = '${identity.username}';
    </script>
</html>
