<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<html>
<head>
<title> Query One </title>
</head>
<body>
<h1> Query Three</h1>
	<%@ include file="../DBInfo.jsp" %>
	<%
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
				
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(DB_URL, DB_USERNAME, DB_PASSWORD);
			stmt = conn.createStatement();
		 	//rs = stmt.executeQuery(sqlQuery);
	%>
	<!--  Find k hashtags 
	that appeared in the most number of states in a given year; 
	list the total number of states the hashtag appeared, 
	the list of the distinct states it appeared (FL is the same as Florida*), 
	and the hashtag itself in descending order 
	of the number of states the hashtag appeared. -->

	<!--  Here's the inputs -->	
	<h3> Choose a year: </h3>
	<form>
		Year: <input type="number" year="fyear"><br>
		Amount of tweets (integer 1-100): <input type="number" year="num_tweets"><br>
		<input type="submit" value="Submit">
		<input type="submit" value="Back" action="../Index.jsp">
	</form>
	<% 
		} catch(SQLException e) {
			e.printStackTrace();
			System.out.println("Something");
		}
	%>
</body>
</html>
