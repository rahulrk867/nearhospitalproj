<%@page import="com.beans.hosp.Department"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.nearHospConst.Const"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="../css/style.css" media="screen" />
<script type="text/javascript" src="../js/department.js"></script>
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
          <li><a href="department.jsp" class="current">Department</a></li>
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
    	String username="",name="",image="",message="",button="";
    	int deptId=0;
    	ResultSet resultSet;
    %>	
    
    <%
		if(session.getAttribute("adminId")!=null)
		{
			username=(String)session.getAttribute("adminId");
		}
		else
		{
			username="";
			//response.sendRedirect("login.jsp");
		}
    %>
    <input type="hidden" name="username" id="username" value="<%=username%>"> 
    <%
    	if(request.getParameter("id")!=null)
    	{
    		deptId=Integer.parseInt(request.getParameter("id"));
    		button="Update";
    	}
    	else
    	{
    		deptId=0;
    		button="Save";
    	}
    	
	%>
	
	<jsp:useBean id="dept" class="com.beans.hosp.Department" scope="page" ></jsp:useBean>
	
	<%
		dept.getDept(deptId);
	%>
	<br/>
	<h2 align="center" >Department</h2> 
	<%
		if(!message.equals("")){
	%>
	<h3 align="center"><%=message %></h3>	
	<%
		}
		message="";
	%>
	
	<!-- <form method="post" action="../Upload" onsubmit="return onsave();" enctype="multipart/form-data"> -->
		<form onsubmit="return onsave();">
		<table border="2" align="center">
			<tr>
				<th>Department Name</th>
				<td>
					<input type="hidden" id="departmentId" name="departmentId" value="<%= dept.getDepartmentId()%>">
					<input type="text" id="departmentName" name="departmentName" value="<%= dept.getDepartmentName()%>" >
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
	<h2 align="center" >Department List</h2> 
	
	<%
		resultSet=dept.selectDept();
		if(resultSet.next())
		{
	%>
		<form > 
			<table border="2" align="center">
			 	<tr>
			 		<th>Department</th><th>Edit/Delete</th>
			 	</tr>
	<%		
			do{
				name=resultSet.getString("name");
				deptId=resultSet.getInt("deptId");
			%>
				<tr>
					<td><%=name %></td>
					<td>
						<a href="department.jsp?id=<%=deptId%>">Edit</a>/
						<a href="department.jsp?did=<%=deptId%>" onclick="return ondelete();">Delete</a>
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
		<h3 align="center">No Department Added</h3>
	<%
		}
		
		if(request.getParameter("did")!=null)
		{
			deptId=Integer.parseInt(request.getParameter("did"));
		%>
		<jsp:setProperty property="departmentId" name="dept" value="<%=deptId %>"/>
		<%
			dept.deleteDept();
			message=dept.getMessage();
			dept.releaseDB();
			response.sendRedirect("department.jsp");
		}
		
		if(request.getParameter("save")!=null)
		{
			%>
			<jsp:setProperty property="*" name="dept"/>
			<%
			if(request.getParameter("save").equals("Save"))
			{
				dept.saveDept();
			}
			else
			{
				dept.updateDept();
			}
			message = dept.getMessage();
			dept.releaseDB();
			response.sendRedirect("department.jsp");
		}
		dept.releaseDB();
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