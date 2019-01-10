<%@page import="com.beans.hosp.Symptoms"%>
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
<script type="text/javascript" src="../js/dsymptoms.js"></script>
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
          <li><a href="disease.jsp">Disease</a></li>
          <li><a href="dsymptoms.jsp" class="current">D Symptom</a></li>
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
    	String username="",button="",message="",disease;
    	int diseaseId=0;
    	ResultSet resultSet;
    %>	
    <jsp:useBean id="diseaseSymptom" class="com.beans.hosp.DiseaseSymptom" scope="page" ></jsp:useBean>
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
	<h2 align="center" >Disease Symptoms</h2> 
	
	<h3 align="center"><%=message %></h3>	
	<%
		message="";
	%>
	
	<form action="" onsubmit="return onsave();">
		<table border="2" align="center">
			<tr>
				<th>Disease</th>
				<td>
					<select id="disease" name="disease" onchange="return ondisease();">
						<option value=""> Select Disease </option>
						<%
							int aid=0;
							if(request.getParameter("disease")!=null)
							{
								aid=Integer.parseInt(request.getParameter("disease"));
							}
							else
							{
								aid=0;
							}
							diseaseSymptom.setDiseaseId(aid);
							ArrayList<Disease> diseaseList=diseaseSymptom.selectDisease();
							for(Disease d : diseaseList)
							{
								diseaseId=d.getDiseaseId();
								disease=d.getDisease();
								if(diseaseId==aid)
								{
									%>
									<option value="<%= diseaseId%>" selected="selected"><%=disease %></option>
									<%	
								}
								else
								{
									%>
									<option value="<%= diseaseId%>" ><%=disease %></option>
									<%	
								}
							}
						%>
					</select>
				</td>
			</tr>
			<tr>
				<th>Symptom</th>
				<td>
					<table>
					<%
						ArrayList<Integer> symptomList = diseaseSymptom.getDiseaseSymptom();
						
						int i=0;
						ArrayList<Symptoms> arrayList=diseaseSymptom.selectSymptom();
						for(Symptoms s : arrayList)
						{
							if(symptomList.contains(s.getSymptomId())){
					%>
						<tr>
							<td><input checked="checked" type="checkbox" name="symptomId" id="chk_<%=i %>" value="<%=s.getSymptomId() %>"><%=s.getSymptom() %></td>
						</tr>
					<%	
							}
							else{
								%>
								<tr>
									<td><input type="checkbox" name="symptomId" id="chk_<%=i %>" value="<%=s.getSymptomId() %>"><%=s.getSymptom() %></td>
								</tr>
							<%	
									}
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
					<input type="submit" id="save" name="save" value="<%=diseaseSymptom.getCommand()%>">
					<input type="reset" id="clear" name="clear" value="Clear">
				</td>
			</tr>
		</table>
	</form>
	<%
		
		if(request.getParameter("save")!=null)
		{
	%>
			<jsp:setProperty property="*" name="diseaseSymptom" />
	<%
			diseaseSymptom.saveSymptoms();
			message=diseaseSymptom.getMessage();
			response.sendRedirect("dsymptoms.jsp");
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