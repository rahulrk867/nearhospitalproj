package com.database.www;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;


public class DAO_impl implements DAO {

	Connection connection;
	Statement statement;
	
	DBConnection dbconnection;
	
	public DAO_impl(){
		dbconnection=new DBConnection();
		try {
			connection = dbconnection.getConnetion();
			statement = connection.createStatement();
			//System.out.println("Connection Established");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	@Override
	public void closeConnection() {

		try {
			if(statement!=null){
				statement.close();
			}
			if(connection!=null){
			connection.close();
			//System.out.println("COnnection closed...");
			}
			
		} catch (Exception e) {
			System.out.println("Exception while closing connection"+e.getMessage());
		}
	}

	@Override
	public ResultSet getData(String query) {

		try {
			return statement.executeQuery(query);
		} catch (Exception e) {
			System.out.println("Exception in getData() ->"+e.getMessage());
			return null;
		}

	}

	@Override
	public int putData(String query) {
		try {
			return statement.executeUpdate(query);
		} catch (Exception e) {
			System.out.println("Exception in putData() ->"+e.getMessage());
						return -1;
		}
		
	}

	@Override
	public boolean isExists(String query) {
		// TODO Auto-generated method stub
		boolean exists=false;
		try {
			ResultSet result= statement.executeQuery(query);
			exists=result.next();
		} catch (Exception e) {
			System.out.println("Exception in getData() ->"+e.getMessage());
			return true;
		}
		return exists;
	}
	
	
}

	


