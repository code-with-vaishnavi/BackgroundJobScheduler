package com.vaishnavi.test;

import com.vaishnavi.dao.UserDAO;
import com.vaishnavi.model.User;

public class TestRegister {

    public static void main(String[] args) {

        User user = new User();

        user.setFullName("Jayesh");
        user.setEmail("jayesh@gmail.com");
        user.setPassword("jayesh123");
        user.setRole("ADMIN");

        UserDAO dao = new UserDAO();

        if (dao.registerUser(user)) {

            System.out.println("User Registered Successfully!");

        } else {

            System.out.println("Registration Failed!");

        }

    }

}