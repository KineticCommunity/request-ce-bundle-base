<%@page pageEncoding="UTF-8" contentType="text/html" trimDirectiveWhitespaces="true"%>
<%@include file="../bundle/initialization.jspf" %>

<bundle:layout page="${bundle.path}/layouts/layout.jsp">
    <div class="no-data">
        <h3>
            Kapp Configuration<br>
            <c:if test="${SetupHelper.isMissingRequiredAttributes(kapp)}">
                <small>Required attributes are missing.</small>
            </c:if>
        </h3>
        <ul>
            <c:forEach items="${SetupHelper.getSetupAttributes(kapp)}" var="setupAttributeEntry">
                <li>
                    <h4>
                        <span class="badge fa ${setupAttributeEntry.value ? "fa-check" : "fa-times"}"><br></span>
                        ${setupAttributeEntry.key.getName()} 
                        <small class="${setupAttributeEntry.key.isRequired() ? "required" : ""}">
                            ${setupAttributeEntry.key.isRequired() ? "Required" : "Optional"}
                        </small>
                    </h4>
                    <p>${setupAttributeEntry.key.getDescription()}</p>
                </li>
            </c:forEach>
        </ul>
        <p>To update your configuration go to the <a href="${bundle.spaceLocation}/app/#/${kapp.slug}/setup/kapp/attributes">
        Kapp Attribute settings</a>.</p>
    </div>
</bundle:layout>