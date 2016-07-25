
<%@include file="../bundle/initialization.jspf" %>
<c:if test="${!(identity.anonymous)}">
    <section class="menu">
        <span class="scroller scroller-left hidden-lg"><i class="fa fa-chevron-left"></i></span>
        <span class="scroller scroller-right hidden-lg"><i class="fa fa-chevron-right"></i></span>
        <div class="scroll-wrapper">
          <ul class="nav nav-pills list">
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
        </div>

    </section>
</c:if>
