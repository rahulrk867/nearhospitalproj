<%@page import="java.sql.ResultSet"%>
<%@page import="com.nearHospConst.Const"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="../css/style.css" media="screen" />
<script type="text/javascript" src="../js/area.js"></script>
<title>Nearest Hospital</title>
</head>
<body onload="isLogedin()">
<div id="main_container">
  <div class="header">
    <div class="right_header">
      <div id="menu">
        <ul>
          <li><a href="city.jsp">City</a></li>
          <li><a href="area.jsp"  class="current">Area</a></li>
          <li><a href="department.jsp">Department</a></li>
          <li><a href="service.jsp">Service</a></li>
          <li><a href="hospital.jsp">Hospitals</a></li>
          <li><a href="hservice.jsp" >H Service</a></li>
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
    	String username="",areaname="",cityName="",message="",button="";
    	int cityId=0,areaId=0;
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
    		areaId=Integer.parseInt(request.getParameter("id"));
    		button="Update";
    	}
    	else
    	{
    		areaId=0;
    		button="Save";
    	}
    	
	%>
	
	<jsp:useBean id="area" class="com.beans.hosp.Area" scope="page" ></jsp:useBean>
	
	<%
		area.getArea(areaId);
	%>
	<br/>
	<h2 align="center" >Area</h2> 
	
	<h3 align="center"><%=message %></h3>	
	<%
		message="";
	%>
	
	<form action="" onsubmit="return onsave();">
		<table border="2" align="center">
			<tr>
				<th>City Name</th>
				<td>
					<select id="City Name" name="City Name" onchange="return onCity();">
						<option value=""> Select City </option>
						<%
							int cid=0;
							if(request.getParameter("cid")!=null)
							{
								cid=Integer.parseInt(request.getParameter("cid"));
							}
							else
							{
								cid=area.getCityId();
							}
							//area.setCityId(cid);
							resultSet=area.selectCity();
							while(resultSet.next())
							{
								cityId=resultSet.getInt("cityId");
								cityName=resultSet.getString("cityName");
								if(cityId==cid)
								{
									%>
									<option value="<%= cityId%>" selected="selected"><%=cityName %></option>
									<%	
								}
								else
								{
									%>
									<option value="<%= cityId%>" ><%=cityName %></option>
									<%	
								}
							}
						%>
					</select>
				</td>
			</tr>
			<tr>
				<th>Area Name</th>
				<td>
					<input type="text" id="Area Name" name="Area Name" value="<%= area.getareaName()%>">
					<input type="hidden" id="Area Id" name="Area Id" value="<%= area.getAreaId()%>">
					<input type="hidden" id="City Id" name="City Id" value="<%= area.getCityId()%>">
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
	<h2 align="center" >Area List</h2> 
	
	<%
		if(cid!=0){
		resultSet=area.selectarea(cid);
		if(resultSet.next())
		{
	%>
		<form > 
			<table border="2" align="center">
			 	<tr>
			 		<th>Area Name</th><th>City Name</th><th>Edit/Delete</th>
			 	</tr>
	<%		
			do{
				cityName=resultSet.getString("cityName");
				cityId=resultSet.getInt("cityId");
				areaId=resultSet.getInt("areaId");
				areaname=resultSet.getString("areaName");
			%>
				<tr>
					<td><%=areaname %></td><td><%=cityName %></td>
					<td>
						<a href="area.jsp?id=<%=areaId%>">Edit</a>/
						<a href="area.jsp?did=<%=areaId%>" onclick="return ondelete();">Delete</a>
					</td>
				</tr>
			<%	
			}while(resultSet.next());
	%>
			</table>
		</form>
		<br>
	<%
		}
		else
		{
	%>
		<h3 align="center">No Area Added</h3>
	<%
		}
		}
		else
		{
	%>
		<h3 align="center">Select City to View Area</h3>
	<%
		}
		
		if(request.getParameter("did")!=null)
		{
			areaId=Integer.parseInt(request.getParameter("did"));
		%>
		<jsp:setProperty property="areaId" name="area" value="<%=areaId %>"/>
		<%
			area.deleteArea();
			message=area.getMessage();
			response.sendRedirect("area.jsp?cid="+area.getCityId());
		}
		
		if(request.getParameter("save")!=null)
		{
			areaname=request.getParameter("Area Name");
			cityId=Integer.parseInt(request.getParameter("City Name"));
	%>
			<jsp:setProperty property="cityId" name="area" param="City Name"/>
			<jsp:setProperty property="areaId" name="area" param="Area Id"/>
			<jsp:setProperty property="areaName" name="area" param="Area Name"/>
	<%
			button=request.getParameter("save");
			if(button.equals("Save"))
			{
				area.saveArea();
			}
			else
			{
				area.updateArea();
			}
			area.releaseDB();
			message=area.getMessage();
			response.sendRedirect("area.jsp?cid="+area.getCityId());
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