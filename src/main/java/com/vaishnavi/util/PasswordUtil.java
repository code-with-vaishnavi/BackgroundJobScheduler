package com.vaishnavi.util;

import org.mindrot.jbcrypt.BCrypt;

public class PasswordUtil {

    // Hash a plain-text password
    public static String hashPassword(String password) {
        return BCrypt.hashpw(password, BCrypt.gensalt(12));
    }

    // Verify a password against its BCrypt hash
    public static boolean checkPassword(
            String password,
            String hashedPassword) {

        return BCrypt.checkpw(password, hashedPassword);
    }
}