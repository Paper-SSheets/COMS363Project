<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<html>
<head>
<title>Query Fifteen</title>
</head>
<body>
	<h1>Query 15</h1>
	<%@ include file="../DBInfo.jsp"%>
	<%
		Connection conn = null;
		PreparedStatement stmt = null;
		PreparedStatement categoryStmt = null;
		PreparedStatement monthStmt = null;
		PreparedStatement yearStmt = null;
		ResultSet rs = null;

		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(DB_URL, DB_USERNAME, DB_PASSWORD);

			// List k most retweeted tweets in a given month and a given year; show
			//recent retweet count, the tweet text, the posting user's screen name,
			//the posting user's category, the posting user's sub-category in a
			// descending order of the retweet count values

			//rs = stmt.executeQuery(sqlQuery);
	%>
	<!--  Here's the inputs -->

	<%
			String month = (String) request.getParameter("month");
			String year = (String) request.getParameter("year");
			String category = (String) request.getParameter("sc");


			String setCategory = "SET @subcategory = '" + category + "';"; 
			String setMonth = "SET @month = '" + month + "';";
			String setYear = "SET @year = '" + year + "';";

			String fifteenQuery = "SELECT u.screen_name, u.state_name, Group_concat(url.address SEPARATOR ', ') AS URLs FROM   user u INNER JOIN tweet t ON t.uscreen_name = u.screen_name INNER JOIN url_used ON url_used.tid = t.tid INNER JOIN url ON url.address = url_used.url WHERE  u.sub_category = @subcategory AND Year(Str_to_date(created_at, '%Y-%m-%d %H:%i:%s')) = @year AND Month(Str_to_date(created_at, '%Y-%m-%d %H:%i:%s')) = @month GROUP  BY u.screen_name LIMIT  100;";
			
			System.out.println(month + year + category); 
			
			// Prepared statements preparation
			stmt = conn.prepareStatement(fifteenQuery);
			categoryStmt = conn.prepareStatement(setCategory);
			monthStmt = conn.prepareStatement(setMonth);
			yearStmt = conn.prepareStatement(setYear);

			System.out.println(stmt);
			System.out.println(categoryStmt);
			System.out.println(monthStmt);
			System.out.println(yearStmt);


			rs = categoryStmt.executeQuery();

			rs = monthStmt.executeQuery();

			rs = yearStmt.executeQuery();

			rs = stmt.executeQuery();

			System.out.println("execute query: " + rs);

		    System.out.println("Should be executing after this");
		    
			while (rs.next()) {
				System.out.println("these are the results");
				out.println("<b>Screen name:</b>" + rs.getString("screen_name") + "<br>");
				out.println("<b>State Name:</b>" + rs.getString("state_name") + "<br>");
				out.println("<b>URLs:</b>" + rs.getString("URLS") + "<br>");
				out.println("<hr>");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	%>
</body>
</html>
