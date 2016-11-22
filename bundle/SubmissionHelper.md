## Overview

The SubmissionHelper is a utility for retrieving a list of submissions.
There are several parameter option that can be provided.
These options will help in the retrieval of the specific submission desired.

## Files

[bundle/SubmissionHelper.md](SubmissionHelper.md)  
README file containing information on configuring and using the submission helper.

[bundle/SubmissionHelper.jspf](SubmissionHelper.jspf)  
Helper file containing definitions for the SubmissionHelper.  More information can be found in
the [SubmissionHelper Summary] section below.

## Configuration

* Copy the files listed above into your bundle
* Initialize the SubmissionHelper in your bundle/initialization.jspf file

### Initialize the SubmissionHelper

**bundle/initialization.jspf**
```jsp
<%-- SubmissionHelper --%>
<%@include file="SubmissionHelper.jspf"%>
<%
    request.setAttribute("SubmissionHelper", new SubmissionHelper(request));
%>
```

## Example Usage

**JSP Get a List of Submissions Server Side**
```jsp
<c:set scope="request" var="openSubmissionsList" value="${SubmissionHelper.retrieveRecentSubmissions('Approval', 'Draft', 1000)}"/>
```

---

#### SubmissionHelper Constructor Summary
| Signature                                                                                     | Description                                                                                                                   |
| :-------------------------------------------------------------------------------------------- | :---------------------------------------------------------------------------------------------------------------------------- |
| `SubmissionHelper()`                                                                          | Constructs a newly allocated SubmissionHelper object which can retrieve submissions.                                          |

---

#### SubmissionHelper Method Summary
| Signature                                                                                     | Description                                                                                                                   |
| :-------------------------------------------------------------------------------------------- | :---------------------------------------------------------------------------------------------------------------------------- |
| `List<Submission> retrieveRecentSubmissions(String type)`                                     | Overloaded method that returns a list of submissions of a given type within the last 30 days.                                 |
| `List<Submission> retrieveRecentSubmissions(String type, int number)`                         | Overloaded method that returns a specific sized list of submissions of a given type within the last 30 days.                  |                                   
| `List<Submission> retrieveRecentSubmissions(String type, String coreState)`                   | Overloaded method that returns a list of submissions of a given type and core state within the last 30 days.                  |
| `List<Submission> retrieveRecentSubmissions(String type, String coreState, Integer number)`   | Overloaded method that returns a specific sized list of submissions of a given type and core state within the last 30 days.   |
| `List<Submission> retrieveRecentSubmissions(String type, String coreState, Integer number)`   | Overloaded method that returns a specific sized list of submissions of a given type and core state within the last 30 days.   |
| `List<~> retrieveRecentSubmissionsByKapp(String searchKapp, String coreState, Integer number)`| Returns a specific sized list of Submissions for a given kapp and core state with in the last 30 days.                        |

---
#### Retrieve submissions by request Method Summary - explained with options
| `List<Submission> retrieveSubmissionsByRequest()`                                             | Returns a list of submission with the options being provided by the request. Used with Restful calls and Url query strings.   |
| "start" and "end" date range options                                                          | Must match standard date formats.  End data must not be before start date. Will default to 30 in not provided.                |
| "limit"                                                                                       | The number of submission to return                                                                                            |
| "type"                                                                                        | Specifies what type of submission to return.                                                                                  |
---

---
#### SubmissionHelper Utility Method Summery
| `List<Submission> retrieveSubmissionsByRequest()`                                             | Returns a list of submission with the options being provided by the request. Used with Restful calls and Url query strings.   |
| "start" and "end" date range options                                                          | Must match standard date formats.  End data must not be before start date. Will default to 30 in not provided.                |
| "limit"                                                                                       | The number of submission to return                                                                                            |
| "type"                                                                                        | Specifies what type of submission to return.                                                                                  |
---