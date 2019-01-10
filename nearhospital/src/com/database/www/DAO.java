package com.database.www;

import java.sql.ResultSet;

public interface DAO {
	public int putData(String query);
	public ResultSet getData(String query);
	public void closeConnection();
	public boolean isExists(String query);
}
