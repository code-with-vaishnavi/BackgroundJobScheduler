package com.vaishnavi.test;

import com.vaishnavi.dao.UserDAO;
import com.vaishnavi.model.User;

public class TestLogin {

    public static void main(String[] args) {

        UserDAO dao = new UserDAO();

        User user = dao.loginUser("jayesh@gmail.com", "jayesh123");

        if (user != null) {

            System.out.println("=================================");
            System.out.println("Login Successful");
            System.out.println("Welcome : " + user.getFullName());
            System.out.println("Email   : " + user.getEmail());
            System.out.println("Role    : " + user.getRole());
            System.out.println("=================================");

        } else {

            System.out.println("Invalid Email or Password");

        }
    }
}