package com.beans.hosp;

import java.sql.ResultSet;
import java.sql.SQLException;

import com.database.www.DAO;
import com.database.www.DAO_impl;

public class Hservice {
	private int hospitalId,departmentId,rows,serviceId[],hospServId,cityId;
	private String hospitalName,departmentName,query,message;
	private DAO dao=new DAO_impl();
	private boolean saved;
	
	public void setCityId(int cityId) {
		this.cityId = cityId;
	}
	public void setDepartmentId(int departmentId) {
		this.departmentId = departmentId;
	}
	public void setDepartmentName(String departmentName) {
		this.departmentName = departmentName;
	}
	public void setHospitalId(int hospitalId) {
		this.hospitalId = hospitalId;
	}
	public void setHospitalName(String hospitalName) {
		this.hospitalName = hospitalName;
	}
	public void setHospServId(int hospServId) {
		this.hospServId = hospServId;
	}
	public void setServiceId(int[] serviceId) {
		this.serviceId = serviceId;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	public void setSaved(boolean saved) {
		this.saved = saved;
	}
	
	public int getCityId() {
		return cityId;
	}
	public int getDepartmentId() {
		return departmentId;
	}
	public String getDepartmentName() {
		return departmentName;
	}
	public int getHospitalId() {
		return hospitalId;
	}
	public String getHospitalName() {
		return hospitalName;
	}
	public int getHospServId() {
		return hospServId;
	}
	public String getMessage() {
		return message;
	}
	public int[] getServiceId() {
		return serviceId;
	}
	public boolean getSaved()
	{
		return saved;
	}
	
	public boolean saveHservice()
	{
		for(int id:getServiceId())
		{
		query="select * from hospitalserv where hospitalId="+getHospitalId()
			+" and serviceId="+id;
		if(!dao.isExists(query))
		{
			
				query="insert into hospitalserv(hospitalId,serviceId) value("+getHospitalId()+","+id+")";
				rows=dao.putData(query);
				if(rows>0)
				{
					setSaved(true);
				}
				else
				{
					setSaved(false);
					setMessage("Hospital Service not saved");
					break;
				}
			}
			if(getSaved())
			{
				setMessage("Hospital Service Saved");
			}
			else {
				setSaved(false);
				setMessage("Hospital Service Already Exists");
		}
		}
		
		return getSaved(); 
	}
	
	public boolean updateHservice()
	{
		query="delete from hospitalserv where hospitalId="+getHospitalId();
		rows=dao.putData(query);
		for(int id:getServiceId())
		{
			query="insert into hospitalserv(hospitalId,serviceId) value("+getHospitalId()+","+id+")";
			rows=dao.putData(query);
			if(rows>0)
			{
				setSaved(true);
			}
			else
			{
				setSaved(false);
				setMessage("Hospital Service not Updated");
				break;
			}
		}
		if(getSaved())
		{
			setMessage("Hospital Service Not Updated");
		}
		return getSaved(); 
	}
	
	public boolean deleteHservice()
	{
			query="delete from hospitalserv where hospServId="+getHospServId();
			rows=dao.putData(query);
			if(rows>0)
			{
				setSaved(true);
				setMessage("Hospital Service Deleted");
			}
			else
			{
				setSaved(false);
				setMessage("Hospital Service Not Deleted");
			}
		return getSaved(); 
	}
	
	public ResultSet selectCity()
	{
		query="select * from city";
		return dao.getData(query);
	}
	
	public ResultSet selectHospital()
	{
		query="select * from hospital,area,city where area.areaId=hospital.areaId and "
				+ "city.cityId=area.cityId and city.cityId="+getCityId();
		return dao.getData(query);
	}
	
	public ResultSet selectDepartment()
	{
		query="select * from hospitaldept,department where department.deptId=hospitaldept.deptId"
				+ " and hospitalId="+getHospitalId();
		return dao.getData(query);
	}
	public ResultSet selectService()
	{
		query="select * from services where deptId="+getDepartmentId();
		return dao.getData(query);
	}
	public ResultSet getService()
	{
		query="select * from hospitalserv,services where hospitalId="+getHospitalId()
			+" and hospitalserv.serviceId=services.serviceId";
		return dao.getData(query);
	}
	
	public void releaseDB(){
		dao.closeConnection();
	}
}
