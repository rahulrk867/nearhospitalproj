package com.beans.hosp;

import java.sql.ResultSet;
import java.sql.SQLException;

import com.database.www.DAO;
import com.database.www.DAO_impl;

public class Login {
	
	private String username,password;
	private boolean logedin;
	String query="",message="";
	ResultSet resultSet=null;
	DAO dao;
	
	public void setUsername(String username) {
		this.username = username;
	}
	
	public String getUsername() {
		return username;
	}
	
	public void setPassword(String password) {
		this.password = password;
	}
	
	public String getPassword() {
		return password;
	}
	
	public void setLogedin(boolean logedin) {
		this.logedin = logedin;
	}
	
	public boolean getLogedin() {
		return logedin;
	}
	
	public void setMessage(String message) {
		this.message = message;
	}
	
	public String getMessage() {
		return message;
	}
	
	public boolean isAdmin()
	{
		dao=new DAO_impl();
		query="select * from admin";
		resultSet=dao.getData(query);
		try {
			if(resultSet.next())
			{
				do{
					String dbadminId=resultSet.getString("adminId");
					String dbpassword=resultSet.getString("password");
					if(dbadminId.equalsIgnoreCase(getUsername())&&dbpassword.equals(getPassword()))
					{
						setLogedin(true);
						setMessage("");
					}
					else
					{
						setLogedin(false);
						setMessage("Invalid Username/Password");
					}
				}while(resultSet.next());
			}
			else
			{
				setLogedin(false);
				setMessage("AdminId and Password Not Found");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		releaseDB();
		return getLogedin();
	}
	
	public void releaseDB(){
		dao.closeConnection();
	}
}
