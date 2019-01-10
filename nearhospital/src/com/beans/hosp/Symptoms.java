package com.beans.hosp;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.database.www.DAO;
import com.database.www.DAO_impl;

public class Symptoms {
	private String symptom,query,message;
	private int symptomId=0,rows=0;
	private boolean saved;
	private ResultSet resultSet;
	
	private DAO dao;

	public void setSymptomId(int cityId) {
		this.symptomId = cityId;
	}
	public void setSymptom(String cityName) {
		this.symptom = cityName;
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
	
	public int getSymptomId() {
		return symptomId;
	}
	public String getSymptom() {
		return symptom;
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
	
	public boolean saveSymptom()
	{
		dao=new DAO_impl();
		query="select * from symptom where symptom='"+getSymptom()+"'";
		if(!dao.isExists(query))
		{
			query="insert into symptom(symptom) value('"+getSymptom()+"')";
			rows=dao.putData(query);
			if(rows>0)
			{
				setSaved(true);
				setMessage("Symptom Saved");
			}
			else
			{
				setSaved(false);
				setMessage("Symptom Not Saved");
			}
		}
		else {
				setSaved(false);
				setMessage("Symptom Already Exists");
		}
		releaseDB();
		return getSaved(); 
	}
	
	public boolean updateSymptom()
	{
		dao=new DAO_impl();
			query="update symptom set symptom='"
				+getSymptom()+"' where symptomsId="+getSymptomId();
			rows=dao.putData(query);
			if(rows>0)
			{
				setSaved(true);
				setMessage("Symptom Updated");
			}
			else
			{
				setSaved(false);
				setMessage("Symptom Not updated");
			}
			releaseDB();
		return getSaved(); 
	}
	
	public boolean deleteSymptom()
	{
		dao=new DAO_impl();
			query="delete from symptom where symptomsId="+getSymptomId();
			rows=dao.putData(query);
			if(rows>0)
			{
				setSaved(true);
				setMessage("Symptom Deleted");
			}
			else
			{
				setSaved(false);
				setMessage("Symptom Not Deleted");
			}
			releaseDB();
		return getSaved(); 
	}
	
	public ArrayList<Symptoms> selectSymptom()
	{
		dao=new DAO_impl();
		query="select * from symptom";
		setResultSet(dao.getData(query));
		ArrayList<Symptoms> arrayList = new ArrayList<>();
		try {
			while(resultSet.next()){
				Symptoms symptoms = new Symptoms();
				symptoms.setSymptomId(resultSet.getInt("symptomsId"));
				symptoms.setSymptom(resultSet.getString("symptom"));
				arrayList.add(symptoms);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		releaseDB();
		return arrayList;
	}
	
	public void getSymptom(int id)
	{
		dao=new DAO_impl();
		query="select * from symptom where symptomsId="+id;
		ResultSet set=dao.getData(query);
		try {
			if(set.next())
			{
				setSymptomId(set.getInt("symptomsId"));
				setSymptom(set.getString("symptom"));
			}
			else
			{
				setSymptomId(0);
				setSymptom("");
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
