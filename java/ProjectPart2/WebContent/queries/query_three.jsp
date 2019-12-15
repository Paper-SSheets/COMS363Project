<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<html>
<head>
<title>Query Three</title>
</head>
<body>
	<h1>Query Three</h1>
	<%@ include file="../DBInfo.jsp"%>
	<%
		Connection conn = null;
		PreparedStatement stmt1 = null;
		PreparedStatement stmt2 = null;

		ResultSet rs = null;

		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(DB_URL, DB_USERNAME, DB_PASSWORD);

			String k = (String) request.getParameter("amount");
			String year = (String) request.getParameter("year");

			String sqlQuery1 = "SET @year = '" + year + "';";
			String sqlQuery2 = "SELECT Count(DISTINCT u.state_name)                       AS statenum, Group_concat(DISTINCT u.state_name SEPARATOR ', ') AS states, h.hname                                            AS hashtag_text FROM   hashtag h INNER JOIN tagged tag ON tag.hashtag = h.hname INNER JOIN tweet t ON t.tid = tag.tid INNER JOIN user u ON u.screen_name = t.uscreen_name WHERE  u.state_name != \"na\" AND Year(Str_to_date(t.created_at, '%Y-%m-%d %H:%i:%s')) = @year GROUP  BY h.hname ORDER  BY statenum DESC LIMIT " + k +";";

			stmt1 = conn.prepareStatement(sqlQuery1);
			stmt2 = conn.prepareStatement(sqlQuery2);

			System.out.println(stmt1);
			System.out.println(stmt2);

			rs = stmt1.executeQuery();
			rs = stmt2.executeQuery();

			System.out.println(rs);

			while (rs.next()) {
				out.println("<b>Number of states: </b>" + rs.getString("statenum") + "<br>");
				out.println("<b>States:</b>" + rs.getString("states") + "<br>");
				out.println("<b>Hashtag:</b>" + rs.getString("hashtag_text") + "<br>");
				out.println("<hr>");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	%>
</body>
<