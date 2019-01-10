<%@page import="com.beans.hosp.Disease"%>
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
<script type="text/javascript" src="../js/disease.js"></script>
<title>Nearest Hospital</title>
</head>
<body onload="isLogedin()">
<div id="main_container">
  <div class="header">
    <div class="right_header">
      <div id="menu">
        <ul>
          <li><a href="city.jsp">City</a></li>
          <li><a href="area.jsp">Area</a></li>
          <li><a href="department.jsp">Department</a></li>
          <li><a href="service.jsp">Service</a></li>
          <li><a href="hospital.jsp">Hospitals</a></li>
          <li><a href="hservice.jsp">H Service</a></li>
          <li><a href="symptoms.jsp">Symptom</a></li>
          <li><a href="disease.jsp" class="current">Disease</a></li>
          <li><a href="dsymptoms.jsp">D Symptom</a></li>
          <li><a href="logout.jsp" onclick="onlogout()">Logout</a></li>
        </ul>
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
    	String username="",diseases="",message="",button="",homeremedies="",tests="",description="";
    	int diseaseId=0;
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
    		diseaseId=Integer.parseInt(request.getParameter("id"));
    		button="Update";
    	}
    	else
    	{
    		diseaseId=0;
    		button="Save";
    	}
    	
	%>
	
	<jsp:useBean id="disease" class="com.beans.hosp.Disease" scope="page" ></jsp:useBean>
	
	<%
		disease.getDisease(diseaseId);
	%>
	
	<h2 align="center" >disease</h2> 
	
	<h3 align="center"><%=message %></h3>	
	<%
		message="";
	%>
	
	<form action="" onsubmit="return onsave();">
		<table border="2" align="center">
			<tr>
				<th>Disease Name</th>
				<td>
					<input type="text" id="disease" name="disease" value="<%= disease.getDisease()%>">
					<input type="hidden" id="diseaseId" name="diseaseId" value="<%= disease.getDiseaseId()%>">
				</td>
			</tr>
			<tr>
				<th>Description</th>
				<td>
					<textarea rows="5" cols="10" id="description" name="description"><%= disease.getDescription()%></textarea>
				</td>
			</tr>
			<tr>
				<th>Home Remedies</th>
				<td>
					<textarea rows="5" cols="10" id="homeremedies" name="homeremedies"><%= disease.getHomeremedies()%></textarea>
				</td>
			</tr>
			<tr>
				<th>Tests</th>
				<td>
					<textarea rows="5" cols="10" id="tests" name="tests"><%= disease.getTests()%></textarea>
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
	<h2 align="center" >Disease List</h2> 
	
	<%
	ArrayList<Disease> arrayList = disease.selectDisease();
		if(arrayList.size()!=0)
		{
	%>
		<form > 
			<table border="2" align="center">
			 	<tr>
			 		<th>Disease Name</th><th>Description</th><th>HomeRemedies</th><th>Tests</th><th>Edit/Delete</th>
			 	</tr>
	<%		
			for(Disease c:arrayList){
				diseases=c.getDisease();
				diseaseId=c.getDiseaseId();
				description=c.getDescription();
				homeremedies = c.getHomeremedies();
				tests = c.getTests();
			%>
				<tr>
					<td><%=diseases %></td><td><%=description %></td><td><%=homeremedies %></td><td><%=tests %></td>
					<td>
						<a href="disease.jsp?id=<%=diseaseId%>">Edit</a>/
						<a href="disease.jsp?did=<%=diseaseId%>" onclick="return ondelete();">Delete</a>
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
		<h3 align="center">No Disease Added</h3>
	<%
		}
		
		if(request.getParameter("did")!=null)
		{
			diseaseId=Integer.parseInt(request.getParameter("did"));
		%>
		<jsp:setProperty property="diseaseId" name="disease" value="<%=diseaseId %>"/>
		<%
			disease.deleteDisease();
			message=disease.getMessage();
			disease.releaseDB();
			response.sendRedirect("disease.jsp");
		}
		
		if(request.getParameter("save")!=null)
		{
			diseases=request.getParameter("disease");
			diseaseId=Integer.parseInt(request.getParameter("diseaseId"));
	%>
			<jsp:setProperty property="disease" name="disease" param="disease"/>
			<jsp:setProperty property="description" name="disease" param="description"/>
			<jsp:setProperty property="homeremedies" name="disease" param="homeremedies"/>
			<jsp:setProperty property="tests" name="disease" param="tests"/>
			<jsp:setProperty property="diseaseId" name="disease" param="diseaseId"/>
	<%
			button=request.getParameter("save");
			if(button.equals("Save"))
			{
				disease.saveDisease();
			}
			else
			{
				disease.updateDisease();
			}
			message=disease.getMessage();
			disease.releaseDB();
			response.sendRedirect("disease.jsp");
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