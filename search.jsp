<%@page pageEncoding="UTF-8" contentType="text/html" trimDirectiveWhitespaces="true"%>
<%@include file="bundle/initialization.jspf" %>
<bundle:layout page="layouts/layout.jsp">

    <bundle:variable name="head">
        <title>${text.escape(space.name)} Search</title>
    </bundle:variable>


	<div class="container search-container">
		<h2>Search Results</h2>
		<form action="${bundle.kappLocation}/search" method="GET" role="form"> 
	      <div class="form-group has-feedback">
	        <input type="text" class="states form-control x" name="q" value="${param['q']}"/>
	      </div>
	    </form>
		<div class="search-results">
		    <c:if test="${text.isNotBlank(param['q'])}">
		    	<ul>
                    <c:set var="found" value="false" />
		    		<c:forEach items="${kapp.forms}" var="form">
		    			<c:if test="${text.equals(form.type.name, 'Service') || text.equals(form.type.name, 'Template')}">
			    			<c:if test="${text.contains(text.downcase(form.name), text.downcase(param['q'])) || text.contains(text.downcase(form.description), text.downcase(param['q']))}">
                                <c:set var="found" value="true"/>
			    				<li>
			    					<h3>
			    					    <a href="${bundle.kappLocation}/${form.slug}">
		    							   ${form.name}
			    						</a>
			    					</h3>
    	    						<p>${form.description}</p>
			    				</li>
			    			</c:if>
		    			</c:if>
		    		</c:forEach>
                    <c:if test="${found == "false"}">
                        <h3>No results found for ${param['q']}.</h3>
                    </c:if>
		    	</ul>
		    </c:if>
		</div>
    </div>
</bundle:layout>


<script>
	$('button').on('click', function(e){});
</script>