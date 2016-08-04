
<%@include file="../bundle/initialization.jspf" %>
<c:if test="${!(identity.anonymous)}">
    <section class="menu-nav">
          <ul id="tab-nav" class="nav nav-pills">
              <c:set var="pageHome" value="${kapp.getForm('home')}" scope="page"/>
              <li id="home">
                  <a href="${bundle.kappLocation}">Home</a>
              </li>
              <li id="requests" class="submissiontable">
                  <a href="${bundle.kappLocation}?page=requests">My Requests</a>
              </li>
              <li id="approvals" class="submissiontable">
                  <a href="${bundle.kappLocation}?page=approvals">My Approvals</a>
              </li>
              <li id="closed" class="submissiontable">
                  <a href="${bundle.kappLocation}?page=closed">Closed Submissions</a>
              </li>
          </ul>

    </section>
</c:if>
