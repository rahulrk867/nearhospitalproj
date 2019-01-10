<%@page import="java.sql.ResultSet"%>
<%@page import="com.nearHospConst.Const"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="../css/style.css" media="screen" />
<script type="text/javascript" src="../js/hservice.js"></script>
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
          <li><a href="hservice.jsp" class="current">H Service</a></li>
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
    	String username="",hospitalName="",department="",service="",cityName="",areaName="",message="",button="";
    	int hospitalId=0,departmentId=0,serviceId=0,areaId=0,cityId=0;
    	ResultSet resultSet;
    %>	
    <jsp:useBean id="hospital" class="com.beans.hosp.Hservice" scope="page" ></jsp:useBean>
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
   
	<br/>
	<h2 align="center" >Hospital service</h2> 
	
	<h3 align="center"><%=message %></h3>	
	<%
		message="";
	%>
	
	<form action="" onsubmit="return onsave();">
		<table border="2" align="center">
			<tr>
				<th>City</th>
				<td>
					<select id="City" name="City" onchange="return oncity();">
						<option value=""> Select City </option>
						<%
							int cid=0 ;
							if(request.getParameter("city")!=null)
							{
								cid=Integer.parseInt(request.getParameter("city"));
							}
							else
							{
								cid=0;
							}
							hospital.setCityId(cid);
							resultSet=hospital.selectCity();
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
				<th>Hospital </th>
				<td>
					<select id="Hospital" name="Hospital" onchange="return onhospital();">
						<option value=""> Select Hospital </option>
						<%
							int aid=0;
							if(request.getParameter("hospital")!=null)
							{
								aid=Integer.parseInt(request.getParameter("hospital"));
							}
							else
							{
								aid=0;
							}
							hospital.setHospitalId(aid);
							resultSet=hospital.selectHospital();
							while(resultSet.next())
							{
								hospitalId=resultSet.getInt("hospitalId");
								hospitalName=resultSet.getString("hospitalName");
								if(hospitalId==aid)
								{
									%>
									<option value="<%= hospitalId%>" selected="selected"><%=hospitalName %></option>
									<%	
								}
								else
								{
									%>
									<option value="<%= hospitalId%>" ><%=hospitalName %></option>
									<%	
								}
							}
						%>
					</select>
				</td>
			</tr>
			<tr>
				<th>Department</th>
				<td>
					<select id="Department" name="Department" onchange="return ondepart();">
					<option value=""> Select Department </option>
					<%
					int did=0;
					if(request.getParameter("dept")!=null)
					{
						did=Integer.parseInt(request.getParameter("dept"));
					}
					else
					{
						did=0;
					}
					hospital.setDepartmentId(did);
						resultSet=hospital.selectDepartment();
						while(resultSet.next())
						{
								departmentId=resultSet.getInt("deptId");
								department=resultSet.getString("name");
								if(departmentId==did)
								{
									%>
									<option value="<%= departmentId%>" selected="selected"><%=department %></option>
									<%	
								}
								else
								{
									%>
									<option value="<%= departmentId%>" ><%=department %></option>
									<%	
								}
		
						}
					%>
					</select>
				</td>
			</tr>
			<tr>
				<th>Service</th>
				<td>
					<table>
					<%
					int i=0;
						resultSet=hospital.selectService();
						while(resultSet.next())
						{
					%>
						<tr>
							<td><input type="checkbox" name="chk" id="chk_<%=i %>" value="<%=resultSet.getInt("serviceId") %>"><%=resultSet.getString("service") %></td>
						</tr>
					<%	
					i++;
						}
					%>
					</table>
					<input type="hidden" id="count" value="<%=i %>"/>
				</td>
			</tr>
			<tr>
				<td></td>
				<td align="center">
					<input type="submit" id="save" name="save" value="Save">
					<input type="reset" id="clear" name="clear" value="Clear">
				</td>
			</tr>
		</table>
	</form>
	<h2 align="center" >Service List</h2> 
	
	<%
		
		resultSet=hospital.getService();
		if(resultSet.next())
		{
	%>
		<form > 
			<table border="2" align="center">
			 	<tr>
			 		<th>Services</th><th>Delete</th>
			 	</tr>
	<%		
			do{
				int hospServId=resultSet.getInt("hospServId");
				service=resultSet.getString("service");
			%>
				<tr>
					<td><%= service %></td>
					<td>
						<a href="hservice.jsp?did=<%=hospServId%>" onclick="return ondelete();">Delete</a>
					</td>
				</tr>
			<%	
			}while(resultSet.next());
	%>
			</table>
		</form>
	<%
		}
		else
		{
	%>
		<h3 align="center">No Service Added</h3>
	<%
		}
		
		if(request.getParameter("did")!=null)
		{
			int hospServId=Integer.parseInt(request.getParameter("did"));
		%>
		<jsp:setProperty property="hospServId" name="hospital" value="<%=hospServId %>"/>
		<%
			hospital.deleteHservice();
			message=hospital.getMessage();
			hospital.releaseDB();
			response.sendRedirect("hservice.jsp");
		}
		
		if(request.getParameter("save")!=null)
		{
	%>
			<jsp:setProperty property="hospitalId" name="hospital" param="Hospital"/>
			<jsp:setProperty property="cityId" name="hospital" param="City"/>
			<jsp:setProperty property="serviceId" name="hospital" param="chk"/>
			<jsp:setProperty property="departmentId" name="hospital" param="Department"/>
	<%
			
				hospital.saveHservice();
			message=hospital.getMessage();
			hospital.releaseDB();
			response.sendRedirect("hservice.jsp?city="+hospital.getCityId()+"&hospital="+hospital.getHospitalId());
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