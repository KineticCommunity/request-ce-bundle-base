## Overview
This bundle is used internally by Kinetic Request CE and is a good starting point to build out your own bundles.

It includes the default:

* Listing of Kapps (kapp.jsp)
* Form display (form.jsp)
* Login page (login.jsp)
* Reset Password (resetPassword.jsp)

## Assumptions
Wherever possible we use defaults to make sure the pages will render correctly regardless of any attributes, categories or other configurations you perform on your forms.

The one exception to this is "My Requests" and "My Approvals".  In order to grab only the appropriate submissions we are looking for form types of _"Service"_ for My Requests and _"Approval"_ for My Approvals.

## Personalization
This bundle easily allows for minor personalization by including optional attributes in your KAPP, Form and/or Categories.

### KAPP Attributes:
* _logo-url_ : By including this attribute we will use this logo instead of the home icon on the top-left of the page
* _logo-height-px_ : By including this attribute we will set the height of the logo in the header. Default is 40px with 5px of padding.
* _sidebar-html_ : We show the Kinetic Data Twitter feed by default, but you can add any HTML/widget by including the HTML/JS in this attribute.
* _primary-rgb_ : Setting this RGB color (example: 232,130,67 for an orange) will set the primary color on the console and forms.  Including some navigation indicators, icon colors and others. If this is not set, but a logo has been added, we try to get the primary color from the logo.  If nothing is set our default blue is used.
* _secondary-rgb_ : A secondary color used in the console and forms. Should be in the format of three RGB numbers (example: 232,130,67 for an orange)
* _tertiary-rgb_ : A tertiary color used in the console and forms. Should be in the format of three RGB numbers (example: 232,130,67 for an orange)

### Form Attributes
* _form-icon-class_ : We include font-awesome icons by default and just apply a random icon to your forms on the catalog page.  However, you can specify a class for your form by including this attribute and a value. (Example fa-bank)

### Category Attributes
* _hidden_ : Including this attribute on a category means the category and forms in that category will not be shown on the portal page.


## Customization
When you customize this bundle it is a good idea to fork it on your own git server to track your customizations and merge in any code changes we make to the default.

We also suggest you update this README with your own change summary for future bundle developers.

### Structure
This default bundle uses our standard directory structure.  Bundles are completely self contained so should include all libraries and markup needed.

<code><pre>
/*bundle-name*
  /*bundle*: Initialization scripts and helpers
  /*css*: Cascading style sheets. If you use Sass, output compiled css here.
  /*images*: Duh.
  /*js*: All javascript goes here.
  /*layouts*: One or more layouts wraps your views and generally includes your HTML head elements and any content that should show up on all pages.
  /*libraries*: Include CSS, JS or other libraries here including things like JQuery or bootstrap.
  /*partials*: These are view snippets that get used in the top-layer JSP views. Feel free to include sub-directories here if your set of partials gets unwieldy.
  /*confirmation.jsp*: The default confirmation page on form submits.
  /*form.jsp*: The default form JSP wrapper.
  /*kapp.jsp*: This is the catalog console page or self service portal page.  This typically lists the forms by category, my requests, my approvals and more.
  /*login.jsp*: The default login page. Can be overridden in your Space Admin Console.
  /*resetPassword.jsp*: The default reset password page. This will trigger the system to send an email to the user to reset their password. Note that the SMTP server needs to be configured to work.
  /*space.jsp*: A page that displays a list of KAPPs (often request catalogs) that you have access to within your space.
</pre></code>
