package com.tap.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
	private static final String URL =  System.getenv("FOODAPP_DB_URL");
	private static final String USERNAME = System.getenv("FOODAPP_DB_USERNAME");;
	private static final String PASSWORD =  System.getenv("FOODAPP_DB_PASSWORD");
	
	private static Connection connection;
	
	

	
	public static Connection getConnection(){
		
		if (URL == null || USERNAME == null || PASSWORD == null) {
		    throw new IllegalStateException(
		        "Database environment variables are not configured."
		    );
		}
		
		try{
			Class.forName("com.mysql.cj.jdbc.Driver");
			
			connection = DriverManager.getConnection(URL, USERNAME, PASSWORD);
			System.out.println("Connection is established");
			
		} catch(ClassNotFoundException e) {
			e.printStackTrace();
		} catch(SQLException e) {
			e.printStackTrace();
		}
		return connection;
	}

}
