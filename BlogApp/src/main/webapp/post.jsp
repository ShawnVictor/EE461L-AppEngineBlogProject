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
    		<td><a href='/index.jsp'> Home</a></td>
    		<td><a href='/post.jsp'>Post</a></td>
    		<td><a href='/subscribe.jsp'>Subscribe</a></td>
    		<td><a href='/activity.jsp'>User Activity</a></td>
    		<td id="login"><a href='/login.jsp'>Account</a></td>
    	</tr>
    </table>
  </body>

  <body>
  
	<%
	 String guestbookName = request.getParameter("guestbookName");
    if (guestbookName == null) {
        guestbookName = "default";
    }
    pageContext.setAttribute("guestbookName", guestbookName);
    %>
    
    <form action="/sign" method="post">

      <div><textarea name="title" rows="1" cols="30"></textarea></div>

      <div><textarea name="content" rows="3" cols="60"></textarea></div>

      <div><input type="submit" value="Submit Blog Post" /></div>
    
      <input type="hidden" name="guestbookName" value="${fn:escapeXml(guestbookName)}"/>

    </form>

</body>
</html>