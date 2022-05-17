<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@page import = "java.io.*,java.util.*"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
 <%@page import="java.sql.DriverManager"%>
    <%!String buffer;%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>spamconverter</title>
</head>
<body>
<h1>spamconverter</h1>
<%
//public String buff;
String username=request.getParameter("username");
//out.println(request.getInputStream().readAllBytes()s);
String type=request.getParameter("type");
String index=request.getParameter("index");
out.println(username+type+index);
String driver = "com.mysql.jdbc.Driver";
try {
	Class.forName(driver);
	} 
	catch (ClassNotFoundException e) {
	e.printStackTrace();
	}
Connection connection = null;
Statement statement = null;
ResultSet resultSet = null;
PreparedStatement pst;
connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/swordmail", "root", "");
statement=connection.createStatement();
String[] arrOfStr= username.split("@");
String user_nam=arrOfStr[0]+"_inbox";
System.out.println(user_nam);
System.out.println("index:"+index);
String sql="select spam from "+user_nam+" where ibox_id="+index;

//pst=connection.prepareStatement("SELECT spam from ? where ibox_id=?");
//pst.setString(1,user_nam);
//pst.setString(2,index);
resultSet=statement.executeQuery(sql);
System.out.println(sql);
if(resultSet.next()){
	buffer=resultSet.getString(1).toString();

}
System.out.println(buffer);
if(buffer.equals("3") && type.equals("1"))
{
	buffer="1";
	System.out.println(buffer);
	String sql2="update "+user_nam+" set spam="+buffer+" where ibox_id="+index;
	statement.executeQuery(sql2);
}
else if(buffer.equals("0") && type.equals("1"))
{
	buffer="1";
	System.out.println(buffer);
	String sql2="update "+user_nam+" set spam="+buffer+" where ibox_id="+index;
	statement.executeQuery(sql2);
}
else{
	buffer="1";
	System.out.println(buffer);
	String sql2="update "+user_nam+" set spam="+buffer+" where ibox_id="+index;
	statement.executeQuery(sql2);
}




%>
</body>
</html>