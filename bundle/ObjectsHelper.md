## Overview

The ObjectsHelper is utility that is used to check for the existence of a property or method prior 
to use.  This allows the bundles developed to utilize new features to check whether those features 
are present and maintain compatibility with older releases of Request CE.

## Files

[bundle/ObjectsHelper.md](ObjectsHelper.md)  
README file containing information on configuring and using the object helper.

[bundle/ObjectsHelper.jspf](ObjectsHelper.jspf)  
Helper file containing definitions for the ObjectsHelper.  More information can be found in
the [ObjectHelper Summary](#objecthelper-summary) section.

## Configuration

* Copy the files listed above into your bundle
* Initialize the ObjectHelper in your bundle/initialization.jspf file

### Initialize the ObjectHelper

**bundle/initialization.jspf**
```jsp
<%-- ObjectsHelper --%>
<%@include file="ObjectsHelper.jspf"%>
<%
    request.setAttribute("ObjectsHelper", new ObjectsHelper());
%>
```

## Example Usage

If a property on an object is being called in a bundle helper file and has the potential be break in
an older version of core.
```java
String preferredLocale = null;
if (ObjectsHelper.hasMethod(identity.getUser(), "getPreferredLocale")) {
    preferredLocale = ObjectsHelper.callMethod(identity.getUser(), "getPreferredLocale");
}
```

If a property on an object is being called in a bundle jsp page and has the potential be break in an
older version of core.
```jsp
<c:if test="${ObjectsHelper.hasMethod(identity.user, 'getPreferredLocale')}">
    <div>Preferred Locale: ${identity.user.preferredLocale}</div>
</c:if>
```

---

#### ObjectHelper Summary
`new ObjectHelper()`  
`callMethod(Class<?> objectClass, String methodName)`  
`callMethod(Class<?> objectClass, String methodName, Object... parameters)`  
`callMethod(Object object, String methodName)`  
`callMethod(Object object, String methodName, Object... parameters)`  
`getMethod(Class<?> objectClass, String methodName)`  
`getMethod(Object object, String methodName)`  
`hasMethod(Class<?> objectClass, String methodName)`  
`hasMethod(Object object, String methodName)`  
