<%@page import="com.nearHospConst.Const"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="../css/style.css" media="screen" />
<script type="text/javascript" src="../js/login.js"></script>
<title>Home</title>
</head>
<body>
<div id="main_container">
  <div class="header">
    <div class="right_header">
      <div id="menu">
        <ul>
          <li><a class="current" href="login.jsp">Login</a></li>
        </ul>
      </div>
    </div>
  </div>
  <div id="middle_box">
    <div class="middle_box_content">
    	<%=Const.slogan %>
    </div>
  </div>
  
  <div id="main_content" align="center">
    						<!-- Code Begins-->
	
	<jsp:useBean id="login" class="com.beans.hosp.Login" scope="page"></jsp:useBean>
	
	<%!
		String message="";
	%>
	
	<h2 align="center" >Login Here</h2> 
	
	<h3 align="center" ><%=message %></h3>	
	<%
		message="";
	%>
	<form action="" onsubmit="return isFilled();">
		<table border="2">
			<tr>
				<th>Username</th>
				<td><input type="text" id="username" name="username" ></td>
			</tr>
			<tr>
				<th>Password</th>
				<td><input type="password" id="password" name="password" ></td>
			</tr>
			<tr>
				<td></td>
				<td align="center">
					<input type="submit" id="login" name="login" value="Login">
					<input type="reset" id="clear" name="clear" value="Clear">
				</td>
			</tr>
		</table>
	</form>	
	<br>
	<%
		if(request.getParameter("login")!=null)
		{
	%>
		<jsp:setProperty property="username" name="login" param="username"/>
		<jsp:setProperty property="password" name="login" param="password"/>
	<%
		if(login.isAdmin())
		{
			session.setAttribute("username", login.getUsername());
			//login.releaseDB();
			response.sendRedirect("city.jsp");
		}
		else
		{
			//login.releaseDB();
			message=login.getMessage();
			response.sendRedirect("login.jsp");
		}
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