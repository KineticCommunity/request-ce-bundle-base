<%@page pageEncoding="UTF-8" contentType="text/html" trimDirectiveWhitespaces="true"%>
<%@include file="../bundle/initialization.jspf" %>
<footer>
    <div class="container">
      <div class="col-xs-6">
        <img src='${bundle.location}/images/ProductName-Request.png' class='desaturate' height="40"/>
      </div>
      <c:if test="${not empty identity}">
        <div class="build col-xs-6">
          <dl class="dl-horizontal">
            <dt>Build Date:</dt>
            <dd>${buildDate}</dd>
            <dt>Version:</dt>
            <dd>${buildVersion}</dd>
            <dt>Bundle:</dt>
            <dd>Default <a href='https://github.com/kineticdata/request-ce-bundle-default' target="_blank">(Learn More)</a></dd>
          </dl>
        </div>
      </c:if>
    </div>
</footer>
