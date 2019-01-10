package com.beans.hosp;

import java.sql.ResultSet;
import java.sql.SQLException;

import com.database.www.DAO;
import com.database.www.DAO_impl;

public class Hospital {
	private String hospitalName,address,latitude,longitude,phone,message,query;
	private int areaId,cityId,hospitalId,rows,departmentId[];
	private ResultSet resultSet;
	private DAO dao=new DAO_impl();
	private boolean saved;
	
	public void setAddress(String address) {
		this.address = address;
	}
	public void setAreaId(int areaId) {
		this.areaId = areaId;
	}
	public void setCityId(int cityId) {
		this.cityId = cityId;
	}
	public void setDepartmentId(int[] departmentId) {
		this.departmentId = departmentId;
	}
	public void setHospitalId(int hospitalId) {
		this.hospitalId = hospitalId;
	}
	public void setHospitalName(String hospitalName) {
		this.hospitalName = hospitalName;
	}
	public void setLatitude(String latitude) {
		this.latitude = latitude;
	}
	public void setLongitude(String longitude) {
		this.longitude = longitude;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public void setResultSet(ResultSet resultSet) {
		this.resultSet = resultSet;
	}
	public void setSaved(boolean saved) {
		this.saved = saved;
	}
	
	public String getAddress() {
		return address;
	}
	public int getAreaId() {
		return areaId;
	}
	public int getCityId() {
		return cityId;
	}
	public int[] getDepartmentId() {
		return departmentId;
	}
	public int getHospitalId() {
		return hospitalId;
	}
	public String getHospitalName() {
		return hospitalName;
	}
	public String getLatitude() {
		return latitude;
	}
	public String getLongitude() {
		return longitude;
	}
	public String getMessage() {
		return message;
	}
	public String getPhone() {
		return phone;
	}
	public ResultSet getResultSet() {
		return resultSet;
	}
	public boolean getSaved()
	{
		return saved;
	}
	
	public ResultSet selectCity()
	{
		query="select * from city";
		setResultSet(dao.getData(query));
		return getResultSet();
	}
	
	public ResultSet selectArea()
	{
		query="select * from area where cityId="+getCityId();
		setResultSet(dao.getData(query));
		return getResultSet();
	}
	
	public boolean saveHospital()
	{
		query="select * from hospital where hospitalName='"+getHospitalName()+"'";
		if(!dao.isExists(query))
		{
			try {
				String latlon[]=GetAddress.getLatLongPositions(getAddress());
				setLatitude(latlon[0]);
				setLongitude(latlon[1]);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			query="insert into hospital(hospitalName,address,areaId,latitude,longitude,phone) value('"
					+getHospitalName()+"','"+getAddress()+"',"+getAreaId()+",'"+getLatitude()+"','"
					+getLongitude()+"','"+getPhone()+"')";
			rows=dao.putData(query);
			if(rows>0)
			{
				setSaved(true);
				setMessage("Hospital Saved");
				
				query="select * from hospital order by hospitalId desc";
				resultSet=dao.getData(query);
				try {
					if(resultSet.next())
					{
						setHospitalId(resultSet.getInt("hospitalId"));
						int[] did=getDepartmentId();
						for(int id:did)
						{
							query="insert into hospitaldept(hospitalId,deptId) values("+getHospitalId()+","+id+")";
							rows=dao.putData(query);
							if(rows<1)
							{
								setMessage("Unable to Save Hospital...Try After Sometime");
								break;
							}
						}
					}
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			else
			{
				setSaved(false);
				setMessage("Hospital Not Saved");
			}
		}
		else {
				setSaved(false);
				setMessage("Hospital Already Exists");
		}
		return getSaved(); 
	}
	
	public boolean updateHospital()
	{
		
		if(deleteHospital()){
			if(saveHospital())
			{
				setMessage("Hospital Updated");
			}
		}
		return getSaved(); 
	}
	
	public boolean deleteHospital()
	{
			query="delete from hospital where hospitalId="+getHospitalId();
			rows=dao.putData(query);
			if(rows>0)
			{
				setSaved(true);
				setMessage("Hospital Deleted");
			}
			else
			{
				setSaved(false);
				setMessage("Hospital Not Deleted");
			}
		return getSaved(); 
	}
	
	public ResultSet selectDepartment()
	{
		query="select * from department";
		setResultSet(dao.getData(query));
		return getResultSet();
	}
	
	public ResultSet selectHospitals()
	{
		query="select * from hospital,area,city where hospital.areaId=area.areaId and area.cityId=city.cityId";
		setResultSet(dao.getData(query));
		return getResultSet();
	}
	
	public ResultSet getDepartment()
	{
		DAO dao = new DAO_impl();
		query="select * from department,hospitaldept where "
				+ "department.deptId=hospitaldept.deptId and hospitalId="+getHospitalId();
		setResultSet(dao.getData(query));
		return getResultSet();
	}
	
	public void getHospital(int id)
	{
		int tempId[] = null;
		query="select * from hospital,area,city where hospital.areaId=area.areaId and area.cityID=city.cityId and hospitalId="+id;
		System.out.println(query);
		ResultSet set=dao.getData(query);
		try {
			if(set.next())
			{
				setHospitalId(set.getInt("hospitalId"));
				setHospitalName(set.getString("hospitalName"));
				setAreaId(set.getInt("areaId"));
				setCityId(set.getInt("cityId"));
				setAddress(set.getString("address"));
				setPhone(set.getString("phone"));
				query="select deptId,count(hospDeptId) as c from hospitaldept where hospitalId="+id;
				ResultSet reSet=dao.getData(query);
				if(reSet.next())
				{
					tempId=new int[reSet.getInt("c")];
					int i=0;
					do {
						tempId[i]=reSet.getInt("deptId");
						i++;
					} while (reSet.next());
				}
				setDepartmentId(tempId);
			}
			else
			{
				setHospitalId(0);
				setHospitalName("");
				setAreaId(0);
				setCityId(0);
				setAddress("");
				setPhone("");
				setDepartmentId(tempId);
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
