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

        <bundle:yield/>

    </div>

    <c:import url="${bundle.packagePath}/views/partials/shared/footer.jsp" charEncoding="UTF-8"/>

</bundle:layout>
