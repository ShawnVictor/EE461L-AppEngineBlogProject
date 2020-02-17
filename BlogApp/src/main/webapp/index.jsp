<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="java.util.List" %>

<%@ page import="com.google.appengine.api.users.User" %>

<%@ page import="com.google.appengine.api.users.UserService" %>

<%@ page import="com.google.appengine.api.users.UserServiceFactory" %>

<%@ page import="com.google.appengine.api.datastore.DatastoreServiceFactory" %>

<%@ page import="com.google.appengine.api.datastore.DatastoreService" %>

<%@ page import="com.google.appengine.api.datastore.Query" %>

<%@ page import="com.google.appengine.api.datastore.Entity" %>

<%@ page import="com.google.appengine.api.datastore.FetchOptions" %>

<%@ page import="com.google.appengine.api.datastore.Key" %>

<%@ page import="com.google.appengine.api.datastore.KeyFactory" %>

<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

 

<html xmlns="http://www.w3.org/1999/xhtml" lang="en">

  <head>
    <meta http-equiv="content-type" content="application/xhtml+xml; charset=UTF-8" />
    <title>UTBelong</title>
    <link type="text/css" rel="stylesheet" href="/stylesheets/Landing.css" />
    
  </head>

  <body>
    <table bgcolor="white">
    	<tr>
    		<td><h1>UT</h1></td>
    		<td><h2>Be</h2></td>
    		<td><img src = "BApic.jpg" width = "10" height = "50"></td>
    		<td><h2>ong</h2></td>
    		<td width="100%"></td>
    	</tr>
    </table>
    <hr>
    <table id="table2" align="right";>
    	<tr>
    		<td id="login"><a href='/login.jsp'>Sign in</a></td>
    		<td><a href='/post.jsp'>Post</a></td>
    		<td><a href='/activity.jsp'>User Activity</a></td>
    		<td><a href='/subscribe.jsp'>Subscribe</a></td>
    		<td><a href='/chats.jsp'>View More</a></td>
    	</tr>
    </table>

  </body>

  <body>

 

<%
	boolean signedIn = false;
    String guestbookName = request.getParameter("guestbookName");

    if (guestbookName == null) {

        guestbookName = "default";

    }

    pageContext.setAttribute("guestbookName", guestbookName);

    UserService userService = UserServiceFactory.getUserService();

    User user = userService.getCurrentUser();

    if (user != null) {

      pageContext.setAttribute("user", user);

%>

<p>Hello, ${fn:escapeXml(user.nickname)}! (You can

<a href="<%= userService.createLogoutURL(request.getRequestURI()) %>">sign out</a>.)</p>


<%
	signedIn = false;
    } else {
    signedIn = true;
%>
	

<%

    }

%>

 

<%

    DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();

    Key guestbookKey = KeyFactory.createKey("Guestbook", guestbookName);

    // Run an ancestor query to ensure we see the most up-to-date

    // view of the Greetings belonging to the selected Guestbook.

    Query query = new Query("Greeting", guestbookKey).addSort("date", Query.SortDirection.DESCENDING);

    List<Entity> greetings = datastore.prepare(query).asList(FetchOptions.Builder.withLimit(5));

    if (greetings.isEmpty()) {

        %>

        <p>Blog Page '${fn:escapeXml(guestbookName)}' is empty.</p>

        <%

    } else {

        %>

        <p>Latest Blog Posts '${fn:escapeXml(guestbookName)}'.</p>

        <%

        for (Entity greeting : greetings) {

            pageContext.setAttribute("greeting_content",

                                     greeting.getProperty("content"));

            if (greeting.getProperty("user") == null) {

                %>

                <p>An anonymous person wrote:</p>

                <%

            } else {

                pageContext.setAttribute("greeting_user",

                                         greeting.getProperty("user"));

                %>

                <p><b>${fn:escapeXml(greeting_user.nickname)}</b> wrote:</p>

                <%

            }

            %>

            <blockquote>${fn:escapeXml(greeting_content)}</blockquote>

            <%

        }

    }

%>

 

    <form action="/sign" method="post">

      <div><textarea name="content" rows="3" cols="60"></textarea></div>

      <div><input type="submit" value="Submit Blog Post" /></div>

      <input type="hidden" name="guestbookName" value="${fn:escapeXml(guestbookName)}"/>

    </form>

 

  </body>
  <script>
	   if(signedIn)
	   {
	    	document.getElementById("login").style.visibility = "hidden";
	   }
   </script>
</html>

