<%@include file="bundle/initialization.jspf" %>
<bundle:layout page="layouts/layout.jsp">
    <bundle:variable name="head">
        <title>${text.escape(kapp.name)} Login</title>
    </bundle:variable>
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
                <label for="j_username">${resourceBundle.getString("auth.login.username")}</label>
                <input type="text" name="j_username" id="j_username" class="form-control" autofocus/>
            </div>

            <!-- Password field -->
            <div class="form-group">
                <label for="j_password">${resourceBundle.getString("auth.login.password")}</label>
                <input type="password" name="j_password" id="j_password" class="form-control" autocomplete="off"/>
            </div>

            <div class="form-group">
                <button type="submit" class="btn btn-default">${resourceBundle.getString("auth.login.submit")}</button>
            </div>
        </form>
    </section>
</bundle:layout>
