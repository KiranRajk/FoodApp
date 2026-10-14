package com.tap.util;

import java.util.List;
import java.util.Scanner;

import com.tap.DaoImpl.UserDaoImpl;
import com.tap.model.User;



public class App {

	public static void main(String[] args) {
		
		Scanner scan  = new Scanner(System.in);
		
	//ADD USER
//		System.out.println("Enter the Name: ");
//		String name = scan.next();
//		System.out.println("Enter the email: ");
//		String email = scan.next();
//		System.out.println("Enter the Password: ");
//		String password = scan.next();
//		System.out.println("Enter the Phone Number: ");
//		String phone = scan.next();
//		System.out.println("Enter the Address: ");
//		String address = scan.next();
//		System.out.println("Enter the role: ");
//		String role = scan.next();
//		
//		User u1 = new User(name, email, password, phone, address, role, null, null);
//		UserDAOImpl u =new UserDAOImpl();
//		
// 
//		 u.addUser(u1);
		
	//GET ALL USERS
		UserDaoImpl u =new UserDaoImpl();
		List<User> allUser =u.getAllUsers();
		
		for (User user : allUser) {
			System.out.println(user);
		}
		
	//Update User Details
//		 UserDAOImpl u =new UserDAOImpl();
//		 User user1 = u.getUser(1);
//		 System.out.println(user1.getEmail());
//		 
//		 user1.setEmail("ajay123@gmail.com");
//		 System.out.println(user1.getEmail());
//		 
//		 u.updateUser(user1);
//		 System.out.println("Updated");
		 
		 
		 
//		 User user = u.getUser(1);
//		 
//		 System.out.println(user);
		
	//DELETE USER
//		UserDAOImpl u =new UserDAOImpl();
//		u.deleteUser(1);
//		System.out.println("DELETED");
		

	}

}
