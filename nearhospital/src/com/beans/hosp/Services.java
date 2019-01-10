package com.beans.hosp;

import java.sql.ResultSet;
import java.sql.SQLException;

import com.database.www.DAO;
import com.database.www.DAO_impl;

public class Services {

	private String departmentName,serviceName,query,message;
	private int departmentId=0,serviceId=0,rows=0;
	private boolean saved;
	private ResultSet resultSet;
	
	private DAO dao=new DAO_impl();
	
	public void setDepartmentId(int departmentId) {
		this.departmentId = departmentId;
	}
	public void setDepartmentName(String departmentName) {
		this.departmentName = departmentName;
	}
	public void setServiceId(int serviceId) {
		this.serviceId = serviceId;
	}
	public void setServiceName(String serviceName) {
		this.serviceName = serviceName;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	public void setSaved(boolean saved) {
		this.saved = saved;
	}
	public void setResultSet(ResultSet resultSet) {
		this.resultSet = resultSet;
	}
	
	public int getDepartmentId() {
		return departmentId;
	}
	public String getDepartmentName() {
		return departmentName;
	}
	public int getServiceId() {
		return serviceId;
	}
	public String getServiceName() {
		return serviceName;
	}
	public boolean getSaved()
	{
		return saved;
	}
	public ResultSet getResultSet() {
		return resultSet;
	}
	public String getMessage() {
		return message;
	}
	
	public boolean saveService()
	{
		query="select * from services where service='"+getServiceName()+"' and deptId="+getDepartmentId();
		if(!dao.isExists(query))
		{
			query="insert into services(service,deptId) value('"+getServiceName()+"',"+getDepartmentId()+")";
			rows=dao.putData(query);
			if(rows>0)
			{
				setSaved(true);
				setMessage("Service Saved");
			}
			else
			{
				setSaved(false);
				setMessage("Service Not Saved");
			}
		}
		else {
				setSaved(false);
				setMessage("Service Name Already Exists");
		}
		return getSaved(); 
	}
	
	public boolean updateService()
	{
			query="update services set service='"
				+getServiceName()+"' where serviceId="+getServiceId();
			rows=dao.putData(query);
			if(rows>0)
			{
				setSaved(true);
				setMessage("Service Updated");
			}
			else
			{
				setSaved(false);
				setMessage("Service Not updated");
			}
		return getSaved(); 
	}
	
	public boolean deleteService()
	{
			query="delete from services where serviceId="+getServiceId();
			rows=dao.putData(query);
			if(rows>0)
			{
				setSaved(true);
				setMessage("Service Deleted");
			}
			else
			{
				setSaved(false);
				setMessage("Service Not Deleted");
			}
		return getSaved(); 
	}
	
	public ResultSet selectDepartment()
	{
		query="select * from department";
		setResultSet(dao.getData(query));
		return getResultSet();
	}
	
	public ResultSet selectservice(int departmentId)
	{
		query="select * from services,department where services.deptId=department.deptId and services.deptId="+departmentId;
		setResultSet(dao.getData(query));
		return getResultSet();
	}
	public void getService(int id)
	{
		query="select * from services,department where services.deptId=department.deptId and serviceId="+id;
		ResultSet set=dao.getData(query);
		try {
			if(set.next())
			{
				setDepartmentId(set.getInt("deptId"));
				setDepartmentName(set.getString("name"));
				setServiceId(set.getInt("serviceId"));
				setServiceName(set.getString("service"));
			}
			else
			{
				setDepartmentId(0);
				setDepartmentName("");
				setServiceId(0);
				setServiceName("");
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
