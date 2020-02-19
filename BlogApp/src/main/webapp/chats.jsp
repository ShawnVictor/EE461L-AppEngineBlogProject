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
    		<td><a href='/index.jsp'>Subscribe</a></td>
    		<td><a href='/activity.jsp'>User Activity</a></td>
    		<td id="login"><a href='/login.jsp'>Account</a></td>
    	</tr>
    		
    </table>
  </body>
  

  <body>
  
 <%
 	String guestbookName = request.getParameter("guestbookName");
 	
 	if(guestbookName == null)
 	{
 		guestbookName = "default";
 	}
 	
    pageContext.setAttribute("guestbookName", guestbookName);

    UserService userService = UserServiceFactory.getUserService();

    User user = userService.getCurrentUser();

    if (user != null) {

      pageContext.setAttribute("user", user);
    }
 	
 	DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
 	
 	Key guestbookKey = KeyFactory.createKey("Guestbook", guestbookName);
 	
 	Query query = new Query("Greeting", guestbookKey).addSort("date", Query.SortDirection.DESCENDING);
 	
 	List<Entity> greetings = datastore.prepare(query).asList(FetchOptions.Builder.withDefaults());
 	
 	if(greetings.isEmpty())
 	{
 		%>
 		<p>There are no Blog Posts.</p>
 		<% 
 	}
 	else
 	{
 		for(Entity greeting: greetings)
 		{
 			if(greeting.getProperty("user") != null){
 				pageContext.setAttribute("greeting_content", greeting.getProperty("content"));
 				pageContext.setAttribute("greeting_date", greeting.getProperty("date"));
 				pageContext.setAttribute("greeting_title", greeting.getProperty("title"));
 				pageContext.setAttribute("greeting_user", greeting.getProperty("user"));
 			
 			%>
 			<h4> ${fn:escapeXml(greeting_title)} </h4>
 			<blockquote>${fn:escapeXml(greeting_content)}</blockquote>
 			<p id="name"><b>Post by: ${fn:escapeXml(greeting_user.nickname)}</b>  @ ${fn:escapeXml(greeting_date)}</p>
 				<hr>
 			<% 
 			}
 		}

 	}
 	
 %>

</body>
</html>