<%@page pageEncoding="UTF-8" contentType="text/html" trimDirectiveWhitespaces="true"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri = "http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="app" uri="http://kineticdata.com/taglibs/core/app" %>
<% request.setAttribute("text", new com.kineticdata.bundles.Text()); %>

<%-- Determine the location of the static folder --%>
<c:choose>
    <%-- DEVELOPMENT PROXY MODE --%>
    <c:when test="${
        (param.bundleName != null && param.bundleName == pageContext.request.getHeader('X-Webpack-Bundle-Name'))
        || 
        (param.bundleName == null && pageContext.request.getHeader('X-Webpack-Kinetic-Webserver') != null)
    }">
        <c:set var="staticLocation" value="/static"/>
    </c:when>
    <%-- 
        EXTERNAL ASSET MODE
        queryString is set to the query string specified in the space/kapp/form display page 
        property and NOT from the actual page URL.  Therefore, the queryString can be used to ensure
        the location parameter was specified in the CE configuration and not by the page URL (which
        would potentially allow an attacker craft a URL that would load a malicious bundle).
    --%>
    <c:when test="${param.location != null && fn:startsWith(param.location, 'http') && pageContext.request.queryString.contains(param.location)}">
        <c:set var="staticLocation" value="${param.location}"/>
    </c:when>
    <%-- 
        EMBEDDED ASSET MODE 
        queryString is set to the query string specified in the space/kapp/form display page 
        property and NOT from the actual page URL.  Therefore, the queryString can be used to ensure
        the location parameter was specified in the CE configuration and not by the page URL (which
        would potentially allow an attacker craft a URL that would load a malicious bundle).
    --%>
    <c:when test="${param.location != null && pageContext.request.queryString.contains(param.location)}">
        <c:set var="staticLocation" value="${bundle.location}/${param.location}"/>
    </c:when>
</c:choose>

<!doctype html>
<html>
    <head>
        <app:headContent/>
    </head>
    <body>
        <%-- Determine what to render --%>
        <c:choose>
            <%-- WEBPACK BUNDLE SCAFFOLDING --%>
            <c:when test="${staticLocation != null}">
                <div id='root'></div>
                <script>
                    bundle.config = bundle.config || {};
                    bundle.config.staticLocation = '${text.escapeJs(staticLocation)}';
                </script>
                <script src="${text.escape(staticLocation)}/bundle.js"></script>
            </c:when>
            <%-- MISSING DEVELOPMENT MODE HEADER --%>
            <c:when test="${param.bundleName != null && pageContext.request.getHeader('X-Webpack-Bundle-Name') == null}">
                The display page has been configured to support development mode with the bundleName
                "${text.escape(param.bundleName)}", but your request is not passing a value with
                for the X-Webpack-Bundle-Name header.
                <br/><br/>
                This is most often caused by connecting directly to the Kinetic Request CE webserver
                rather than to the local webpack server.
            </c:when>
            <%-- MISMATCHED BUNDLE NAME --%>
            <c:when test="${param.bundleName != null && pageContext.request.getHeader('X-Webpack-Bundle-Name') != param.bundleName}">
                The display page has been configured to support development mode with the bundleName
                "${text.escape(param.bundleName)}", but your request is passing an 
                X-Webpack-Bundle-Name header value of 
                "${text.escape(pageContext.request.getHeader('X-Webpack-Bundle-Name'))}".
            </c:when>
            <%-- MISCONFIGURATION --%>
            <c:otherwise>
                The display page for this resource has not been configured properly.
                <br/><br/>
                To render this resource in deployed mode, you must set the <b>location</b> 
                parameter.
                <br/><br/>
                If you are intending to render this in local development mode, your clientside 
                bundle is not properly setting the 'X-Webpack-Kinetic-Webserver' header (or you are 
                accidentally connecting directly to the Kinetic Request CE webserver rather than to 
                the local development webpack server).
            </c:otherwise>
        </c:choose>
    </body>
</html>