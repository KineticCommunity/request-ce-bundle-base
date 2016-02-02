<%@page pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@page import="com.kineticdata.core.web.bundles.Bundle" %>
<%
    //Get bundle, space, and kapp objects
    Bundle bundle = (Bundle)request.getAttribute("bundle"); 
%>
<% 
    if (request.getParameter("page") != null && !"".equals(request.getParameter("page"))) {
        String bundlePath = bundle.getPath()+"/pages/";
        String partialPath = request.getParameter("page");
        String path = new java.net.URI(bundlePath+partialPath+".jsp").normalize().toString();
        if (!path.startsWith(bundlePath)) {
            request.setAttribute("javax.servlet.error.message", partialPath);
            response.setStatus(response.SC_NOT_FOUND); 
%><jsp:include page="/WEB-INF/pages/404.jsp" /><%
            return;
        }
%><jsp:include page="<%=path%>" /><% 
        return;
    }
    else if (request.getParameter("partial") != null && !"".equals(request.getParameter("partial"))) {
        String bundlePath = bundle.getPath()+"/partials/";
        String partialPath = request.getParameter("partial");
        String path = new java.net.URI(bundlePath+partialPath+".jsp").normalize().toString();
        if (!path.startsWith(bundlePath)) {
            request.setAttribute("javax.servlet.error.message", partialPath);
            response.setStatus(response.SC_NOT_FOUND); 
%><jsp:include page="/WEB-INF/pages/404.jsp" /><%
            return;
        }
%><jsp:include page="<%=path%>" /><% 
        return;
    }
    else {
      String bundlePath = bundle.getPath()+"/index.jsp";
%><jsp:include page="<%=bundlePath%>" /><% 
    } 
%>