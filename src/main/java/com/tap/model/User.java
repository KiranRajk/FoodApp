package com.tap.model;

import java.sql.Timestamp;

public class User {

	private int id;
	private String name;
	private String email;
	private String password;
	private String phone;
	private String address;
	private String role;
	private Timestamp createdDate;
	private Timestamp lastLoginDate;
	
	public User() {
		
	}

	public User(String name, String email, String password, String phone, String address, String role, Timestamp createdDate,
			Timestamp lastLoginDate) {
		super();
		this.name = name;
		this.email = email;
		this.password = password;
		this.phone = phone;
		this.address = address;
		this.role = role;
		this.createdDate = createdDate;
		this.lastLoginDate = lastLoginDate;
	}

	public User(int id, String name, String email, String password, String phone, String address, String role,
			Timestamp createdDate, Timestamp lastLoginDate) {
		super();
		this.id = id;
		this.name = name;
		this.email = email;
		this.password = password;
		this.phone = phone;
		this.address = address;
		this.role = role;
		this.createdDate = createdDate;
		this.lastLoginDate = lastLoginDate;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}

	public Timestamp getCreatedDate() {
		return createdDate;
	}

	public void setCreatedDate(Timestamp createdDate) {
		this.createdDate = createdDate;
	}

	public Timestamp getLastLoginDate() {
		return lastLoginDate;
	}

	public void setLastLoginDate(Timestamp lastLoginDate) {
		this.lastLoginDate = lastLoginDate;
	}

//	

	public String getPhone() {
		return phone;
	}


	public void setPhone(String phone) {
		this.phone = phone;
	}
	
	@Override
	public String toString() {
		return "User [userId=" + id + ", name=" + name + ", email=" + email + ", password=" + password + ", phone="
				+ phone + ", address=" + address + ", role=" + role + ", createdDate=" + createdDate
				+ ", lastLoginDate=" + lastLoginDate + "]";
	}

	
	

}
