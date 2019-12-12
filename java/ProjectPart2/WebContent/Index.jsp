<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<html>
<head>
<title> Project Part 2 </title>
</head>
<body>
	<%@ include file="./DBInfo.jsp"%>
	<%
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;

		// Java way for handling an error using try catch
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(DB_URL, DB_USERNAME, DB_PASSWORD);
			stmt = conn.createStatement();

			// show example how to use Statement object for static SQL statements
			
			// Put SQL query here
			String sqlQuery = "SELECT f.FID, f.FNAME FROM food f";

			rs = stmt.executeQuery(sqlQuery);
	%>
			<h1> Select the type of query you wish to perform: </h1>
			<ul>
				<li><a href="./queries/query_one.jsp"> 1.) List k most retweeted tweets in a given month and year. </a></li>
				<li> <a href="./queries/query_three.jsp"> 3.) Find k hashtags that appeared in the most number of states </a></li>
				<li> <a href="./queries/query_six.jsp"> 6.) Find k users who used at least one of the hashtags in a given list of hashtags.</a> </li>
				<li> <a href="./queries/query_nine.jsp"> 9.) Find top k most followed users in a given party.</a> </li>
				<li> <a href="./queries/query_ten.jsp"> 10.) Find the list of distinct hashtags that appeared in ANY state.</a></li>
				<li> <a href="./queries/query_eleven.jsp"> 11.) Find k tweets posted by GOP or democrat members in a given state at a given time.</a></li>
				<li> <a href="./queries/query_fifteen.jsp"> 15.) Find users in a given sub-category along.</a></li>
				<li> <a href="./queries/query_eighteen.jsp"> 18.) Find k users who were mentioned the most in tweets in a given party, month, year.</a></li>
				<li> <a href="./queries/query_twenty_three.jsp"> 23.) Find k most used hashtags.</a></li>
			</ul>

			<a href="">  </a>
			<!-- the form method can be get or post
				but post does not let anyone see the parameter values that are passed between pages
				Use post for sensitive information
			-->
			<form method="post" action="ShowResult.jsp">
			<select name="food_selector">
	<%
				while (rs.next()) {
						out.println("<option value="+ rs.getInt("FID") + ">" + rs.getString("FNAME") + "</option>");
				}
	%>
			</select>
			<p></p>
			<input type="submit" value="GO">
			</form>
	<%
			
		} catch (SQLException e) {
			out.println("An exception occurred: " + e.getMessage());
		} finally {
			if (rs!= null) rs.close();
			if (stmt!= null) stmt.close();
			if (conn != null) conn.close();
		}
	%>
</body>
</html>