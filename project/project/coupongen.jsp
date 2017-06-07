<%@page import="monfox.toolkit.snmp.agent.modules.SnmpV2Mib.SysOREntry"%>
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
<%@page import=" java.sql.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.ParseException"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%
int pid=Integer.parseInt(request.getParameter("pid"));
String pname=request.getParameter("pname");
long pcno=Long.parseLong(request.getParameter("pcno"));
String padd=request.getParameter("padd");
//appoint
String type1=request.getParameter("action");
int slot=Integer.parseInt(request.getParameter("slot"));
int did=Integer.parseInt(request.getParameter("docid"));
int cpno=Integer.parseInt(request.getParameter("copno"));
String date11=request.getParameter("todays");

Date date1=Date.valueOf(date11);
Connection conn=null;
Statement st=null;
   ResultSet rs=null;
   ResultSet rs1=null;
   int count=0;
   try
  	{
         Class.forName("oracle.jdbc.driver.OracleDriver");
         System.out.println("Driver loaded succcessfully");
         
         conn=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","system","system");
         System.out.println("Connection established");
         
         st=conn.createStatement();
         
         String query="select * from patient";
         rs=st.executeQuery(query);
         
         while(rs.next())
         {
               int id=rs.getInt(1);
               
               if(id==pid)
               { count=count+1; }
               
         }
        
         if(count==0)
         {
        	 
       	 
        	 	PreparedStatement pspmt = conn.prepareStatement("insert into patient values(?,?,?,?)");
				pspmt.setInt(1,pid);  
				pspmt.setString(2,pname);   
				pspmt.setString(3, padd);     
				pspmt.setLong(4, pcno);
				pspmt.execute();
				System.out.println("Record inserted in patient");
								
				//Coupon
				PreparedStatement pspmt1 = conn.prepareStatement("insert into appoint values(?,?,?,?,?,?)");
				pspmt1.setString(1,type1);  
				pspmt1.setInt(2,slot);   
				pspmt1.setDate(3,date1);     
				pspmt1.setInt(4, cpno);
				pspmt1.setInt(5, did);
				pspmt1.setInt(6, pid);
				pspmt1.execute();
				System.out.println("Record inserted in appoint");
       	  
      	 }
         else
         {
        	 System.out.println("came in else");
         		String query1="select * from APPOINT";
         		 rs1=st.executeQuery(query1);
          		
         		 while(rs.next())
        		 {
         		   Date date2=rs.getDate(3);
         	       String date22=String.valueOf(date2);
              	   System.out.println("Date is"+date22);
              	   if(date22.equals(date11))
                	{
              		 System.out.println("Done in if");
                	%>
                	
<!--                 	window.confirm("Sorry already an appointment for today is fixed with this patient id "); -->
                		sorry not possible
                	<% }
       	  	
              	   else
              	   {
                		 System.out.println("Done in else");

              	   }
      			
      	 		}//coupon deatils
      	}
        
       
 	 } 
	catch (ClassNotFoundException e) {e.printStackTrace();} 
  	catch (SQLException e) {e.printStackTrace();} 
   
%>

</body>
</html>