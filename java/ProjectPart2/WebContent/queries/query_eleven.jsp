<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<html>
<head>
<title>Query Eleven</title>
</head>
<body>
	<h1>Query Eleven</h1>
	<%@ include file="../DBInfo.jsp"%>
	<%
		Connection conn = null;
		PreparedStatement stmt1 = null;
		PreparedStatement stmt2 = null;
		PreparedStatement stmt3 = null;
		PreparedStatement stmt4 = null;
		PreparedStatement stmt5 = null;
		ResultSet rs = null;

		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(DB_URL, DB_USERNAME, DB_PASSWORD);

			String k = (String) request.getParameter("amount");
			String state = (String) request.getParameter("state");
			String month = (String) request.getParameter("month");
			String year = (String) request.getParameter("year");
			String hashtag = (String) request.getParameter("hashtag");

			System.out.println("k" + k + "state" + state + "month" + month + " year" + year + "hash" + hashtag);
			String sqlQuery1 = "SET @state = '" + state + "';";
			String sqlQuery2 = "SET @hashtag = '" + hashtag + "';";
			String sqlQuery3 = "SET @month = '" + month + "';";
			String sqlQuery4 = "SET @year = '" + year + "';";
			String sqlQuery5 = "SELECT t.tweet_text, h.hname        AS hashtag_text, u.screen_name, u.sub_category AS subcategory FROM   tweet t INNER JOIN tagged tag ON tag.tid = t.tid INNER JOIN hashtag h ON h.hname = tag.hashtag INNER JOIN user u ON u.screen_name = t.uscreen_name WHERE  h.hname = @hashtag AND ( u.sub_category = 'GOP' OR u.sub_category = 'Democrat' ) AND u.state_name = @state AND Year(Str_to_date(created_at, '%Y-%m-%d %H:%i:%s')) = @year AND Month(Str_to_date(created_at, '%Y-%m-%d %H:%i:%s')) = @month LIMIT  "
					+ k + ";";

			stmt1 = conn.prepareStatement(sqlQuery1);
			stmt2 = conn.prepareStatement(sqlQuery2);
			stmt3 = conn.prepareStatement(sqlQuery3);
			stmt4 = conn.prepareStatement(sqlQuery4);
			stmt5 = conn.prepareStatement(sqlQuery5);

			System.out.println(stmt1);
			System.out.println(stmt2);
			System.out.println(stmt3);
			System.out.println(stmt4);
			System.out.println(stmt5);

			rs = stmt1.executeQuery();
			rs = stmt2.executeQuery();
			rs = stmt3.executeQuery();
			rs = stmt4.executeQuery();
			rs = stmt5.executeQuery();
			System.out.println(rs);

			while (rs.next()) {
				out.println("<b>tweet_text:</b>" + rs.getString("tweet_text") + "<br>");
				out.println("<b>hashtag_text:</b>" + rs.getString("hashtag_text") + "<br>");
				out.println("<b>screen_name:</b>" + rs.getString("screen_name") + "<br>");
				out.println("<b>sub_category:</b>" + rs.getString("subcategory") + "<br>");
				out.println("<hr>");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	%>
</body>
</html>