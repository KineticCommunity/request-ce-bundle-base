<%@page pageEncoding="UTF-8" contentType="text/html" trimDirectiveWhitespaces="true"%>
<%@include file="bundle/initialization.jspf" %>

<bundle:layout page="layouts/layout.jsp">

  <c:choose>
    <c:when test="${param.submission_id != null}">
      <c:import url="partials/submission.jsp" charEncoding="UTF-8" />
    </c:when>
    <c:otherwise>
      <c:import url="partials/catalog.jsp" charEncoding="UTF-8" />
    </c:otherwise>
  </c:choose>
  <app:bodyContent/>

</bundle:layout>
