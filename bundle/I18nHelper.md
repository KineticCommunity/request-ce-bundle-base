## Overview

The I18nHelper

## Files

[bundle/I18nHelper.md](I18nHelper.md)  
README file containing information on configuring and using the i18n helper.

[bundle/ObjectsHelper.jspf](I18nHelper.jspf)  
Helper file containing definitions for the I18nHelper.  More information can be found in
the [I18nHelper Summary](#i18nhelper-summary) section.

## Configuration

* Copy the files listed above into your bundle
* Initialize the I18nHelper and set the locale/zoneId in your bundle/initialization.jspf file

### Initialize the I18nHelper

**bundle/initialization.jspf**
```jsp
<%-- I18nHelper --%>
<%@include file="I18nHelper.jspf"%>
<%
    I18nHelper i18nHelper = new I18nHelper(request);
    request.setAttribute("i18n", i18nHelper);
    request.setAttribute("locale", i18nHelper.getLocale());
    request.setAttribute("zoneId", i18nHelper.getZoneId());
%>
```

## Example Usage


```java

```

```jsp

```

---

#### I18nHelper Summary
`new I18nHelper(HttpServletRequest request)`  
`new I18nHelper(HttpServletRequest request, Locale defaultLocale)`  
`getCode(Locale locale)`  
`getGlobalizedName(Locale locale)`  
`getLocale()`  
`getLocalizedName(Locale locale, Locale inLocale)`  
`getSystemLocales()`  
`getSystemLocales(Collection<Locale> preferredLocales)`  
`getSystemLocales(Enumeration<Locale> preferredLocales)`  
`getSystemLocales(Locale locale)`  
`getSystemLocales(Locale locale, Enumeration<Locale> preferredLocales)`  
`getSystemLocales(Locale locale, Collection<Locale> preferredLocales)`  
`getZoneId()`  
`scriptPath(Form form)`  
`scriptPath(String contextName)`  
`translate(String key)`  
`translate(String key, Map<String,String> substitutions)`  
`translate(Form form, String key)`  
`translate(Form form, String key, Map<String,String> substitutions)`  
`translate(String contextName, String key)`  
`translate(String contextName, String key, Map<String,String> substitutions)`  