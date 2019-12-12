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
	<form action="query_ten.jsp">
		List of states (comma separated) <input type="text" name="states"><br>
		Month (Integer: 1 - 12) <input type="integer" name="month"><br>
		Year <input type="integer" name="year"><br>
		<input type="submit" value="Submit">
		<input type="submit" value="Back" action="../Index.jsp">
	</form>

	<% 
		String listStates = request.getParameter("states");
		String month = request.getParameter("month");
		String year = request.getParameter("year");

		String sqlQuery = "";
		stmt.conn.prepareStatement(sqlQuery);
		
		stmt.setString(1, listStates);
		stmt.setString(2, month);
		stmt.setString(2, year);

		} catch(SQLException e) {
			e.printStackTrace();
			System.out.println("Something");
		}
	%>
</body>
</html>
