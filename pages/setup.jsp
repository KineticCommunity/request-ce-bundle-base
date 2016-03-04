<%@page pageEncoding="UTF-8" contentType="text/html" trimDirectiveWhitespaces="true"%>
<%@include file="../bundle/initialization.jspf" %>

<bundle:layout page="${bundle.path}/layouts/layout.jsp">
    <div class="no-data">
        <h2>
            Kapp Setup
        </h2>
        <table class="table table-hover">
            <thead>
                <tr>
                    <th width="15%">Status</th>
                    <th width="10%">Required?</th>
                    <th>Name</th>
                    <th>Description</th>

                </tr>
            </thead>
            <tbody>
                <c:forEach items="${SetupHelper.getSetupAttributes(kapp)}" var="setupAttributeEntry">
                    <tr class="${setupAttributeEntry.value.hasValue() ? "success" : setupAttributeEntry.key.isRequired() ? "danger" : "warning"}">
                        <td>
                            <span class="fa ${setupAttributeEntry.value.hasValue() ? "fa-check" : "fa-exclamation-triangle"}"></span>
                            <c:choose>
                                <c:when test="${setupAttributeEntry.value.hasValue()}">
                                    Found
                                </c:when>
                                <c:when test="${setupAttributeEntry.value.hasDefinition()}">
                                    <a href="${bundle.spaceLocation}/app/#/${kapp.slug}/setup/kapp/attributes">Missing Value</a>
                                </c:when>
                                <c:otherwise>
                                   <a href="${bundle.spaceLocation}/app/#/${kapp.slug}/setup/attributeDefinitions/Kapp/new"> Missing Definition</a>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td class="${setupAttributeEntry.key.isRequired() ? "required" : "optional"}">
                            ${setupAttributeEntry.key.isRequired() ? "Required" : "Optional"}
                        </td>
                        <td>${setupAttributeEntry.key.getName()}</td>
                        <td>${setupAttributeEntry.key.getDescription()}</td>


                    </tr>
                </c:forEach>
            </tbody>
        </table>

        <p class="text-muted">To update your attribute values visit the <a href="${bundle.spaceLocation}/app/#/${kapp.slug}/setup/kapp/attributes">
        Kapp Attribute settings</a>.</p>
        <p class="text-muted">To define your attributes visit the <a href="${bundle.spaceLocation}/app/#/${kapp.slug}/setup/attributeDefinitions/Kapp/new">
        Attribute Definitions settings</a>.</p>
    </div>
</bundle:layout>