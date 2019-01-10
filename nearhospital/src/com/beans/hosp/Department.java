package com.beans.hosp;

import java.sql.ResultSet;
import java.sql.SQLException;

import com.database.www.DAO;
import com.database.www.DAO_impl;

public class Department {
	private int departmentId,rows;
	private String departmentName,query,message;
	private ResultSet resultSet;
	private DAO dao=new DAO_impl();
	private boolean saved;
	
	public void setDepartmentId(int departmentId) {
		this.departmentId = departmentId;
	}
	public void setDepartmentName(String departmentName) {
		this.departmentName = departmentName;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	public void setSaved(boolean saved) {
		this.saved = saved;
	}
	
	public int getDepartmentId() {
		return departmentId;
	}
	public String getDepartmentName() {
		return departmentName;
	}
	public String getMessage() {
		return message;
	}
	public boolean getSaved() {
		// TODO Auto-generated method stub
		return saved;
	}
	
	public boolean saveDept()
	{
		query="select * from department where name='"+getDepartmentName()+"'";
		if(!dao.isExists(query))
		{
			query="insert into department(name) value('"+getDepartmentName()+"')";
			rows=dao.putData(query);
			if(rows>0)
			{
				setSaved(true);
				setMessage("Department Saved");
			}
			else
			{
				setSaved(false);
				setMessage("Department Not Saved");
			}
		}
		else {
				setSaved(false);
				setMessage("Department Name Already Exists");
		}
		return getSaved(); 
	}
	
	public boolean updateDept()
	{
			query="update department set name='"
				+getDepartmentName()+"' where deptId="+getDepartmentId();
			rows=dao.putData(query);
			if(rows>0)
			{
				setSaved(true);
				setMessage("Department Updated");
			}
			else
			{
				setSaved(false);
				setMessage("Department Not updated");
			}
		return getSaved(); 
	}
	
	public boolean deleteDept()
	{
			query="delete from department where deptId="+getDepartmentId();
			rows=dao.putData(query);
			if(rows>0)
			{
				setSaved(true);
				setMessage("Department Deleted");
			}
			else
			{
				setSaved(false);
				setMessage("Department Not Deleted");
			}
		return getSaved(); 
	}
	
	public ResultSet selectDept()
	{
		query="select * from department";
		resultSet=dao.getData(query);
		return resultSet;
	}
	
	public void getDept(int id)
	{
		query="select * from department where deptId="+id;
		ResultSet set=dao.getData(query);
		try {
			if(set.next())
			{
				setDepartmentId(set.getInt("deptId"));
				setDepartmentName(set.getString("name"));
			}
			else
			{
				setDepartmentId(0);
				setDepartmentName("");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public void releaseDB(){
		dao.closeConnection();
	}
}
