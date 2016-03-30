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
                    <c:if test="${not empty kapp.getAttribute('Logo Url')}">
                        <img src="${kapp.getAttributeValue('Logo Url')}" alt="logo">
                    </c:if>
                    <c:if test="${empty kapp.getAttribute('Logo Url')}">
                        <i class="fa fa-home"></i> ${text.escape(kapp.name)}
                    </c:if>
                </a>
            </c:if>
        </div>

        <div class="collapse navbar-collapse" id="navbar-collapse-1">
            <ul class="nav navbar-nav navbar-right">
                <li class="dropdown">
                    <a id="drop1" href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">
                        <i class="fa fa-user fa-fw"></i>
                        ${text.escape(identity.username)}
                        <span class="fa fa-caret-down fa-fw"></span>
                    </a>
                    <ul class="dropdown-menu" aria-labelledby="drop1">
                        <c:choose>
                            <c:when test="${identity.anonymous}">
                                <li><a href="${bundle.spaceLocation}/app/login"><i class="fa fa-sign-in fa-fw"></i> Login</a></li>
                            </c:when>
                            <c:otherwise>
                                <c:if test="${kapp == null}">
                                    <li><a href="${bundle.spaceLocation}/?page=profile"><i class="fa fa-pencil fa-fw"></i> Edit Profile</a></li>
                                </c:if>
                                <c:if test="${kapp != null}">
                                    <li><a href="${bundle.spaceLocation}/${kapp.slug}?page=profile"><i class="fa fa-pencil fa-fw"></i> Edit Profile</a></li>
                                </c:if>
                                <li class="divider"></li>
                                <li><a href="${bundle.spaceLocation}/app/"><i class="fa fa-dashboard fa-fw"></i> Management Console</a></li>
                                <li class="divider"></li>
                                <li><a href="${bundle.spaceLocation}/app/logout"><i class="fa fa-sign-out fa-fw"></i> Logout</a></li>
                            </c:otherwise>
                        </c:choose>
                    </ul>
                </li>
                <li class="dropdown">
                    <a id="drop2" href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"><span class="hidden-lg hidden-md">Kapps <span class="fa fa-caret-down fa-fw"></span></span><span class="hidden-sm hidden-xs fa fa-th fa-fw"></span></a>
                    <ul class="dropdown-menu" aria-labelledby="drop2">
                        <c:forEach items="${space.kapps}" var="kapp">
                            <li><a href="/kinetic/${space.slug}/${kapp.slug}/">${kapp.name}</a></li>
                        </c:forEach>
                    </ul>
                </li>
            </ul>
        <c:if test="${kapp != null}">
            <div class="navbar-form" role="search" style='margin-right:1em;'>
                <form action="${bundle.kappLocation}" method="GET" role="form">
                    <div class="form-group">
                            <input type="hidden" value="search" name="page">
                            <input  type="text" class="states form-control predictiveText x" name="q" placeholder="Search Forms…" autocomplete="off" autofocus="autofocus">
                        </div>
                    </div>
                </form>
            </div>
        </c:if>
        </div>
    </div>
</nav>
