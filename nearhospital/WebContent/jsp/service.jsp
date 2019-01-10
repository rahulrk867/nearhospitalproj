<%@page import="java.sql.ResultSet"%>
<%@page import="com.nearHospConst.Const"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="../css/style.css" media="screen" />
<script type="text/javascript" src="../js/service.js"></script>
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
          <li><a href="service.jsp" class="current">Service</a></li>
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
    	String username="",servicename="",departmentName="",message="",button="";
    	int departmentId=0,serviceId=0;
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
    		serviceId=Integer.parseInt(request.getParameter("id"));
    		button="Update";
    	}
    	else
    	{
    		serviceId=0;
    		button="Save";
    	}
    	
	%>
	
	<jsp:useBean id="service" class="com.beans.hosp.Services" scope="page" ></jsp:useBean>
	
	<%
		service.getService(serviceId);
	%>
	<br/>
	<h2 align="center" >Services</h2> 
	
	<h3 align="center"><%=message %></h3>	
	<%
		message="";
	%>
	
	<form action="" onsubmit="return onsave();">
		<table border="2" align="center">
			<tr>
				<th>Department Name</th>
				<td>
					<select id="Department Name" name="Department Name" onchange="return onDept();">
						<option value=""> Select Department </option>
						<%
							int deptid=0;
							if(request.getParameter("deptid")!=null)
							{
								deptid=Integer.parseInt(request.getParameter("deptid"));
							}
							else
							{
								deptid=service.getDepartmentId();
							}
							//service.setdepartmentId(cid);
							resultSet=service.selectDepartment();
							while(resultSet.next())
							{
								departmentId=resultSet.getInt("deptId");
								departmentName=resultSet.getString("name");
								if(departmentId==deptid)
								{
									%>
									<option value="<%= departmentId%>" selected="selected"><%=departmentName %></option>
									<%	
								}
								else
								{
									%>
									<option value="<%= departmentId%>" ><%=departmentName %></option>
									<%	
								}
							}
						%>
					</select>
				</td>
			</tr>
			<tr>
				<th>Service Name</th>
				<td>
					<input type="text" id="Service Name" name="Service Name" value="<%= service.getServiceName()%>">
					<input type="hidden" id="Service Id" name="Service Id" value="<%= service.getServiceId()%>">
					<input type="hidden" id="Department Id" name="Department Id" value="<%= service.getDepartmentId()%>">
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
	<h2 align="center" >Service List</h2> 
	
	<%
		if(deptid!=0){
		resultSet=service.selectservice(deptid);
		if(resultSet.next())
		{
	%>
		<form > 
			<table border="2" align="center">
			 	<tr>
			 		<th>Department Name</th><th>Service Name</th><th>Edit/Delete</th>
			 	</tr>
	<%		
			do{
				departmentName=resultSet.getString("name");
				departmentId=resultSet.getInt("deptId");
				servicename=resultSet.getString("service");
				serviceId=resultSet.getInt("serviceId");
			%>
				<tr>
					<td><%= departmentName %></td><td><%= servicename %></td>
					<td>
						<a href="service.jsp?id=<%=serviceId%>">Edit</a>/
						<a href="service.jsp?did=<%=serviceId%>" onclick="return ondelete();">Delete</a>
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
		}
		else
		{
	%>
		<h3 align="center">Select Depart to View Service</h3>
	<%
		}
		
		if(request.getParameter("did")!=null)
		{
			serviceId=Integer.parseInt(request.getParameter("did"));
		%>
		<jsp:setProperty property="serviceId" name="service" value="<%=serviceId %>"/>
		<%
			service.deleteService();
			message=service.getMessage();
			//service.releaseDB();
			response.sendRedirect("service.jsp?deptid="+service.getDepartmentId());
		}
		
		if(request.getParameter("save")!=null)
		{
			servicename=request.getParameter("Service Name");
			departmentId=Integer.parseInt(request.getParameter("Department Name"));
	%>
			<jsp:setProperty property="departmentId" name="service" param="Department Name"/>
			<jsp:setProperty property="serviceId" name="service" param="Service Id"/>
			<jsp:setProperty property="serviceName" name="service" param="Service Name"/>
	<%
			button=request.getParameter("save");
			if(button.equals("Save"))
			{
				service.saveService();
			}
			else
			{
				service.updateService();
			}
			message=service.getMessage();
			//service.releaseDB();
			response.sendRedirect("service.jsp?deptid="+service.getDepartmentId());
		}
		service.releaseDB();
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