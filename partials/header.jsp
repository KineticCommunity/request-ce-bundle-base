<%@page pageEncoding="UTF-8" contentType="text/html" trimDirectiveWhitespaces="true"%>
<%@include file="../bundle/initialization.jspf" %>
<nav class="navbar navbar-default">
    <div class="container">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse"
            data-target="#navbar-collapse-1" aria-expanded="false">
            <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <c:if test="${kapp != null}">
                <a class="navbar-brand" href="${bundle.kappLocation}">
                    <c:choose>
                        <c:when test="${not empty kapp.getAttribute('Logo Url') && not empty kapp.getAttributeValue('Logo Url')}">
                            <img src="${kapp.getAttributeValue('Logo Url')}" alt="logo">
                        </c:when>
                        <c:when test="${not empty kapp.getAttributeValue('Company Name')}">
                            <i class="fa fa-home"></i> ${kapp.getAttributeValue("Company Name")}
                        </c:when>
                        <c:otherwise>
                            <i class="fa fa-home"></i> ${kapp.name}
                        </c:otherwise>
                    </c:choose>
                </a>
            </c:if>
        </div>
        <div class="collapse navbar-collapse" id="navbar-collapse-1">
            <ul class="nav navbar-nav navbar-right">
                <li class="dropdown keep-open">
                    <c:choose>
                        <c:when test="${identity.anonymous && kapp == null}">
                            <a href="${bundle.spaceLocation}/app/login" ><i class="fa fa-sign-in fa-fw"></i> Login</a>
                        </c:when>
                        <c:when test="${identity.anonymous}">
                            <a href="${bundle.spaceLocation}/app/login?kapp=${kapp.slug}" ><i class="fa fa-sign-in fa-fw"></i> Login</a>
                        </c:when>
                        <c:otherwise>
                            <a id="drop1" href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">
                                <i class="fa fa-user fa-fw"></i> ${text.escape(text.trim(identity.displayName, identity.username))} <span class="fa fa-caret-down fa-fw"></span>
                            </a>
                            <ul class="dropdown-menu show-xs priority" aria-labelledby="drop1">
                                <li class="hidden-xs"><a href="${bundle.spaceLocation}/?page=profile">
                                    <i class="fa fa-pencil fa-fw"></i> Edit Profile</a>
                                </li>
                                <li class="priority hidden-lg hidden-md hidden-sm">
                                    <a href="${bundle.spaceLocation}/?page=profile"><i class="fa fa-user fa-fw"></i> Profile</a>
                                </li>
                                <li class="divider hidden-xs"></li>
                                <li class="hidden-xs"><a href="${bundle.spaceLocation}/app/">
                                    <i class="fa fa-dashboard fa-fw"></i> Management Console</a>
                                </li>
                                <li class="divider hidden-xs"></li>
                                <li><a href="${bundle.spaceLocation}/app/logout">
                                    <i class="fa fa-sign-out fa-fw"></i> Logout</a>
                                </li>
                            </ul>
                        </c:otherwise>
                    </c:choose>
                </li>
                <c:if test="${!(identity.anonymous)}">
                    <li class="dropdown">
                        <a id="drop2" href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">
                            <span class="hidden-lg hidden-md">Kapps
                            <span class="fa fa-caret-down fa-fw"></span></span>
                            <span class="hidden-sm hidden-xs fa fa-th fa-fw"></span>
                        </a>
                        <ul class="dropdown-menu" aria-labelledby="drop2">
                            <c:forEach items="${space.kapps}" var="kapp">
                                <li><a href="/kinetic/${space.slug}/${kapp.slug}/">${kapp.name}</a></li>
                            </c:forEach>
                        </ul>
                    </li>
                </c:if>
            </ul>
            <c:if test="${!(identity.anonymous)}">
                <c:if test="${kapp != null}">
                    <div class="navbar-form" role="search" style='margin-right:1em;'>
                        <form action="${bundle.kappLocation}" method="GET" role="form">
                            <div class="form-group">
                                    <input type="hidden" value="search" name="page">
                                    <%--removed the states and x from the class. if this note is still here by 8/22/16 delete it.--%>
                                    <input  type="text" class="form-control predictiveText" name="q" placeholder="Search Forms…" autocomplete="off" autofocus="autofocus">
                                </div>
                            </div>
                        </form>
                    </div>
                </c:if>
            </c:if>
        </div>
    </div>
</nav>

<style media="screen">
  .in .keep-open .dropdown-menu{
    display: block;
    position: static;
    float: none;
    width: auto;
    margin-top: 0;
    background-color: transparent;
    border: 0;
    -webkit-box-shadow: none;
    box-shadow: none;
  }
</style>
