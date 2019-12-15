<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%
// @author: Andrew Marek, Steven Sheets, Dylan Smith
%>

<!DOCTYPE html>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Delete</title>
</head>
<body>
	<%@ include file="../DBInfo.jsp"%>
	<%
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;

		Class.forName("com.mysql.jdbc.Driver");
		
		// Set attributes for the user if everything went well. 	
		if (session.getAttribute("username") == null && session.getAttribute("password") == null) {
			session.setAttribute("username", request.getParameter("username"));
			session.setAttribute("password", request.getParameter("password"));
		}
		
		try {

			// Check for admin priveledges.
			if (session.getAttribute("is_admin").equals("all")) {
				conn = DriverManager.getConnection(DB_URL, DB_USERNAME, DB_PASSWORD);
			}
			
			String deleteQuery = "SELECT screen_name FROM user WHERE screen_name = ?;";
			stmt = conn.prepareStatement(deleteQuery);

			// Set the values of the preceding statement
			stmt.setString(1, request.getParameter("screen_name"));
			rs = stmt.executeQuery();
			rs.next();
			out.println("Deleting user" + rs.getString("screen_name"));

			// Release the kraken!

			// User	
			deleteQuery = "DELETE FROM User WHERE screen_name = ?;";
			stmt = conn.prepareStatement(deleteQuery);
			stmt.setString(1, request.getParameter("screen_name"));

			int rowsDeleted = stmt.executeUpdate();

			// Tweet
			deleteQuery = "DELETE FROM Tweet WHERE uscreen_name = ?;";
			stmt = conn.prepareStatement(deleteQuery);
			stmt.setString(1, request.getParameter("screen_name"));

			rowsDeleted = stmt.executeUpdate();
			
			// Mentioned	
			deleteQuery = "DELETE FROM mentioned WHERE uscreen_name = ?;";
			stmt = conn.prepareStatement(deleteQuery);
			stmt.setString(1, request.getParameter("screen_name"));

			rowsDeleted = stmt.executeUpdate();

			// Hashtagged 
			deleteQuery = "DELETE FROM tagged WHERE tid IN (SELECT tid FROM Tweet WHERE uscreen_name = ?;";
			stmt = conn.prepareStatement(deleteQuery);
			stmt.setString(1, request.getParameter("screen_name"));

			rowsDeleted = stmt.executeUpdate();

			conn.close();
		} catch (Exception e) {
			out.println("Error: You do not have permissions to access this page.");
		}
	%>

	<!-- Return to the other page -->
	<form action="./Index.jsp"> 
		<input type="submit" value="BACK" />
	</form>
</body>
</html>