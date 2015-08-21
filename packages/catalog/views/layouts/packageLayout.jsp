<%@page pageEncoding="UTF-8" contentType="text/html" trimDirectiveWhitespaces="true"%>
<%@include file="../../package/initialization.jspf" %>
<bundle:layout>

    <bundle:variable name="head">

        <bundle:stylepack>
            <bundle:style>${bundle.packagePath}/css/catalog.css</bundle:style>
        </bundle:stylepack>
        <bundle:scriptpack>
            <bundle:script>${bundle.packagePath}/libraries/jquery-datatables/jquery.dataTables.js</bundle:script>
            <bundle:script>${bundle.packagePath}/js/catalog.js</bundle:script>
        </bundle:scriptpack>

        <bundle:yield name="head"/>

    </bundle:variable>

    <div class="container">
        <c:import url="${bundle.packagePath}/views/partials/shared/navbar.jsp" charEncoding="UTF-8"/>

        <section class="configbar">
            <ul class="nav nav-tabs">
                <c:set var="pageHome" value="${kapp.getForm('home')}" scope="page"/>
                <li role="presentation" class="${pageHome.name eq form.name ? 'active' : ''}">
                    <a href="${bundle.kappLocation}"><i class="fa ${pageHome.getAttribute('Image Class').value}"></i> Home</a>
                </li>
                <c:set var="pageRequests" value="${kapp.getForm('my-requests')}" scope="page"/>
                <li role="presentation" class="${pageRequests.name eq form.name ? 'active' : ''}">
                    <a href="${bundle.kappLocation}/my-requests"><i class="fa ${pageRequests.getAttribute('Image Class').value}"></i> My Requests</a>
                </li>
            </ul>
        </section>

        <bundle:yield/>

    </div>

    <c:import url="${bundle.packagePath}/views/partials/shared/footer.jsp" charEncoding="UTF-8"/>

</bundle:layout>
