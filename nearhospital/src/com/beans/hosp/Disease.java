package com.beans.hosp;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.database.www.DAO;
import com.database.www.DAO_impl;

public class Disease {
	private String disease="",description="",homeremedies="",tests="",message="",command="";
	private int diseaseId = 0;
	private DAO dao;
	
	private String query = "";
	private int row = 0;
	public String getDisease() {
		return disease;
	}
	public void setDisease(String disease) {
		this.disease = disease;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getHomeremedies() {
		return homeremedies;
	}
	public void setHomeremedies(String homeremedies) {
		this.homeremedies = homeremedies;
	}
	public String getTests() {
		return tests;
	}
	public void setTests(String tests) {
		this.tests = tests;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	public int getDiseaseId() {
		return diseaseId;
	}
	public void setDiseaseId(int diseaseId) {
		this.diseaseId = diseaseId;
	}
	public String getCommand() {
		return command;
	}
	public void setCommand(String command) {
		this.command = command;
	}
	
	public void saveDisease()
	{
		dao=new DAO_impl();
		query="select * from disease where disease='"+getDisease()+"'";
		if(!dao.isExists(query))
		{
			query="insert into disease(disease,description,homeremedies,tests) value('"+getDisease()+"','"
					+getDescription()+"','"+getHomeremedies()+"','"+getTests()+"')";
			row=dao.putData(query);
			if(row>0)
			{
				setMessage("Disease Saved");
			}
			else
			{
				setMessage("Disease Not Saved");
			}
		}
		else {
				setMessage("Disease Already Exists");
		}
		releaseDB();
	}
	
	public void updateDisease()
	{
		dao=new DAO_impl();
			query="update disease set disease='"
				+getDisease()+"',description='"+getDescription()+"',homeremedies='"+getHomeremedies()+"',tests='"+getTests()+"' where diseaseId="+getDiseaseId();
			row=dao.putData(query);
			if(row>0)
			{
				setMessage("Disease Updated");
			}
			else
			{
				setMessage("Disease Not updated");
			}
			releaseDB();
	}
	
	public void deleteDisease()
	{
		dao=new DAO_impl();
			query="delete from diseasae where diseaseId="+getDiseaseId();
			row=dao.putData(query);
			if(row>0)
			{
				setMessage("Disease Deleted");
			}
			else
			{
				setMessage("Disease Not Deleted");
			}
			releaseDB();
	}
	
	public ArrayList<Disease> selectDisease()
	{
		dao=new DAO_impl();
		query="select * from disease";
		ResultSet resultSet = dao.getData(query);
		ArrayList<Disease> arrayList = new ArrayList<>();
		try {
			while(resultSet.next()){
				Disease disease = new Disease();
				disease.setDiseaseId(resultSet.getInt("diseaseId"));
				disease.setDisease(resultSet.getString("disease"));
				disease.setDescription(resultSet.getString("description"));
				disease.setHomeremedies(resultSet.getString("homeremedies"));
				disease.setTests(resultSet.getString("tests"));
				arrayList.add(disease);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		releaseDB();
		return arrayList;
	}
	
	public void getDisease(int id)
	{
		dao=new DAO_impl();
		query="select * from disease where diseaseId="+id;
		ResultSet set=dao.getData(query);
		try {
			if(set.next())
			{
				setDiseaseId(set.getInt("diseaseId"));
				setDisease(set.getString("disease"));
				setDescription(set.getString("description"));
				setHomeremedies(set.getString("homeremedies"));
				setTests(set.getString("tests"));
			}
			else
			{
				setDiseaseId(0);
				setDisease("");
				setDescription("");
				setHomeremedies("");
				setTests("");
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
