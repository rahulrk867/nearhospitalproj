<%@page import="java.util.Arrays"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.nearHospConst.Const"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="../css/style.css" media="screen" />
<script type="text/javascript" src="../js/hospital.js"></script>
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
          <li><a href="hospital.jsp" class="current">Hospitals</a></li>
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
    	String username="",hospitalname="",address="",cityName="",areaName="",message="",button="";
    	int hospitalId=0,areaId=0,cityId=0;
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
    		hospitalId=Integer.parseInt(request.getParameter("id"));
    		button="Update";
    	}
    	else
    	{
    		hospitalId=0;
    		button="Save";
    	}
    	
	%>
	
	<jsp:useBean id="hospital" class="com.beans.hosp.Hospital" scope="page" ></jsp:useBean>
	
	<%
		hospital.getHospital(hospitalId);
	%>
	<br/>
	<h2 align="center" >Hospitals</h2> 
	
	<h3 align="center"><%=message %></h3>	
	<%
		message="";
	int cid=0;
	if(request.getParameter("city")!=null)
	{
		cid=Integer.parseInt(request.getParameter("city"));
		hospital.setCityId(cid);
	}
	else
	{
		cid=hospital.getCityId();
	}
	if(request.getParameter("name")!=null)
	{
		hospitalname=request.getParameter("name");
		hospital.setHospitalName(request.getParameter("name"));
	}
	else
	{
		hospitalname=hospital.getHospitalName();
	}
	if(request.getParameter("add")!=null)
	{
		address=request.getParameter("add");
		hospital.setAddress(request.getParameter("add"));
	}
	else
	{
		address=hospital.getAddress();
	}
	
	%>
	
	<form action="" onsubmit="return onsave();">
		<table border="2" align="center">
			<tr>
				<th>Hospital Name</th>
				<td>
					<input type="text" id="Hospital Name" name="Hospital Name" value="<%=hospitalname %>" >
				</td>
			</tr>
			<tr>
				<th>Address</th>
				<td>
					<textarea id="Address" name="Address" rows="5" columns="10"><%= address%></textarea>
					<input type="hidden" id="Hospital Id" name="Hospital Id" value="<%= hospital.getHospitalId()%>">
				</td>
			</tr>
			<tr>
				<th>City</th>
				<td>
					<select id="City" name="City" onchange="return oncity();">
						<option value=""> Select City </option>
						<%
							
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
				<th>Area</th>
				<td>
					<select id="Area" name="Area" onchange="return onarea();">
						<option value=""> Select Area </option>
						<%
							int aid=0;
							if(request.getParameter("area")!=null)
							{
								aid=Integer.parseInt(request.getParameter("area"));
							}
							else
							{
								aid=hospital.getAreaId();
							}
							resultSet=hospital.selectArea();
							while(resultSet.next())
							{
								areaId=resultSet.getInt("areaId");
								areaName=resultSet.getString("areaName");
								if(areaId==aid)
								{
									%>
									<option value="<%= areaId%>" selected="selected"><%=areaName %></option>
									<%	
								}
								else
								{
									%>
									<option value="<%= areaId%>" ><%=areaName %></option>
									<%	
								}
							}
						%>
					</select>
				</td>
			</tr>
			<tr>
				<th>Phone</th>
				<td>
					<input type="text" id="Phone" name="Phone" value="<%= hospital.getPhone()%>">
				</td>
			</tr>
			<tr>
				<th>Department</th>
				<td>
					<table>
					<%
					int i=0;
						int deptId[]=hospital.getDepartmentId();
						resultSet=hospital.selectDepartment();
						while(resultSet.next())
						{
							int depid=resultSet.getInt("deptId");
							if(deptId!=null){
								if(Arrays.binarySearch(deptId, depid)!=-1)
								{
						%>
							<tr>
								<td><input type="checkbox" name="chk" id="chk_<%= i%>" value="<%=depid %>" checked="checked"><%=resultSet.getString("name") %></td>
							</tr>
						<%
								}
							}else
							{
					%>
						<tr>
							<td><input type="checkbox" name="chk" id="chk_<%= i%>" value="<%=depid %>" ><%=resultSet.getString("name") %></td>
						</tr>
					<%
							}
							i++;
						}
					%>
					
					</table>
					<input type="hidden" id="count" value="<%= i%>"/>
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
	<h2 align="center" >Hospital List</h2> 
	
	<%
		
		resultSet=hospital.selectHospitals();
		if(resultSet.next())
		{
	%>
		<form > 
			<table border="2" align="center">
			 	<tr>
			 		<th>Hospital Name</th><th>Address</th><th>Area</th>
			 		<th>City</th><th>Departments</th><th>Edit/Delete</th>
			 	</tr>
	<%		
			do{
				hospitalId=resultSet.getInt("hospitalId");
				hospitalname=resultSet.getString("hospitalName");
				address=resultSet.getString("address");
				areaName=resultSet.getString("areaName");
				cityName=resultSet.getString("cityName");
			%>
				<tr>
					<td><%= hospitalname %></td><td><%= address %></td>
					<td><%= areaName %></td><td><%= cityName %></td>
					<td>
						<table>
							<%
								hospital.setHospitalId(hospitalId);
								ResultSet result=hospital.getDepartment();
								if(result.next())
								{
									do{
							%>
								<tr><td><%= result.getString("name")%></td></tr>
							<%	
									}while(result.next());
								}
								else
								{
							%>
								<tr><td>No Departments</td></tr>
							<%		
								}
							%>
						</table>
					</td>
					<td>
						<a href="hospital.jsp?id=<%=hospitalId%>">Edit</a>/
						<a href="hospital.jsp?did=<%=hospitalId%>" onclick="return ondelete();">Delete</a>
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
		<h3 align="center">No Hospital Added</h3>
	<%
		}
		
		if(request.getParameter("did")!=null)
		{
			hospitalId=Integer.parseInt(request.getParameter("did"));
		%>
		<jsp:setProperty property="hospitalId" name="hospital" value="<%=hospitalId %>"/>
		<%
			hospital.deleteHospital();
			message=hospital.getMessage();
			response.sendRedirect("hospital.jsp");
		}
		
		if(request.getParameter("save")!=null)
		{
	%>
			<jsp:setProperty property="hospitalId" name="hospital" param="Hospital Id"/>
			<jsp:setProperty property="hospitalName" name="hospital" param="Hospital Name"/>
			<jsp:setProperty property="address" name="hospital" param="Address"/>
			<jsp:setProperty property="areaId" name="hospital" param="Area"/>
			<jsp:setProperty property="departmentId" name="hospital" param="chk"/>
			<jsp:setProperty property="phone" name="hospital" param="Phone"/>
	<%
			button=request.getParameter("save");
			if(button.equals("Save"))
			{
				hospital.saveHospital();
			}
			else
			{
				hospital.updateHospital();
			}
			message=hospital.getMessage();
			response.sendRedirect("hospital.jsp");
		}
		hospital.releaseDB();
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