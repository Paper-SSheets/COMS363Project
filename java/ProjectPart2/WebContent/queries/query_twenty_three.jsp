<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<html>
<head>
<title>Query 23</title>
</head>
<body>
	<h1>Query 23</h1>
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

			String subcat = (String) request.getParameter("sc");
			String months = (String) request.getParameter("months");
			String year = (String) request.getParameter("year");
			String k = (String) request.getParameter("amount");
			
			String setSubcategory = "SET @subcategory = '" + subcat + "';";
			String setMonths = "SET @months = '" + months + "';";
			String setYear = "SET @subcategory = '" + year + "';";

			String sqlQuery = "SELECT h.hname AS hashtag_text, Count(tag.hashtag) AS num_uses, Month(Str_to_date(t.created_at, '%Y-%m-%d %H:%i:%s')) AS post_month FROM   hashtag h INNER JOIN tagged tag ON tag.hashtag = h.hname INNER JOIN tweet t ON t.tid = tag.tid INNER JOIN user u ON u.screen_name = t.uscreen_name WHERE  u.sub_category = @subcategory && Find_in_set(Month( Str_to_date(t.created_at, '%Y-%m-%d %H:%i:%s') ), @months) AND Year(Str_to_date(t.created_at, '%Y-%m-%d %H:%i:%s')) = @year GROUP  BY h.hname ORDER  BY num_uses DESC LIMIT "
					+ k + ";";

			stmt1 = conn.prepareStatement(setSubcategory);
			stmt2 = conn.prepareStatement(setMonths);
			stmt3 = conn.prepareStatement(setYear);
			
			
			stmt4 = conn.prepareStatement(sqlQuery);


			System.out.println(stmt1);
			System.out.println(stmt2);
			System.out.println(stmt3);
			System.out.println(stmt4);


			rs = stmt1.executeQuery();
			rs = stmt2.executeQuery();
			rs = stmt3.executeQuery();
			rs = stmt4.executeQuery(); // actual query

			while (rs.next()) {
				out.println("<b>Hashtag:</b>" + rs.getString("hashtag_text") + "<br>");
				out.println("<b>Number of uses:</b>" + rs.getString("num_uses") + "<br>");
				out.println("<b>Month posted:</b>" + rs.getString("post_month") + "<br>");
				out.println("<hr>");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			System.out.println("finished");
		}
	%>
</body>
</html>
