package com.beans.hosp;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.database.www.DAO;
import com.database.www.DAO_impl;

public class DiseaseSymptom {
	private int diseaseId,symptomId[];
	private String message = "",command="";
	public int getDiseaseId() {
		return diseaseId;
	}

	public void setDiseaseId(int diseaseId) {
		this.diseaseId = diseaseId;
	}

	public int[] getSymptomId() {
		return symptomId;
	}

	public void setSymptomId(int[] symptomId) {
		this.symptomId = symptomId;
	}
	
	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public void saveSymptoms(){
		DAO dao = new DAO_impl();
		for(int i = 0;i<getSymptomId().length;i++){
		String query = "select * from diseasesymptom where diseaseId="+getDiseaseId()
					+" and symptomId="+getSymptomId()[i];	
		ResultSet resultSet= dao.getData(query);
		 try {
			if(!resultSet.next()){
				 query = "insert into diseasesymptom(diseaseId,symptomId) "
							+ "values("+getDiseaseId()+","+getSymptomId()[i]+")";
					if(dao.putData(query)>0){
						setMessage("Saved");
					}
					else{
						setMessage("Unable to Save");
					}
			 }
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		}
		dao.closeConnection();
	}
	
	public ArrayList<Symptoms> selectSymptom()
	{
		DAO dao=new DAO_impl();
		String query="select * from symptom";
		ResultSet resultSet=dao.getData(query);
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
		dao.closeConnection();
		return arrayList;
	}
	
	public ArrayList<Disease> selectDisease()
	{
		DAO dao=new DAO_impl();
		String query="select * from disease";
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
		dao.closeConnection();
		return arrayList;
	}
	
	public ArrayList<Integer> getDiseaseSymptom(){
		DAO dao = new DAO_impl();
		ArrayList<Integer> arrayList = new ArrayList<>();
		String query = "select * from diseasesymptom where diseaseId = "+getDiseaseId();
		ResultSet resultSet = dao.getData(query);
		try {
			if(resultSet.next()){
				setCommand("Update");
				do{
					arrayList.add(resultSet.getInt("symptomId"));
				}while(resultSet.next());
			}
			else{
				setCommand("Save");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return arrayList;
	}

	public String getCommand() {
		return command;
	}

	public void setCommand(String command) {
		this.command = command;
	}
}
