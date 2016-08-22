## Overview

The I18nHelper
=======
The I18nHelper (short for internationalization helper) contains methods necessary to build lists
of available locales, determine the preferred locale of the requester, and apply translations based 
upon the preferred locale.

## Files

[bundle/I18nHelper.md](I18nHelper.md)  
README file containing information on configuring and using the i18n helper.

[bundle/ObjectsHelper.jspf](I18nHelper.jspf)  
Helper file containing definitions for the I18nHelper.  More information can be found in the 
[I18nHelper Summary](#i18nhelper-summary) section.

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

Apply translation:
```jsp
<title>${text.escape(i18n.translate(kapp.name))}</title>
```

Apply translation with substitutions:
```jsp
<div class="alert">
    ${text.escape(i18n.translate('Good morning NAME.').replace('NAME', identity.user.displayName))}
</div>
```

Apply translation in javascript:
```jsx
K.translate('bundle','Failed to save changes.')
```

Include client side (JavaScript) translations so they are available for the `K.translate` JavaScript
function:
```jsp
<script src="${i18n.scriptPath('shared')}"></script>
<script src="${i18n.scriptPath('bundle')}"></script>
<script src="${i18n.scriptPath('custom.context')}"></script>
```

Build list of available locales in their native translations with the browser preferred locales 
sorted to the top):
```jsp
<select>
    <c:forEach var="optionLocale" items="${i18n.getSystemLocales(pageContext.request.locales)}">
        <option value="${i18n.getLocaleCode(optionLocale)}">
            ${text.escape(i18n.getLocaleNameGlobalized(optionLocale))}
        </option>
    </c:forEach>
</select>
```

#### I18nHelper Summary
`new I18nHelper(HttpServletRequest request)`  
`new I18nHelper(HttpServletRequest request, Locale defaultLocale)`  
`getLocale()`  
`getLocaleCode(Locale locale)`  
`getLocaleNameGlobalized(Locale locale)`  
`getLocaleNameLocalized(Locale locale, Locale inLocale)`  
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
