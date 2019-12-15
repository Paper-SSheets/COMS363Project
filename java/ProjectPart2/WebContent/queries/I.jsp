<!-- Authors: Andrew Marek, Steven Sheets, Dylan Smith -->

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert</title>
</head>
<body>
	<%@ include file="../DBInfo.jsp"%>
	<%
		// Set up.
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;

		Class.forName("com.mysql.jdbc.Driver");
		
		System.out.println("Session username " + session.getAttribute("username"));
		System.out.println("Session password " + session.getAttribute( "password"));
		System.out.println("Session privilege " + session.getAttribute("is_admin"));

		// Set attributes for the user if everything went well. 	
		if (session.getAttribute("username") == null && session.getAttribute("password") == null) {
			System.out.println("We had to set the attributes manually");

			session.setAttribute("username", request.getParameter("username"));
			session.setAttribute("password", request.getParameter("password"));
		}

		
		try {
			// Check for admin priveledges.
			if (session.getAttribute("is_admin").equals("all")) {
				conn = DriverManager.getConnection(DB_URL, DB_USERNAME, DB_PASSWORD);
				
				//SQL Query to insert user.
				String insertQuery = "INSERT INTO user VALUES (?, ?, ?, ?, ?, ?, ?);";
				
				stmt = conn.prepareStatement(insertQuery);

				stmt.setString(1, request.getParameter("screen_name").equals("") == false ? request.getParameter("screen_name") : null);
				stmt.setString(2, request.getParameter("name").equals("") == false ? request.getParameter("name") : null);
				stmt.setString(3, request.getParameter("category").equals("") == false ? request.getParameter("category") : null);
				stmt.setString(4, request.getParameter("sub_category").equals("") == false ? request.getParameter("sub_category") : null);
				stmt.setString(5, request.getParameter("state_name").equals("") == false ? request.getParameter("state_name") : null);
				stmt.setString(6, request.getParameter("num_followers").equals("") == false ? request.getParameter("num_followers") : null);
				stmt.setString(7, request.getParameter("num_following").equals("") == false ? request.getParameter("num_following") : null);
				
				int rowsInserted = stmt.executeUpdate();
				
				if (rowsInserted > 0) {
					out.println("A new user was inserted with the following values");
				}
				
				String searchQuery = "SELECT * from user where screen_name = ?";
				stmt = conn.prepareStatement(searchQuery);
				stmt.setString(1, request.getParameter("screen_name"));
				
				rs = stmt.executeQuery();

				while(rs.next()) {
					out.println("Username: " + rs.getString("screen_name"));
					out.println("Name: " + rs.getString("dname"));
					out.println("Category: " + rs.getString("category"));
					out.println("Sub category: " + rs.getString("sub_category"));
					out.println("State name: " + rs.getString("state_name"));
					out.println("Number of followers: " + rs.getString("num_followers"));
					out.println("Number following: " + rs.getString("num_following"));
				}
			}
			
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
			out.println("Error: You do not have permission to access this page.");
			out.println("Permissions: " + session.getAttribute("is_admin"));
		}
	%>

	<!-- Back button -->
	<form action="../Index.jsp"> 
		<input type="submit" value="BACK" />
	</form>
</body>
</html>