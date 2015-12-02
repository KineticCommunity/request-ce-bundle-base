## Overview
This bundle is used internally by Kinetic Request CE and is a good starting point to build out your own bundles.

It includes the default:

* Listing of Kapps (kapp.jsp)
* Form display (form.jsp)
* Login page (login.jsp)
* Reset Password (resetPassword.jsp)


## Customizing
This bundle easily allows for minor personalization by including optional attributes in your KAPP or Form.

KAPP Attributes:
* _logo-url_ : By including this attribute we will use this logo instead of the home icon on the top-left of the page
* _logo-height-px_ : By including this attribute we will set the height of the logo in the header. Default is 40px with 5px of padding.

Form Attributes
* _form-icon-class_ : We include font-awesome icons by default and just apply a random icon to your forms on the catalog page.  However, you can specify a class for your form by including this attribute and a value. (Example fa-bank)

When you customize this bundle it is a good idea to fork it on your own git server to track your customizations and merge in any code changes we make to the default.

We also suggest you update this README with your own change summary for future bundle developers.

## Structure
