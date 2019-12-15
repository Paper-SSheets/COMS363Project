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
		PreparedStatement stmt = null;
		ResultSet rs = null;

		Class.forName("com.mysql.jdbc.Driver");
		
		if(session.getAttribute("username") == null && session.getAttribute("password") == null) {
			session.setAttribute("username", (String) request.getParameter("username"));
			session.setAttribute("password", (String) request.getParameter("password"));
		}
		
		System.out.println("get attr "+ session.getAttribute("username"));
		System.out.println("get attr "+ session.getAttribute("password"));

		System.out.println("get param" + request.getParameter("username"));
		System.out.println("get param" + request.getParameter("password"));

		try {
			conn = DriverManager.getConnection(DB_URL, DB_USERNAME, DB_PASSWORD);
				
			String checkValidity = "SELECT upassword, privilege FROM appusers where login_name = '" + session.getAttribute("username") + "';";
			stmt = conn.prepareStatement(checkValidity);
			rs = stmt.executeQuery();

			// Gets rid of titles of columns	
			rs.next();

			// Grabs password hash	
			String encryptedPassword = rs.getString("upassword");

			// Grabs whether or not admin
			String is_admin = rs.getString("privilege");

			System.out.println(is_admin);

			// Decrypts password 
			checkValidity = "SELECT sha1('" + (String) session.getAttribute("password")+"') as dopePassword";

			// System.out.println(session.getAttribute("password"));
			
			stmt = conn.prepareStatement(checkValidity);
			rs = stmt.executeQuery();

			rs.next();
			
			String enteredPassword = rs.getString("dopePassword");

			if (encryptedPassword.equals(enteredPassword)) {
				out.println("What's poppin', " + (String) session.getAttribute("username") + "\n Privileges: "  + is_admin);
				session.setAttribute("is_admin", is_admin);
			} else {
				System.out.println("Had to set attributes to null");
				session.setAttribute("is_admin", null);
				session.setAttribute("username", null);
				session.setAttribute("password", null);

				throw new Exception("Incorrect password");
			}

	%>

			<!-- Query 1 -->	
			<h3>query 1</h3>

			<form action="./queries/query_one.jsp">
				Amount: <input type="number" name="amount"><br>
				Month: <input type="number" name="month"><br>
				Year: <input type="number" name="year">

				<input type="submit" value="GO">
			</form>

			<!-- Query 3 -->	

			<h3>query 3</h3>

			<form action="./queries/query_three.jsp">
				Amount: <input type="number" name="amount"><br>
				Year: <input type="number" name="year">

				<input type="submit" value="GO">
			</form>

			<!-- Query 6 -->	

			<h3>query 6</h3>

			<form action="./queries/query_six.jsp">
				Amount: <input type="number" name="amount"><br>
				hashtag_list: <input type="text" name="hashtaglist">

				<input type="submit" value="GO">
			</form>

			<!-- Query 10 -->	

			<h3>query 10</h3>

			<form action="./queries/query_ten.jsp">
				Month: <input type="number" name="month"><br>
				Year: <input type="number" name="year">
				list_of_states: <input type="text" name="list_of_states">

				<input type="submit" value="GO">
			</form>

			<!-- Query 11 -->	
			<h3>query 11</h3>

			<form action="./queries/query_eleven.jsp">
				Amount: <input type="number" name="amount"><br>
				Month: <input type="number" name="month"><br>
				Year: <input type="number" name="year">
				State: <input type="text" name="state">
				Hashtag <input type="text" name="hashtag">

				<input type="submit" value="GO">
			</form>
			
			<!-- Query 15 -->	

			<h3>query 15</h3>

			<form action="./queries/query_fifteen.jsp">
				Month: <input type="number" name="month"><br>
				Year: <input type="number" name="year">
				Sub_catagory: <input type="text" name="sc"><br>

				<input type="submit" value="GO">
			</form>

			<!--  Query 18 -->	
			<h3>query 18</h3>

			<form action="./queries/query_eighteen.jsp">
				Amount: <input type="number" name="amount"><br>
				Month: <input type="number" name="month"><br>
				Year: <input type="number" name="year">
				Sub-category: <input type="text" name="subcategory"><br>
			
				<input type="submit" value="GO">
			</form>

			<!--  Query 23 -->	
			<h3>query 23</h3>

			<form action="./queries/query_twenty_three.jsp">
				Amount: <input type="number" name="amount">
				Year: <input type="number" name="year">
				List of months: <input type="text" name="months"><br>
				Sub_catagory: <input type="text" name="sc"><br>

				<input type="submit" value="GO">
			</form>

			<!--  Insert user - I.jsp-->

			<h3>Insert User</h3>

			<form action="./queries/I.jsp">
				Twitter username: <input type="text" name="screen_name"><br>
				Name: <input type="text" name="name">
				Category: <input type="text" name="category"><br>
				Subcategory: <input type="text" name="sub_category"><br>
				State name: <input type="text" name="state_name"><br>
				Number of followers: <input type="number" name="num_followers"><br>
				Number following: <input type="number" name="num_following"><br>

				<input type="submit" value="GO">
			</form>

			<!--  Delete user - D.jsp-->
			<h3>D</h3>

			<form action="D.jsp">
				Twitter username: <input type="text" name="screen_name"><br>

				<input type="submit" value="GO">
			</form>

			<a href="">  </a>
			
	
			<p></p>
			<input type="submit" value="GO">
	<%
		} catch (Exception e) {
			out.println("An exception occurred: " + e.getMessage());
		} finally {
			if (rs != null) rs.close();
			if (stmt != null) stmt.close();
			if (conn != null) conn.close();
			
		}
	%>

	<form action="login.jsp">
		<input type="submit" value="BACK"/>
	 </form>
</body>
</html>