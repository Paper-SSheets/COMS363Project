<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<html>
<head>
<title>Query Six</title>
</head>
<body>
	<h1>Query 6</h1>
	<%@ include file="../DBInfo.jsp"%>
	<%
		Connection conn = null;
		PreparedStatement stmt = null;
		PreparedStatement stmtTwo = null;
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
			String hashtags = (String) request.getParameter("hashtaglist");
			String k = (String) request.getParameter("amount");
			System.out.println(hashtags + k); 
			//String sqlQuery = "SELECT retweet_count, tweet_text, user.screen_name, category, sub_category FROM   tweet INNER JOIN user ON tweet.uscreen_name = user.screen_name WHERE  Year(tweet.created_at) = "
			//		+ year + " AND Month(tweet.created_at) = " + month + " ORDER  BY retweet_count DESC LIMIT  " + k
			//		+ ";";
			String setHashtags = "SET @hashtags = '" + hashtags + "';";

			String sqlQuery = "SELECT u.screen_name, u.state_name FROM   user u INNER JOIN tweet t ON t.uscreen_name = u.screen_name INNER JOIN tagged tag ON tag.tid = t.tid INNER JOIN hashtag h ON h.hname = tag.hashtag WHERE  Find_in_set(h.hname, @hashtags) GROUP  BY u.screen_name ORDER  BY u.num_followers DESC LIMIT " + k + " ;";
			 

			stmt = conn.prepareStatement(sqlQuery);
			stmtTwo = conn.prepareStatement(setHashtags);

			System.out.println(stmt);
			System.out.println(stmtTwo);

			rs = stmtTwo.executeQuery();
			System.out.println(rs);
			rs = stmt.executeQuery();

			System.out.println(rs);

			while (rs.next()) {
				out.println("<b>User:</b>" + rs.getString("screen_name") + "<br>");
				out.println("<b>State Name:</b>" + rs.getString("state_name") + "<br>");
				out.println("<hr>");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	%>
</body>
</html>
