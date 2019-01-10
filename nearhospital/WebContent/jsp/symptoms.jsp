<%@page import="com.beans.hosp.Symptoms"%>
<%@page import="com.beans.hosp.City"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.nearHospConst.Const"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="../css/style.css" media="screen" />
<script type="text/javascript" src="../js/city.js"></script>
<title>Nearest Hospital</title>
</head>
<body onload="isLogedin()">
<div id="main_container">
  <div class="header">
    <div class="right_header">
      <div id="menu">
        <ul>
         <li><a href="city.jsp" class="current">City</a></li>
          <li><a href="area.jsp">Area</a></li>
          <li><a href="department.jsp">Department</a></li>
          <li><a href="service.jsp">Service</a></li>
          <li><a href="hospital.jsp">Hospitals</a></li>
          <li><a href="hservice.jsp">H Service</a></li>
           <li><a href="symptoms.jsp">Symptom</a></li>
          <li><a href="disease.jsp">Disease</a></li>
          <li><a href="dsymptoms.jsp">D Symptom</a></li>
          <li><a href="logout.jsp" onclick="onlogout()">Logout</a></li></ul>
      </div>
    </div>
  </div>
  <div id="middle_box">
    <div class="middle_box_content">
    	<%=Const.slogan %>
    </div>
  </div>
  
  <div id="main_content">
    						<!-- Code Begins-->
    <%!
    	String username="",symptom="",message="",button="";
    	int symptomId=0;
    	ResultSet resultSet;
    %>	
    
    <%
		if(session.getAttribute("username")!=null)
		{
			username=(String)session.getAttribute("username");
		}
		else
		{
			username="";
			response.sendRedirect("login.jsp");
		}
    %>
    <input type="hidden" name="username" id="username" value="<%=username%>"> 
    <%
    	if(request.getParameter("id")!=null)
    	{
    		symptomId=Integer.parseInt(request.getParameter("id"));
    		button="Update";
    	}
    	else
    	{
    		symptomId=0;
    		button="Save";
    	}
    	
	%>
	
	<jsp:useBean id="symptoms" class="com.beans.hosp.Symptoms" scope="page" ></jsp:useBean>
	
	<%
	symptoms.getSymptom(symptomId);
	%>
	
	<h2 align="center" >symptom</h2> 
	
	<h3 align="center"><%=message %></h3>	
	<%
		message="";
	%>
	
	<form action="" onsubmit="return onsave();">
		<table border="2" align="center">
			<tr>
				<th>Symptoms</th>
				<td>
					<input type="text" id="symptom" name="symptom" value="<%= symptoms.getSymptom() %>">
					<input type="hidden" id="symptomId" name="symptomId" value="<%= symptoms.getSymptomId()%>">
				</td>
			</tr>
			<tr>
				<td></td>
				<td align="center">
					<input type="submit" id="save" name="save" value="<%= button%>">
					<input type="reset" id="clear" name="clear" value="Clear">
				</td>
			</tr>
		</table>
	</form>
	<br>
	<h2 align="center" >Symptom List</h2> 
	
	<%
	ArrayList<Symptoms> arrayList = symptoms.selectSymptom();
		if(arrayList.size()!=0)
		{
	%>
		<form > 
			<table border="2" align="center">
			 	<tr>
			 		<th>Symptom Name</th><th>Edit/Delete</th>
			 	</tr>
	<%		
			for(Symptoms c:arrayList){
				symptom=c.getSymptom();
				symptomId=c.getSymptomId();
			%>
				<tr>
					<td><%=symptom %></td>
					<td>
						<a href="symptoms.jsp?id=<%=symptomId%>">Edit</a>/
						<a href="symptoms.jsp?did=<%=symptomId%>" onclick="return ondelete();">Delete</a>
					</td>
				</tr>
			<%	
			}
	%>
			</table>
		</form>
		<br>
	<%
		}
		else
		{
	%>
		<h3 align="center">No Symptoms Added</h3>
	<%
		}
		
		if(request.getParameter("did")!=null)
		{
			symptomId=Integer.parseInt(request.getParameter("did"));
		%>
		<jsp:setProperty property="symptomId" name="symptoms" value="<%=symptomId %>"/>
		<%
		symptoms.deleteSymptom();
			message=symptoms.getMessage();
			symptoms.releaseDB();
			response.sendRedirect("symptoms.jsp");
		}
		
		if(request.getParameter("save")!=null)
		{
			symptom=request.getParameter("symptom");
			symptomId=Integer.parseInt(request.getParameter("symptomId"));
	%>
			<jsp:setProperty property="symptom" name="symptoms" param="symptom"/>
			<jsp:setProperty property="symptomId" name="symptoms" param="symptomId"/>
	<%
			button=request.getParameter("save");
			if(button.equals("Save"))
			{
				symptoms.saveSymptom();
			}
			else
			{
				symptoms.updateSymptom();
			}
			message=symptoms.getMessage();
			symptoms.releaseDB();
			response.sendRedirect("symptoms.jsp");
		}
	%>

    
    					
    						<!-- Code Ends-->
    <div class="clear"></div>
  </div>
  <div id="footer">
    <div class="copyright">  </div>
    <div class="center_footer">&copy; JAVA TEAM 2017. All Rights Reserved</div>
    <div class="footer_links">  </div>
  </div>
</div>
<div align=center></div>
</body>
</html>