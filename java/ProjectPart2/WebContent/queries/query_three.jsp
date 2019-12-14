<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<html>
<head>
<title>Query One</title>
</head>
<body>
	<h1>Query 3</h1>
	<%@ include file="../DBInfo.jsp"%>
	<%
		Connection conn = null;
		PreparedStatement stmt = null;
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
			String year = (String) request.getParameter("year");
			String k = (String) request.getParameter("amount");

			//String sqlQuery = "SELECT retweet_count, tweet_text, user.screen_name, category, sub_category FROM   tweet INNER JOIN user ON tweet.uscreen_name = user.screen_name WHERE  Year(tweet.created_at) = "
			//		+ year + " AND Month(tweet.created_at) = " + month + " ORDER  BY retweet_count DESC LIMIT  " + k
			//		+ ";";
			
			String sqlQuery = "";
			stmt = conn.prepareStatement(sqlQuery);
			System.out.println(stmt);
			rs = stmt.executeQuery();
			System.out.println(rs);

			while (rs.next()) {
				out.println("<b>Number of states:</b>" + rs.getString("statenum") + "<br>");
				out.println("<b>States:</b>" + rs.getString("states") + "<br>");
				out.println("<b>Hashtag:</b>" + rs.getString("hashtag_text") + "<br>");
				out.println("<hr>");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	%>
</body>
</html>
