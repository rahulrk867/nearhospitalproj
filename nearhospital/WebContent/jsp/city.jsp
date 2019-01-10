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
    	String username="",cityname="",message="",button="";
    	int cityId=0;
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
    		cityId=Integer.parseInt(request.getParameter("id"));
    		button="Update";
    	}
    	else
    	{
    		cityId=0;
    		button="Save";
    	}
    	
	%>
	
	<jsp:useBean id="city" class="com.beans.hosp.City" scope="page" ></jsp:useBean>
	
	<%
		city.getCity(cityId);
	%>
	
	<h2 align="center" >City</h2> 
	
	<h3 align="center"><%=message %></h3>	
	<%
		message="";
	%>
	
	<form action="" onsubmit="return onsave();">
		<table border="2" align="center">
			<tr>
				<th>City Name</th>
				<td>
					<input type="text" id="City Name" name="City Name" value="<%= city.getCityName()%>">
					<input type="hidden" id="City Id" name="City Id" value="<%= city.getCityId()%>">
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
	<h2 align="center" >City List</h2> 
	
	<%
	ArrayList<City> arrayList = city.selectCity();
		if(arrayList.size()!=0)
		{
	%>
		<form > 
			<table border="2" align="center">
			 	<tr>
			 		<th>City Name</th><th>Edit/Delete</th>
			 	</tr>
	<%		
			for(City c:arrayList){
				cityname=c.getCityName();
				cityId=c.getCityId();
			%>
				<tr>
					<td><%=cityname %></td>
					<td>
						<a href="city.jsp?id=<%=cityId%>">Edit</a>/
						<a href="city.jsp?did=<%=cityId%>" onclick="return ondelete();">Delete</a>
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
		<h3 align="center">No City Added</h3>
	<%
		}
		
		if(request.getParameter("did")!=null)
		{
			cityId=Integer.parseInt(request.getParameter("did"));
		%>
		<jsp:setProperty property="cityId" name="city" value="<%=cityId %>"/>
		<%
			city.deleteCity();
			message=city.getMessage();
			city.releaseDB();
			response.sendRedirect("city.jsp");
		}
		
		if(request.getParameter("save")!=null)
		{
			cityname=request.getParameter("City Name");
			cityId=Integer.parseInt(request.getParameter("City Id"));
	%>
			<jsp:setProperty property="cityName" name="city" param="City Name"/>
			<jsp:setProperty property="cityId" name="city" param="City Id"/>
	<%
			button=request.getParameter("save");
			if(button.equals("Save"))
			{
				city.saveCity();
			}
			else
			{
				city.updateCity();
			}
			message=city.getMessage();
			city.releaseDB();
			response.sendRedirect("city.jsp");
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