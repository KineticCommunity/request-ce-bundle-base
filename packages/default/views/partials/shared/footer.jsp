<%@page pageEncoding="UTF-8" contentType="text/html" trimDirectiveWhitespaces="true"%>
<%@include file="../../../package/initialization.jspf" %>
<footer>
    <div class="container">
      <div class="col-xs-8">
        <img src='${bundle.location}/packages/default/images/ProductName-Request.png' class='desaturate' height="40"/>
      </div>
      <div class="build col-xs-4 text-right">
        <div>Build Date: ${buildDate}</div>
        <div>Build Number: ${buildNumber}</div>
        <div>Version: ${buildVersion}</div>
      </div>
    </div>
</footer>
