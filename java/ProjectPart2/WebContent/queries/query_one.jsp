<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<html>
<head>
<title> Query One </title>
</head>
<body>
<h1> Query 1 </h1>
	<%@ include file="../DBInfo.jsp" %>
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
	<form>
		Amount of tweets (integer 1-100): <input type="number" name="num_tweets"><br>
		Year: <input type="number" name="year"><br>
		Month (Integer 1 - 12): <input type="number" name="month"><br>
		<input type="submit" value="Submit">
		<input type="submit" value="Back" action="./../Index.jsp">
	</form>
	<% 
		String k = request.getParameter("num_tweets");
		String year = request.getParameter("year");
		String month = request.getParameter("month");
		
		System.out.println(k + year + month);
		
		String sqlQuery = "select retweet_count, textbody, user.screen_name, category, sub_category " +
				"from tweet inner join user on" + 
				" tweet.screen_name=user.screen where YEAR(tweet.posted) = ? and MONTH(tweet.posted) = ?" +
				" order by retweet_count DESC limit ?";

		stmt = conn.prepareStatement(sqlQuery);

		stmt.setString(1, year);
		stmt.setString(2, month);
		stmt.setString(3, k);
		System.out.println("year, month, k");
		//rs = stmt.executeQuery();
		while(rs.next()) {
			// Let's get the results using r
			out.println(rs.getString("retweet_count"));
		}
		} catch(SQLException e) {
			e.printStackTrace();
		}
	%>
</body>
</html>
