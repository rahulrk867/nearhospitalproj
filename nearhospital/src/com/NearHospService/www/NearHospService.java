package com.NearHospService.www;

import java.sql.ResultSet;

import java.sql.SQLException;
import java.util.ArrayList;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import com.database.www.DAO;
import com.database.www.DAO_impl;

public class NearHospService {
	private String result="",query="";
	private int rows=0;
	private ResultSet resultSet=null;
	private DAO dao=null;
	
	public NearHospService()
	{
		dao=new DAO_impl();
	}
	public String register(String data){
		String response = "";
		JSONObject responseObject = new JSONObject();
		
		try {
			JSONObject dataObject = new JSONObject(data);
			
			String mailId = dataObject.getString("mailId");
			String query = "select * from member where mailId='"+mailId+"'";
			if(dao.isExists(query)){
				responseObject.put("error", 1);
				responseObject.put("message", "Mail Id Already Exists");
			}
			else{
				String citizenName = dataObject.getString("name");
				String address = dataObject.getString("address");
				String phone = dataObject.getString("phone");
				String password = dataObject.getString("password");
				query = "insert into member(memberName,address,phone,mailId,password) "
						+ "values('"+citizenName+"','"+address+"','"+phone+"','"+mailId+"','"+password+"')";
				int rows = dao.putData(query);
				if(rows > 0){
					responseObject.put("error", 0);
					query = "select * from member order by memberId desc";
					ResultSet resultSet = dao.getData(query);
					if(resultSet.next()){
						responseObject.put("memberId", resultSet.getInt("memberId"));
					}
				}
				else{
					responseObject.put("error", -1);
				}
			}
			response = responseObject.toString();
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			response = "\"error\":-1";
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println(response);
		return response;
	}
	
	public String login(String data){
		String response = "";
		System.out.println(data);
		JSONObject  responseObject = new JSONObject();
		try {
			JSONObject dataObject = new JSONObject(data);
			String mailId = dataObject.getString("mailId");
			String query = "select * from member where mailId='"+mailId+"'";
			ResultSet resultSet = dao.getData(query);
			if(resultSet.next()){
				String password = dataObject.getString("password");
				String dbpassword = resultSet.getString("password");
				if(password.equals(dbpassword)){
					responseObject.put("error",0);
					responseObject.put("memberId", resultSet.getInt("memberId"));
				}
				else{
					responseObject.put("error",1);
					responseObject.put("message","Invalid Password");
				}
			}
			else{
				responseObject.put("error",2);
				responseObject.put("message","Invalid Username");
			}
			response = responseObject.toString();
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			response = "\"error\":-1";
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			response = "\"error\":-1";
		}
		System.out.println(response);
		return response;
	}
	public String getDepartment()
	{
		result="";
		int deptId=0,serviceId=0;
		String deptName="",serviceName="";
		try {
			JSONObject jsonObject=new JSONObject();
			query="select * from department";
			resultSet=dao.getData(query);
			try {
				if(resultSet.next())
				{
					jsonObject.put("error", 0);
					JSONArray deptArray=new JSONArray();
					do{
						deptId=resultSet.getInt("deptId");
						deptName=resultSet.getString("name");
						JSONObject deptObject=new JSONObject();
						deptObject.put("deptId", deptId);
						deptObject.put("deptName", deptName);
						deptArray.put(deptObject);
					}while(resultSet.next());
					for(int i=0;i<deptArray.length();i++){
						JSONArray serviceArray=new JSONArray();
						query="select * from services where deptId="+deptArray.getJSONObject(i).getInt("deptId");
						ResultSet results=dao.getData(query);
						if(results.next())
						{
							do {
								serviceId = results.getInt("serviceId");
								serviceName = results.getString("service");
								JSONObject serviceObject = new JSONObject();
								serviceObject.put("serviceId", serviceId);
								serviceObject.put("serviceName", serviceName);
								serviceArray.put(serviceObject);
							} while (results.next());
							jsonObject.put(deptArray.getJSONObject(i).getString("deptName"), serviceArray);
						}
						else
						{
							JSONObject serviceObject = new JSONObject();
							serviceObject.put("serviceId", 0);
							serviceObject.put("serviceName", "Services Module under Process...");
							serviceArray.put(serviceObject);
							jsonObject.put(deptName, serviceArray);
						}
					}
					
					jsonObject.put("department", deptArray);
				}
				else
				{
					jsonObject.put("error", 1);
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				jsonObject.put("error", -1);
			}
			result=jsonObject.toString();
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			result="{\"error\":-1}";
		}
		return result;
	}
	
	public String getHospital(String data)
	{
		result="";
		int serviceId=0,hid=0,dist=0;
		String latitude="",longitude="",hname="";
		JSONObject jsonObject=new JSONObject();
		
		try {
			JSONObject dataObject=new JSONObject(data);
			serviceId=dataObject.getInt("serviceId");
			latitude=dataObject.getString("latitude");
			longitude=dataObject.getString("longitude");
			
			query="SELECT DISTINCT hospital.hospitalName,hospital.hospitalId,hospital.latitude"
				+ ",hospital.longitude,111.045* DEGREES(ACOS(COS(RADIANS("+latitude
				+ "))* COS(RADIANS(latitude))* COS(RADIANS("+longitude+") - RADIANS(longitude))"
                + "+ SIN(RADIANS("+latitude+"))* SIN(RADIANS(latitude)))) AS distance_in_km FROM "
				+ "hospital,hospitalserv where serviceId="+serviceId+" and "
				+ "hospital.hospitalId=hospitalserv.hospitalId having distance_in_km<5 "
				+ "order by distance_in_km asc";
			resultSet=dao.getData(query);
			try {
				if(resultSet.next())
				{
					jsonObject.put("error", 0);
					JSONArray array=new JSONArray();
					do{
						hname=resultSet.getString("hospitalName");
						hid=resultSet.getInt("hospitalId");
						dist=resultSet.getInt("distance_in_km");
						
						JSONObject object=new JSONObject();
						object.put("hname", hname);
						object.put("hospitalId", hid);
						object.put("distance", dist);
						array.put(object);
					}while(resultSet.next());
					jsonObject.put("hospitals", array);
				}
				else{
					jsonObject.put("error", 1);
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				jsonObject.put("error", -1);
			}
			result=jsonObject.toString();
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			result="{\"error\":-1}";
		}
		return result;
	}
	
	public String getDetails(String data)
	{
		result="";
		String hname="",address="",phone="",latitude="",longitude="";
		int hid=0;
		JSONObject jsonObject=new JSONObject();
		try {
			JSONObject dataObject=new JSONObject(data);
			hid=dataObject.getInt("hospitalId");
			query="select * from hospital,area,city where hospitalId="+hid
					+" and hospital.areaId=area.areaId and area.cityId=city.cityId";
			resultSet=dao.getData(query);
			try {
				if(resultSet.next())
				{
					hname=resultSet.getString("hospitalName");
					address=resultSet.getString("address")
							+resultSet.getString("areaName")+"\n"
							+resultSet.getString("cityName")+"\n";
					phone=resultSet.getString("phone");
					latitude=resultSet.getString("latitude");
					longitude=resultSet.getString("longitude");
					
					jsonObject.put("error", 0);
					jsonObject.put("hname", hname);
					jsonObject.put("address", address);
					jsonObject.put("phone", phone);
					jsonObject.put("latitude", latitude);
					jsonObject.put("longitude", longitude);
				}
				else
				{
					jsonObject.put("error", 1);
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				jsonObject.put("error", -1);
			}
			result=jsonObject.toString();
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			result="{\"error\":-1}";
		}
		return result;
	}
	
	public String getSymptoms(){
		String result = "";
		
		query = "select * from symptom";
		resultSet = dao.getData(query);
		JSONArray array = new JSONArray();
		try {
			while(resultSet.next()){
				JSONObject jsonObject = new JSONObject();
				jsonObject.put("symptom", resultSet.getString("symptom"));
				jsonObject.put("symptomId", resultSet.getString("symptomsId"));
				array.put(jsonObject);
			}
			result = array.toString();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println(result);
		return result;
	}
	
	public String getDiseases(String data){
		String result = "";
		
		System.out.println(data);
		try {
			JSONArray dataarray = new JSONArray(data);
			String symptomId="symptomId="+dataarray.getJSONObject(0).getInt("symptomId");
			for(int i =1;i<dataarray.length();i++){
				symptomId+=" or symptomId="+dataarray.getJSONObject(i).getInt("symptomId");
			}
			ArrayList<Integer> diseaseList = new ArrayList<>();
			query = "select * from disease";
			resultSet = dao.getData(query);
			JSONArray array = new JSONArray();
			while (resultSet.next()) {
				diseaseList.add(resultSet.getInt("diseaseId"));				
			}
			for(int id : diseaseList){
				query = "select * from diseasesymptom where diseaseId = "+id;
				ArrayList<Integer> arrayList = new ArrayList<>();
				resultSet = dao.getData(query);
				while (resultSet.next()) {
					arrayList.add(resultSet.getInt("symptomId"));				
				}
				System.out.println(arrayList);
				int count = 0;
				for(int i =0;i<dataarray.length();i++){
					int sid = dataarray.getJSONObject(i).getInt("symptomId");
					if(arrayList.contains(sid)){
						count++;
					}
				}
				System.out.println(count);
				if(count >=(dataarray.length()*0.75)){
					query = "select  * from disease where diseaseId="+id;
					resultSet = dao.getData(query);
					
					while(resultSet.next()){
						JSONObject jsonObject = new JSONObject();
						jsonObject.put("disease", resultSet.getString("disease"));
						jsonObject.put("diseaseId", resultSet.getString("diseaseId"));
						array.put(jsonObject);
					}
				}
			}
			/*query = "SELECT DISTINCT diseasesymptom.diseaseId,disease FROM diseasesymptom INNER JOIN disease ON disease.diseaseId=diseasesymptom.diseaseId WHERE "+symptomId;
			System.out.println(query);
			*/
			result = array.toString();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println("rerer "+result);
		return result;
	}
	
	public String getDiseaseDetails(int diseaseId){
		String result = "";
		
		System.out.println(diseaseId);
		try {
			query = "SELECT * FROM disease  WHERE diseaseId="+diseaseId;
			System.out.println(query);
			resultSet = dao.getData(query);
			JSONObject jsonObject = new JSONObject();
			while(resultSet.next()){
				jsonObject.put("description", resultSet.getString("description"));
				jsonObject.put("remedies", resultSet.getString("homeremedies"));
				jsonObject.put("tests", resultSet.getString("tests"));
			}
			result = jsonObject.toString();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println("Disease Details "+result);
		return result;
	}
	
	public String getServices(){
		String result = "";
		
		query = "SELECT * FROM department INNER JOIN services ON services.deptId=department.deptId WHERE NAME='emergency'";
		resultSet = dao.getData(query);
		JSONArray array = new JSONArray();
		try {
			while(resultSet.next()){
				JSONObject jsonObject = new JSONObject();
				jsonObject.put("service", resultSet.getString("service"));
				jsonObject.put("serviceId", resultSet.getString("serviceId"));
				array.put(jsonObject);
			}
			result = array.toString();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println(result);
		return result;
	}
}
