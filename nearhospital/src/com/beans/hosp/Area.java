package com.beans.hosp;

import java.sql.ResultSet;
import java.sql.SQLException;

import com.database.www.DAO;
import com.database.www.DAO_impl;

public class Area {

	private String cityName,areaName,query,message;
	private int areaId=0,cityId=0,rows=0;
	private boolean saved;
	private ResultSet resultSet;
	
	private DAO dao=new DAO_impl();

	public void setCityId(int cityId) {
		this.cityId = cityId;
	}
	public void setCityName(String cityName) {
		this.cityName = cityName;
	}
	public void setAreaId(int areaId) {
		this.areaId = areaId;
	}
	public void setareaName(String areaName) {
		this.areaName = areaName;
	}
	public void setResultSet(ResultSet resultSet) {
		this.resultSet = resultSet;
	}
	public void setSaved(boolean saved) {
		this.saved = saved;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	
	public int getCityId() {
		return cityId;
	}
	public String getCityName() {
		return cityName;
	}
	public int getAreaId() {
		return areaId;
	}
	public String getareaName() {
		return areaName;
	}
	public ResultSet getResultSet() {
		return resultSet;
	}
	public boolean getSaved()
	{
		return saved;
	}
	public String getMessage() {
		return message;
	}
	
	public boolean saveArea()
	{
		query="select * from area where areaName='"+getareaName()+"' and cityID="+getCityId();
		if(!dao.isExists(query))
		{
			query="insert into area(areaName,cityID) value('"+getareaName()+"',"+getCityId()+")";
			rows=dao.putData(query);
			if(rows>0)
			{
				setSaved(true);
				setMessage("Area Saved");
			}
			else
			{
				setSaved(false);
				setMessage("Area Not Saved");
			}
		}
		else {
				setSaved(false);
				setMessage("Area Name Already Exists");
		}
		return getSaved(); 
	}
	
	public boolean updateArea()
	{
			query="update area set areaName='"
				+getareaName()+"' where areaId="+getAreaId();
			rows=dao.putData(query);
			if(rows>0)
			{
				setSaved(true);
				setMessage("Area Updated");
			}
			else
			{
				setSaved(false);
				setMessage("Area Not updated");
			}
		return getSaved(); 
	}
	
	public boolean deleteArea()
	{
			query="delete from area where areaId="+getAreaId();
			rows=dao.putData(query);
			if(rows>0)
			{
				setSaved(true);
				setMessage("Area Deleted");
			}
			else
			{
				setSaved(false);
				setMessage("Area Not Deleted");
			}
		return getSaved(); 
	}
	
	public ResultSet selectCity()
	{
		query="select * from city";
		setResultSet(dao.getData(query));
		return getResultSet();
	}
	
	public ResultSet selectarea(int cityId)
	{
		query="select * from area,city where area.cityId=city.cityId and area.cityId="+cityId;
		setResultSet(dao.getData(query));
		return getResultSet();
	}
	public void getArea(int id)
	{
		query="select * from area,city where area.cityID=city.cityId and areaId="+id;
		ResultSet set=dao.getData(query);
		try {
			if(set.next())
			{
				setCityId(set.getInt("cityId"));
				setCityName(set.getString("cityName"));
				setAreaId(set.getInt("areaId"));
				setareaName(set.getString("areaName"));
			}
			else
			{
				setAreaId(0);
				setareaName("");
				setCityId(0);
				setCityName("");
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
