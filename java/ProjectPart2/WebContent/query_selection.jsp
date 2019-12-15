<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
	<%
/**
* @author Devin Uner and Ann gould
*/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Food Web App for Demo</title>
</head>
<body>
	<!-- any error is redirected to ShowError.jsp -->
	<%@ page errorPage="ShowError.jsp"%>
	<!-- include all the database connection configurations -->
	<%@ include file="./DBInfo.jsp"%>
	
	<%
		Connection conn=null;
		PreparedStatement stmt=null;
		ResultSet rs=null;

		Class.forName("com.mysql.jdbc.Driver");
		// conn = DriverManager.getConnection(DB_URL, DB_USERNAME, DB_PASSWORD);
		if(session.getAttribute("username") == null && session.getAttribute("password") == null){
			session.setAttribute("username",(String)request.getParameter("username"));  
			session.setAttribute("password",(String)request.getParameter("password")); 
		}
		
		try {
			//conn = DriverManager.getConnection(DB_URL, DB_USERNAME, DB_PASSWORD);
			// uncomment this later
			conn = DriverManager.getConnection(DB_URL, DB_USERNAME, DB_PASSWORD);

			String sqlQuery = "select password_hash, is_admin from real_users where username='"+(String)session.getAttribute("username")+"';";
			stmt = conn.prepareStatement(sqlQuery);
			rs = stmt.executeQuery();
			rs.next();
			String real_password = rs.getString("password_hash");
			String is_admin = rs.getString("is_admin");

			sqlQuery = "select sha('"+(String)session.getAttribute("password")+"') as password_hash;";
			stmt = conn.prepareStatement(sqlQuery);
			rs = stmt.executeQuery();
			rs.next();
			String entered_password = rs.getString("password_hash");

			if(real_password.equals(entered_password)){
				out.println("welcome: " + (String)session.getAttribute("username") + is_admin);
				session.setAttribute("is_admin",is_admin); 
			} else {
				session.setAttribute("is_admin",null);
				session.setAttribute("username",null);
				session.setAttribute("password",null);
				throw new Exception("incorrect password");
			}

		%>
			<h3>query 1</h3>
			<form action="q1.jsp">
			Month: <input type="number" name="month"><br>
			Year: <input type="number" name="year">
			<input type="submit" value="GO">
			</form>

			<h3>query 2</h3>
			<form action="q2.jsp">
			Year: <input type="number" name="year">
			Hashtag: <input type="text" name="hashtagname"><br>
			<input type="submit" value="GO">
			</form>

			<h3>query 3</h3>
			<form action="q3.jsp">
			Year: <input type="number" name="year">
			<input type="submit" value="GO">
			</form>

			<h3>query 6</h3>
			<form action="q6.jsp">
			hashtag_list: <input type="text" name="hashtaglist">
			<input type="submit" value="GO">
			</form>

			<h3>query 10</h3>
			<form action="q10.jsp">
			Month: <input type="number" name="month"><br>
			Year: <input type="number" name="year">
			list_of_states: <input type="text" name="list_of_states">
			<input type="submit" value="GO">
			</form>

			<h3>query 15</h3>
			<form action="q15.jsp">
			Month: <input type="number" name="month"><br>
			Year: <input type="number" name="year">
			Sub_catagory: <input type="text" name="sc"><br>
			<input type="submit" value="GO">
			</form>

			<h3>query 23</h3>
			<form action="q23.jsp">
			Year: <input type="number" name="year">
			List of months: <input type="text" name="list_of_months"><br>
			Sub_catagory: <input type="text" name="sc"><br>
			<input type="submit" value="GO">
			</form>

			<h3>query 27</h3>
			<form action="q27.jsp">
			Year 1: <input type="text" name="year1"><br>
			Year 2: <input type="text" name="year2">
			Month: <input type="number" name="month"><br>
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
		<%		

		conn.close();
		} catch (Exception e){
			out.println("ERROR: check your username and password and permissions");

		}
	%>
	<br />
	<form action="login_2.jsp">
		<input type="submit" value="BACK" />
	</form>
</body>
</html>