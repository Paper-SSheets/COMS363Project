<%
	// Keep URL and password for contacting MySQL database with food schema.
	// change teststudent to your database name (e.g., netid on cs363winservdb)
	// if getting error about public key retrieval, use allowPublicKeyRetrieval=true
	// String DB_URL = "jdbc:mysql://cs363winservdb:3306/teststudent?allowPublicKeyRetrieval=true&useSSL=false";

	String DB_URL = "jdbc:mysql://localhost:3306/testuser?useSSL=false";
	String DB_USERNAME = "root"; // update to use your non-root password
	String DB_PASSWORD="";	// replace with the password for the user
%>
