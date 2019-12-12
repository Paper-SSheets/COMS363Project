<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<html>
<head>
<title> Query Ten </title>
</head>
<body>
<h1> Query Ten</h1>
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
	<!--  Here's the inputs -->	
	<form>
		Amount of tweets: <input type="number" year="category"><br>
		State (e.g. Ohio): <input type="text" year="category"><br>
		Month (Integer: 1 - 12): <input type="number" year="category"><br>
		Year: <input type="number" year="category"><br>
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
