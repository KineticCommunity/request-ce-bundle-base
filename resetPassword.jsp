<%@page pageEncoding="UTF-8" contentType="text/html" trimDirectiveWhitespaces="true"%>
<%@include file="bundle/initialization.jspf" %>
<bundle:layout page="layouts/layout.jsp">
    <bundle:variable name="head">
        <title>${text.escape(space.name)} Reset Password</title>
    </bundle:variable>

    <c:choose>
        <%-- REQUEST RESET PASSWORD TOKEN --%>
        <c:when test="${param.token == null && param.confirmation == null}">
            <!-- Password reset -->
            <form action="<c:url value="/${space.slug}/app/reset-password"/>" method="POST">
                <c:if test="${param.badtoken != null}">
                    <div class="alert alert-danger">
                        Your password reset token was not valid. Please try again.
                    </div>
                </c:if>

                <!-- Username field -->
                <div class="form-group">
                    <label for="username">Username</label>
                    <input type="text" name="username" id="username" class="form-control" autofocus value="${param.username}"/>
                </div>
                <!-- CSRF field -->
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                <!-- Submit buttons -->
                <div class="form-group">
                    <button type="submit" class="btn btn-default">Reset Password</button>
                    <a href="<c:url value="/${space.slug}/app/reset-password?confirmation"/>">I already have a reset code.</a>
                </div>
            </form>
        </c:when>
        <%-- RESET PASSWORD --%>
        <c:otherwise>
            <!-- Password reset confirmation -->
            <form action="<c:url value="/${space.slug}/app/reset-password/token"/>" method="POST">
                <h3>Password Reset</h3>
                <p>
                    You will receive an email with a unique code which will enable you to reset your password. Type that
                    password into the token field and enter your new desired password.
                </p>

                <%-- Passwords not matching --%>
                <c:if test="${param.nomatch != null}">
                    <div class="alert alert-danger">
                        Your passwords did not match.
                    </div>
                </c:if>

                <!-- Username field -->
                <div class="form-group">
                    <label for="username">Username</label>
                    <input type="text" name="username" id="username" class="form-control" value="${param.username}"/>
                </div>
                <!-- Token field -->
                <div class="form-group">
                    <label for="token">Password Reset Token</label>
                    <input type="text" name="token" id="token" class="form-control" value="${param.token}" autofocus/>
                </div>
                <!-- Password field -->
                <div class="form-group">
                    <label for="password">New Password</label>
                    <input type="password" name="password" id="password" class="form-control"/>
                </div>
                <!-- Password Confirmation field -->
                <div class="form-group">
                    <label for="confirmPassword">Confirm Password</label>
                    <input type="password" name="confirmPassword" id="confirmPassword" class="form-control"/>
                </div>
                <!-- CSRF field -->
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>

                <!-- Submit buttons -->
                <div class="form-group">
                    <button type="submit" class="btn btn-default">Submit</button>
                    <a href="<c:url value="/${space.slug}/app/reset-password"/>">I don't have a reset code.</a>
                </div>
            </form>
        </c:otherwise>
    </c:choose>
</bundle:layout>