## Overview

The ObjectsHelper is utility that is used to check object for the existence of a property prior to use. 
This prevents new features that are implanted in a newer bundle release from breaking when deployed in older builds of core.

## Files

[bundle/ObjectsHelper.md](ObjectsHelper.md)  
README file containing information on configuring and using the object helper.

[bundle/ObjectsHelper.jspf](ObjectsHelper.jspf)  
Helper file containing definitions for the ObjectsHelper.  More information can be found in
the [ObjectHelper Summary] section.

## Configuration

* Copy the files listed above into your bundle
* Initialize the ObjectHelper in your bundle/initialization.jspf file
* Add <%@page import="java.lang.reflect.Method"%> to the initialization.jspf file

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

If a property on an object is being called in a bundle helper file and has the potential be break in an older version of core.
```jspf
String preferredLocale = null;
if (ObjectsHelper.hasMethod(identity.getUser(), "getPreferredLocale")) {
    preferredLocale = ObjectsHelper.callMethod(identity.getUser(), "getPreferredLocale");
}
```

If a property on an object is being called in a bundle jsp page and has the potential be break in an older version of core.
```jsp
<c:if test="${ObjectsHelper.hasMethod(identity.user, 'getPreferredLocale')}">
    <div>Preferred Locale: ${identity.user.preferredLocale}</div>
</c:if>
```
---

#### ObjectHelper 'Has' Method Summary
Identify the existence of a property in an Object.

`ObjectHelper()`  

`hasMethod(Class<?> objectClass, String methodName)`  - returns a boolean
`hasMethod(Object object, String methodName)`  - returns a boolean

---

#### ObjectHelper 'Get' Methods Summary
Retrieve the method from an Object.

`getMethod(Object object, String methodName)` - returns class Method
`getMethod(Class<?> objectClass, String methodName)`  - returns class Method

---
