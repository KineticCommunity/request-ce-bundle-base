<%@page pageEncoding="UTF-8" contentType="text/html" trimDirectiveWhitespaces="true"%>
<%@include file="bundle/initialization.jspf" %>
<bundle:layout page="layouts/layout.jsp">
    <bundle:variable name="head">
        <title>${text.escape(kapp.name)} Login</title>
    </bundle:variable>
      <c:choose>
        <c:when test="${not empty idpDiscoReturnParam}">
            <h1>Identity Provider Selection</h1>
            <section>
                <form action="${idpDiscoReturnURL}" method="GET">
                    <c:forEach var="idp" items="${idps}">
                        <div class="form-group">
                            <label>
                                <input type="radio" name="${idpDiscoReturnParam}" id="idp_${idp.value}" value="${idp.value}" />
                                ${idp.key}
                            </label>
                        </div>
                    </c:forEach>
                    <p>
                        <input type="submit" value="Login" class="btn btn-default"/>
                    </p>
                </form>
            </section>
        </c:when>
        <c:otherwise>
            <h1>Login</h1>
            <section>
                <form action="<c:url value="/${space.slug}/app/login.do"/>" method="POST">
                    <!-- CSRF Token field -->
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>

                    <!-- Space to login to -->
                    <input type="hidden" name="j_space" value="${space.slug}"/>

                    <!-- Kapp to login to -->
                    <input type="hidden" name="j_kapp" value="${kapp.slug}"/>

                    <!-- Username field -->
                    <div class="form-group">
                        <label for="j_username">Username</label>
                        <input type="text" name="j_username" id="j_username" class="form-control" autofocus/>
                    </div>

                    <!-- Password field -->
                    <div class="form-group">
                        <label for="j_password">Password</label>
                        <input type="password" name="j_password" id="j_password" class="form-control" autocomplete="off"/>
                    </div>

                    <div class="form-group">
                        <button type="submit" class="btn btn-default">Login</button>
                         <c:if test="${not empty hasSAML and hasSAML}">
                            <a class="btn btn-default" href="<c:url value="/${space.slug}/app/saml/login/alias/${space.slug}"/>">Login with SAML</a>
                        </c:if>
                    </div>
                </form>
            </section>
        </c:otherwise>
    </c:choose>
</bundle:layout>
