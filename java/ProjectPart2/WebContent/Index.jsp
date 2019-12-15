<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<html>
<head>
<title> Project Part 2 </title>
</head>
<body>
	<%@ include file="./DBInfo.jsp"%>
	<%
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;

		// Java way for handling an error using try catch
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(DB_URL, DB_USERNAME, DB_PASSWORD);
			stmt = conn.createStatement();

			// show example how to use Statement object for static SQL statements
			
			// Put SQL query here
			//String sqlQuery = "SELECT f.FID, f.FNAME FROM food f";

			//rs = stmt.executeQuery(sqlQuery);
	%>
			<h3>query 1</h3>
			<form action="./queries/query_one.jsp">
			Amount: <input type="number" name="amount"><br>
			Month: <input type="number" name="month"><br>
			Year: <input type="number" name="year">
			<input type="submit" value="GO">
			</form>


			<h3>query 3</h3>
			<form action="./queries/query_three.jsp">
			Amount: <input type="number" name="amount"><br>
			Year: <input type="number" name="year">
			<input type="submit" value="GO">
			</form>

			<h3>query 6</h3>
			<form action="./queries/query_six.jsp">
			Amount: <input type="number" name="amount"><br>
			hashtag_list: <input type="text" name="hashtaglist">
			<input type="submit" value="GO">
			</form>



			<h3>query 10</h3>
			<form action="./queries/query_ten.jsp">
			Month: <input type="number" name="month"><br>
			Year: <input type="number" name="year">
			list_of_states: <input type="text" name="list_of_states">
			<input type="submit" value="GO">
			</form>

			<h3>query 11</h3>
			<form action="./queries/query_eleven.jsp">
			Amount: <input type="number" name="amount"><br>
			Month: <input type="number" name="month"><br>
			Year: <input type="number" name="year">
			State: <input type="text" name="state">
			Hashtag <input type="text" name="hashtag">
			<input type="submit" value="GO">
			</form>
			
			<h3>query 15</h3>
			<form action="./queries/query_fifteen.jsp">
			Month: <input type="number" name="month"><br>
			Year: <input type="number" name="year">
			Sub_catagory: <input type="text" name="sc"><br>
			<input type="submit" value="GO">
			</form>

			<h3>query 18</h3>
			<form action="./queries/query_eighteen.jsp">
			Amount: <input type="number" name="amount"><br>
			Month: <input type="number" name="month"><br>
			Year: <input type="number" name="year">
			Sub-category: <input type="text" name="subcategory"><br>
			
			<input type="submit" value="GO">
			</form>
			
			<h3>query 23</h3>
			<form action="./queries/query_twenty_three.jsp">
			Year: <input type="number" name="year">
			List of months: <input type="text" name="list_of_months"><br>
			Sub_catagory: <input type="text" name="sc"><br>
			<input type="submit" value="GO">
			</form>


			<h3>I</h3>
			<form action="I.jsp">
			screen name: <input type="text" name="screen_name"><br>
			name: <input type="text" name="name">
			category: <input type="text" name="category"><br>
			sub category: <input type="text" name="sub_category"><br>
			of state: <input type="text" name="ofstate"><br>
			num of followers: <input type="number" name="numfollowers"><br>
			num following: <input type="number" name="numfollowing"><br>
			location: <input type="text" name="location"><br>
			<input type="submit" value="GO">
			</form>

			<h3>D</h3>
			<form action="D.jsp">
			screen name: <input type="text" name="screen_name"><br>
			<input type="submit" value="GO">
			</form>

			<a href="">  </a>
			<!-- the form method can be get or post
				but post does not let anyone see the parameter values that are passed between pages
				Use post for sensitive information
			-->
	
			<p></p>
			<input type="submit" value="GO">
			</form>
	<%
			
		} catch (SQLException e) {
			out.println("An exception occurred: " + e.getMessage());
		} finally {
			if (rs!= null) rs.close();
			if (stmt!= null) stmt.close();
			if (conn != null) conn.close();
		}
	%>
</body>
</html>