<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
        <%@page errorPage="LoginErrorPage.jsp" %>
    <%@page import="java.sql.Connection"  %>
<%@page import="java.sql.DriverManager"  %>
<%@page import="java.sql.PreparedStatement"  %>
<%@page import="java.sql.ResultSet"  %>
<%@page import="java.sql.CallableStatement"  %>
<%@page import="java.sql.SQLException"  %>
<%@page import="java.sql.Statement"  %>
<%@page import="java.sql.Types"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<br>
<font face="Gabriola" size="10">
<br>
<%
String user=request.getParameter("uname");
String pass=request.getParameter("password");
Connection conn=null;
Statement st=null;
   ResultSet rs=null;
  
   int count=0;
   
   try
   	{
          Class.forName("oracle.jdbc.driver.OracleDriver");
          System.out.println("Driver loaded succcessfully");
          
          conn=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","system","system");
          System.out.println("Connection established");
          
          st=conn.createStatement();
          
          String query="select * from recp";
          rs=st.executeQuery(query);
          
          while(rs.next())
          {
                String name=rs.getString(1);
                String password=rs.getString(2);
                if(name.equalsIgnoreCase(user))
                {
                	 if(password.equals(pass))
                       {
                    	   count=count+1;
                            
                       }
                       
                }
                
          }
         
          if(count==0)
          {
        	  %>
        	  
        	  <jsp:forward page="recplogin.html">
        	  </jsp:forward> 
        	  
       <%   }
          else
          {
        	  out.println("Login Successful..."); %>
        	   <jsp:forward page="select.html">
        	  </jsp:forward> 
         <%
         }
         
        
  	 } 
	catch (ClassNotFoundException e) {e.printStackTrace();} 
   	catch (SQLException e) {e.printStackTrace();} %>

</font>
</body>
</html>