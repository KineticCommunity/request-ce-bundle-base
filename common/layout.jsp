<%@page pageEncoding="UTF-8" contentType="text/html" trimDirectiveWhitespaces="true"%>
<%@include file="bundle/initialization.jspf" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <link rel="apple-touch-icon" sizes="76x76" href="${bundle.location}/common/images/apple-touch-icon.png">
        <link rel="icon" type="image/png" href="${bundle.location}/common/images/android-chrome-96x96.png" sizes="96x96">
        <link rel="icon" type="image/png" href="${bundle.location}/common/images/favicon-32x32.png" sizes="32x32">
        <link rel="icon" type="image/png" href="${bundle.location}/common/images/favicon-96x96.png" sizes="96x96">
        <link rel="icon" type="image/png" href="${bundle.location}/common/images/favicon-16x16.png" sizes="16x16">
        <link rel="shortcut icon" href="${bundle.location}/common/images/favicon.ico" type="image/x-icon"/>
        <bundle:stylepack>
            <bundle:style>${bundle.path}/common/libraries/bootstrap/bootstrap.min.css</bundle:style>
            <bundle:style>${bundle.path}/common/css/bundle.css</bundle:style>
        </bundle:stylepack>

        <link href="${bundle.location}/common/libraries/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css"/>

        <bundle:scriptpack>
            <bundle:script>${bundle.path}/common/libraries/jquery/jquery.min.js</bundle:script>
            <bundle:script>${bundle.path}/common/libraries/bootstrap/bootstrap.min.js</bundle:script>
        </bundle:scriptpack>

        <app:headContent/>
        <bundle:yield name="head"/>
    </head>
    <body>
        <bundle:yield/>
    </body>
</html>
