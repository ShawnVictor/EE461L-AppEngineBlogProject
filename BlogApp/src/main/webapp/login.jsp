<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="java.util.List" %>

<%@ page import="com.google.appengine.api.users.User" %>

<%@ page import="com.google.appengine.api.users.UserService" %>

<%@ page import="com.google.appengine.api.users.UserServiceFactory" %>

<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

 

<html>

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
    		<td><a href='/login.jsp'>Sign in</a></td>
    		<td><a href='/post.jsp'>Post</a></td>
    		<td><a href='/activity.jsp'>User Activity</a></td>
    		<td><a href='/subscribe.jsp'>Subscribe</a></td>
    		<td><a href='/chats.jsp'>View More</a></td>
    	</tr>
    </table>
    
  </body>

  <body>

 

<%

    UserService userService = UserServiceFactory.getUserService();

    User user = userService.getCurrentUser();

    if (user != null) {

      pageContext.setAttribute("user", user);

%>

<p>Hello, ${fn:escapeXml(user.nickname)}! (You can

<a href="http://localhost:8082">Go back to Landing Page</a>.)</p>

<%

    } else {

%>

<p>Hello!

<a href="<%= userService.createLoginURL(request.getRequestURI()) %>">Sign in</a>

to include your name with greetings you post.</p>

<%

    }

%>

 

  </body>

</html>