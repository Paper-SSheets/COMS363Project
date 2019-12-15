<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Login</title>
</head>
<body>
	<%@ include file='./DBInfo.jsp' %>
	<%
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		session.setAttribute("username", null);
		session.setAttribute("password", null);
		
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(DB_URL, DB_USERNAME, DB_PASSWORD);
			stmt = conn.createStatement();
		} catch(SQLException e) {
			out.println("A wild SQLException appeared!: " + e.getMessage());
		} finally {
			if (rs != null) {
				rs.close();
			}
			if (stmt != null) {
				stmt.close();
			}
			if (conn != null) {
				conn.close();
			}
		}
	%>
	<form action="Index.jsp">
		Username: <input type="text" name="username"><br>
		Password: <input type="password" name="password"><br>
		<input type="submit" value="GO">
	</form>

</body>
</html>