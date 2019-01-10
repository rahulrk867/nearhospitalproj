package com.beans.hosp;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.database.www.DAO;
import com.database.www.DAO_impl;

public class City {
	
	private String cityName,query,message;
	private int cityId=0,rows=0;
	private boolean saved;
	private ResultSet resultSet;
	
	private DAO dao;

	public void setCityId(int cityId) {
		this.cityId = cityId;
	}
	public void setCityName(String cityName) {
		this.cityName = cityName;
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
	
	public boolean saveCity()
	{
		dao=new DAO_impl();
		query="select * from city where cityName='"+getCityName()+"'";
		if(!dao.isExists(query))
		{
			query="insert into city(cityName) value('"+getCityName()+"')";
			rows=dao.putData(query);
			if(rows>0)
			{
				setSaved(true);
				setMessage("City Saved");
			}
			else
			{
				setSaved(false);
				setMessage("City Not Saved");
			}
		}
		else {
				setSaved(false);
				setMessage("City Name Already Exists");
		}
		releaseDB();
		return getSaved(); 
	}
	
	public boolean updateCity()
	{
		dao=new DAO_impl();
			query="update city set cityName='"
				+getCityName()+"' where cityId="+getCityId();
			rows=dao.putData(query);
			if(rows>0)
			{
				setSaved(true);
				setMessage("City Updated");
			}
			else
			{
				setSaved(false);
				setMessage("City Not updated");
			}
			releaseDB();
		return getSaved(); 
	}
	
	public boolean deleteCity()
	{
		dao=new DAO_impl();
			query="delete from city where cityId="+getCityId();
			rows=dao.putData(query);
			if(rows>0)
			{
				setSaved(true);
				setMessage("City Deleted");
			}
			else
			{
				setSaved(false);
				setMessage("City Not Deleted");
			}
			releaseDB();
		return getSaved(); 
	}
	
	public ArrayList<City> selectCity()
	{
		dao=new DAO_impl();
		query="select * from city";
		setResultSet(dao.getData(query));
		ArrayList<City> arrayList = new ArrayList<>();
		try {
			while(resultSet.next()){
				City city = new City();
				city.setCityId(resultSet.getInt("cityId"));
				city.setCityName(resultSet.getString("cityName"));
				arrayList.add(city);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		releaseDB();
		return arrayList;
	}
	
	public void getCity(int id)
	{
		dao=new DAO_impl();
		query="select * from city where cityId="+id;
		ResultSet set=dao.getData(query);
		try {
			if(set.next())
			{
				setCityId(set.getInt("cityId"));
				setCityName(set.getString("cityName"));
			}
			else
			{
				setCityId(0);
				setCityName("");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		releaseDB();
	}
	public void releaseDB(){
		dao.closeConnection();
	}
}
