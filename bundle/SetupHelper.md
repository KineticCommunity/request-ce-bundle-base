## Overview

The CatalogSearchHelper is a utility that allows us to define which attributes are available or required for a KAPP. 
If required attributes are missing, it loads a setup page (if the user has admin privileges) which shows what is needed. 
The setup page can also be accessed directly to see what configuration attributes are available for the KAPP.

## Files

[bundle/SetupHelper.md](SetupHelper.md)  
README file containing information on configuring and using the setup helper.

[bundle/SetupHelper.jspf](SetupHelper.jspf)  
Helper file containing definitions for the SetupHelper.  More information can be found in
the [SetupHelper Summary](#setuphelper-summary) section.

[pages/setup.jsp](setup.jsp)  
Page that displays all available attributes used for configuring the KAPP. Also displays whether each attribute exists, doesn't exist, or its definition doesn't exist.

## Configuration

* Copy the files listed above into your bundle
* Initialize the SetupHelper in your bundle/initialization.jspf file
* Modify the router.jspf file to redirect when required attributes are missing

### Initialize the CatalogSeachHelper

The SetupHelper needs to be the first helper that is initialized in the `bundle/initialization.jspf` file, since all other helpers may use it. 
The below code should be added right before the first helper that's already initialized.

**bundle/initialization.jspf**
```jsp
<%-- SetupHelper --%>
<%@include file="SetupHelper.jspf"%>
<%
    SetupHelper setupHelper = new SetupHelper();
    request.setAttribute("SetupHelper", setupHelper);
    
    // Add attributes available for configuration
    setupHelper.addSetupAttribute("Page Link", 
            "Display name and file name (separated by a semicolon) of any pages "  
                + "that should show up as links. Ex: \"My Requests;requests\" [Allows Multiple]", 
            false)
        .addSetupAttribute("Icon", 
            "Font Awesome icon to represent this KAPP.", 
            false);
%>
```

### Modify the router.jspf file to redirect when required attributes are missing

In order to leverage all features of the SetupHelper in a bundle, some additional routing needs to be added to the
beginning of the `bundle/router.jsp` file.  The following code can be copied and pasted directly.

**bundle/router.jsp**
```jsp
<%-- INVALID SETUP ROUTING --%>
<%
    // If the request is scoped to a specific Kapp (space display pages are not)
    if (kapp != null) {
        // If there are any required setup attributes missing 
        if (setupHelper.isMissingRequiredAttributes(kapp)) {
            // Render the setup page (this will show the full setup page if the user is a space 
            // admin, or it will show a generic error message if they are not)
            request.getRequestDispatcher(bundle.getPath()+"/pages/setup.jsp").include(request, response);
            // Return so that no further JSP processing occurs
            return;
        }
        // If the user is not a space admin and are manually navigating to the setup page
        else if (!identity.isSpaceAdmin() && "setup".equals(request.getParameter("page"))) {
            // Simulate a 404 not found response
            response.setStatus(HttpServletResponse.SC_NOT_FOUND);
            request.getRequestDispatcher("/WEB-INF/pages/404.jsp").include(request, response);
            // Return so that no further JSP processing occurs
            return;
        }
    }
%>
```

## Example Usage

When adding other Helpers into initialization which use KAPP attributes, add those attributes to the SetupHelper 
in the block where the new Helper is being initialized, in order to keep all initialization for a single Helper in one block of code.

**Sample initialization of CatalogSearchHelper with attributes being added to SetupHelper**
```jsp
<%-- CatalogSearchHelper --%>
<%@include file="CatalogSearchHelper.jspf"%>
<%
    request.setAttribute("CatalogSearchHelper", new CatalogSearchHelper());
    //Add setup attributes
    setupHelper.addSetupAttribute("Search Attribute", 
            "Specify which form attributes should be searchable. " 
                + "Keyword attribute is always searchable and does not need to be specified as a Search Attribute. [Allows Multiple]", 
            false); 
%>
```

---

#### SetupHelper Summary
Collects a list of available attributes for the KAPP with helper function to retrieve them.

`SetupHelper()`  

`SetupHelper addSetupAttribute(String name, String description, boolean required)`  
`Map<SetupAttribute, AttributeStatus> getSetupAttributes(Kapp kapp)`  
`boolean isMissingRequiredAttributes(Kapp kapp)`  

---

#### SetupAttribute Summary
Custom model to store setup attributes, which consist of a name, description, and a boolean stating if they are required for the KAPP to function.

`SetupAttribute(String name, String description, boolean required)`

`String getName()`  
`String getDescription()`  
`boolean isRequired()`  

---

#### AttributeStatus Summary
Custom model to store the status (whether the definition exists, and whether a value exists) of a SetupAttribute object.

`AttributeStatus(boolean definition, boolean value)`  

`boolean hasDefinition()`  
`boolean hasValue()`  