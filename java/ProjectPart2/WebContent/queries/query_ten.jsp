<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<html>
<head>
<title>Query Ten</title>
</head>
<body>
	<h1>Query 10</h1>
	<%@ include file="../DBInfo.jsp"%>
	<%
		Connection conn = null;
		PreparedStatement stmt = null;
		PreparedStatement stmtTwo = null;
		PreparedStatement stmtThree = null;
		PreparedStatement actualQuery = null;
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
			String states = (String) request.getParameter("list_of_states");

			String setStates = "SET @states = '" + states + "';"; 
			String setMonth = "SET @month = '" + month + "';";
			String setYear = "SET @year = '" + year + "';";

			String tenQuery = "SELECT h.hname AS hashtag_text, Group_concat(DISTINCT u.state_name SEPARATOR ',') AS states FROM   hashtag h INNER JOIN tagged tag ON tag.hashtag = h.hname INNER JOIN tweet t ON t.tid = tag.tid INNER JOIN user u ON u.screen_name = t.uscreen_name WHERE  Find_in_set(u.state_name, @states) AND Year(Str_to_date(created_at, '%Y-%m-%d %H:%i:%s')) = @year AND Month(Str_to_date(created_at, '%Y-%m-%d %H:%i:%s')) = @month GROUP  BY h.hname;";
			
			
			System.out.println(month + year + states); 

			//String sqlQuery = "SELECT retweet_count, tweet_text, user.screen_name, category, sub_category FROM   tweet INNER JOIN user ON tweet.uscreen_name = user.screen_name WHERE  Year(tweet.created_at) = "
			//		+ year + " AND Month(tweet.created_at) = " + month + " ORDER  BY retweet_count DESC LIMIT  " + k
			//		+ ";";


			stmt = conn.prepareStatement(setStates);
			stmtTwo = conn.prepareStatement(setMonth);
			stmtThree = conn.prepareStatement(setYear);
			actualQuery = conn.prepareStatement(tenQuery);

			System.out.println(stmt);
			System.out.println(stmtTwo);
			System.out.println(stmtThree);
			System.out.println(actualQuery);

			System.out.println(rs);
			rs = stmt.executeQuery();

			rs = stmtTwo.executeQuery();

			rs = stmtThree.executeQuery();

			rs = actualQuery.executeQuery();

			System.out.println(rs);

			while (rs.next()) {
				out.println("<b>Hashtag:</b>" + rs.getString("hashtag_text") + "<br>");
				out.println("<b>State Name:</b>" + rs.getString("states") + "<br>");
				out.println("<hr>");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	%>
</body>
</html>
