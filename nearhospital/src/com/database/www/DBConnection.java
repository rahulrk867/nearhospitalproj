package com.database.www;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {
	String driver="com.mysql.jdbc.Driver";
	String url="jdbc:mysql://localhost:3306/hospital";
	String user_name="root";	
	String password="root";
	public Connection getConnetion() throws Exception
	{
		Class.forName(driver);
		return DriverManager.getConnection(url,user_name,password);
	}
	

}
