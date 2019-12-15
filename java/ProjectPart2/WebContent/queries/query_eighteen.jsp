<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<html>
<head>
<title>Query 18</title>
</head>
<body>
	<h1>Query 18</h1>
	<%@ include file="../DBInfo.jsp"%>
	<%
		Connection conn = null;
		PreparedStatement stmt1 = null;
		PreparedStatement stmt2 = null;
		PreparedStatement stmt3 = null;
		PreparedStatement stmt4 = null;

		ResultSet rs = null;

		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(DB_URL, DB_USERNAME, DB_PASSWORD);

			String k = (String) request.getParameter("amount");
			String sub_category = (String) request.getParameter("subcategory");
			String month = (String) request.getParameter("month");
			String year = (String) request.getParameter("year");

			System.out.println(k + "---" + sub_category + "---" + year + "---" + month);
			String sqlQuery1 = "SET @subcategory = '" + sub_category + "';";
			String sqlQuery2 = "SET @month = '" + month + "';";
			String sqlQuery3 = "SET @year = '" + year + "';";
			String sqlQuery4 = "SELECT mentU.screen_name                                    AS mentionedUser, mentU.state_name                                     AS mentionedUserState, Group_concat(DISTINCT t.uscreen_name SEPARATOR ', ') AS postingUsers FROM   tweet t INNER JOIN mentioned AS ment ON ment.tid = t.tid INNER JOIN user AS ownU ON ownU.screen_name = t.uscreen_name INNER JOIN user AS mentU ON mentU.screen_name = ment.uscreen_name WHERE  ownU.sub_category = @subcategory AND Year(Str_to_date(t.created_at, '%Y-%m-%d %H:%i:%s')) = @year AND Month(Str_to_date(t.created_at, '%Y-%m-%d %H:%i:%s')) = @month GROUP  BY mentU.screen_name ORDER  BY Count(ment.uscreen_name) DESC LIMIT  "
					+ k + ";";

			stmt1 = conn.prepareStatement(sqlQuery1);
			stmt2 = conn.prepareStatement(sqlQuery2);
			stmt3 = conn.prepareStatement(sqlQuery3);
			stmt4 = conn.prepareStatement(sqlQuery4);

			System.out.println(stmt1);
			System.out.println(stmt2);
			System.out.println(stmt3);
			System.out.println(stmt4);

			rs = stmt1.executeQuery();
			rs = stmt2.executeQuery();
			rs = stmt3.executeQuery();
			rs = stmt4.executeQuery();

			System.out.println(rs);

			while (rs.next()) {
				out.println("<b>mentionedUser:</b>" + rs.getString("mentionedUser") + "<br>");
				out.println("<b>mentionedUserState:</b>" + rs.getString("mentionedUserState") + "<br>");
				out.println("<b>postingUsers:</b>" + rs.getString("postingUsers") + "<br>");
				out.println("<hr>");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	%>
</body>
</html>