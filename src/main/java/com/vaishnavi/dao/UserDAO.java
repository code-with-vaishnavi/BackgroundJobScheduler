package com.vaishnavi.dao;

import com.vaishnavi.util.DBConnection;
import com.vaishnavi.model.User;
import com.vaishnavi.util.PasswordUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {

    // ==================================================
    // REGISTER USER
    // ==================================================

    public boolean registerUser(User user) {

        boolean status = false;

        String sql =
                "INSERT INTO users(full_name,email,password,role) " +
                        "VALUES(?,?,?,?)";

        try {

            Connection con = DBConnection.getConnection();

            PreparedStatement ps =
                    con.prepareStatement(sql);

            ps.setString(
                    1,
                    user.getFullName()
            );

            ps.setString(
                    2,
                    user.getEmail()
            );

            // Hash password before storing
            String hashedPassword =
                    PasswordUtil.hashPassword(
                            user.getPassword()
                    );

            ps.setString(
                    3,
                    hashedPassword
            );

            ps.setString(
                    4,
                    user.getRole()
            );

            int rows =
                    ps.executeUpdate();

            if (rows > 0) {
                status = true;
            }

            ps.close();
            con.close();

        } catch (Exception e) {

            e.printStackTrace();
        }

        return status;
    }


    // ==================================================
    // LOGIN USER
    // ==================================================

    public User loginUser(
            String email,
            String password) {

        User user = null;

        String sql =
                "SELECT * FROM users WHERE email=?";

        try {

            Connection con =
                    DBConnection.getConnection();

            PreparedStatement ps =
                    con.prepareStatement(sql);

            ps.setString(
                    1,
                    email
            );

            ResultSet rs =
                    ps.executeQuery();

            if (rs.next()) {

                String storedHash =
                        rs.getString("password");

                // Verify entered password
                // against BCrypt hash
                if (PasswordUtil.checkPassword(
                        password,
                        storedHash
                )) {

                    user = new User();

                    user.setUserId(
                            rs.getInt("user_id")
                    );

                    user.setFullName(
                            rs.getString("full_name")
                    );

                    user.setEmail(
                            rs.getString("email")
                    );

                    // Do not expose the password
                    user.setPassword(null);

                    user.setRole(
                            rs.getString("role")
                    );
                }
            }

            rs.close();
            ps.close();
            con.close();

        } catch (Exception e) {

            e.printStackTrace();
        }

        return user;
    }


    // ==================================================
    // GET TOTAL USERS
    // ==================================================

    public int getTotalUsers() {

        int totalUsers = 0;

        String sql =
                "SELECT COUNT(*) FROM users";

        try {

            Connection con =
                    DBConnection.getConnection();

            PreparedStatement ps =
                    con.prepareStatement(sql);

            ResultSet rs =
                    ps.executeQuery();

            if (rs.next()) {

                totalUsers =
                        rs.getInt(1);
            }

            rs.close();
            ps.close();
            con.close();

        } catch (Exception e) {

            e.printStackTrace();
        }

        return totalUsers;
    }


    // ==================================================
    // GET ALL USERS
    // ==================================================

    public List<User> getAllUsers() {

        List<User> users =
                new ArrayList<>();

        String sql =
                "SELECT * FROM users ORDER BY user_id";

        try {

            Connection con =
                    DBConnection.getConnection();

            PreparedStatement ps =
                    con.prepareStatement(sql);

            ResultSet rs =
                    ps.executeQuery();

            while (rs.next()) {

                User user =
                        new User();

                user.setUserId(
                        rs.getInt("user_id")
                );

                user.setFullName(
                        rs.getString("full_name")
                );

                user.setEmail(
                        rs.getString("email")
                );

                // Do not load password
                user.setPassword(null);

                user.setRole(
                        rs.getString("role")
                );

                users.add(user);
            }

            rs.close();
            ps.close();
            con.close();

        } catch (Exception e) {

            e.printStackTrace();
        }

        return users;
    }


    // ==================================================
    // GET USER BY ID
    // ==================================================

    public User getUserById(int userId) {

        User user = null;

        String sql =
                "SELECT * FROM users WHERE user_id=?";

        try {

            Connection con =
                    DBConnection.getConnection();

            PreparedStatement ps =
                    con.prepareStatement(sql);

            ps.setInt(
                    1,
                    userId
            );

            ResultSet rs =
                    ps.executeQuery();

            if (rs.next()) {

                user =
                        new User();

                user.setUserId(
                        rs.getInt("user_id")
                );

                user.setFullName(
                        rs.getString("full_name")
                );

                user.setEmail(
                        rs.getString("email")
                );

                // Do not expose password
                user.setPassword(null);

                user.setRole(
                        rs.getString("role")
                );
            }

            rs.close();
            ps.close();
            con.close();

        } catch (Exception e) {

            e.printStackTrace();
        }

        return user;
    }


    // ==================================================
// UPDATE USER
// ==================================================

    public boolean updateUser(User user) {

        boolean status = false;

        try {

            Connection con = DBConnection.getConnection();

            String sql;

            PreparedStatement ps;

            // If password is blank, keep existing password
            if (user.getPassword() == null ||
                    user.getPassword().trim().isEmpty()) {

                sql =
                        "UPDATE users SET " +
                                "full_name=?, email=?, role=? " +
                                "WHERE user_id=?";

                ps = con.prepareStatement(sql);

                ps.setString(
                        1,
                        user.getFullName()
                );

                ps.setString(
                        2,
                        user.getEmail()
                );

                ps.setString(
                        3,
                        user.getRole()
                );

                ps.setInt(
                        4,
                        user.getUserId()
                );

            } else {

                // New password supplied → BCrypt hash it
                sql =
                        "UPDATE users SET " +
                                "full_name=?, email=?, password=?, role=? " +
                                "WHERE user_id=?";

                ps = con.prepareStatement(sql);

                ps.setString(
                        1,
                        user.getFullName()
                );

                ps.setString(
                        2,
                        user.getEmail()
                );

                String hashedPassword =
                        PasswordUtil.hashPassword(
                                user.getPassword()
                        );

                ps.setString(
                        3,
                        hashedPassword
                );

                ps.setString(
                        4,
                        user.getRole()
                );

                ps.setInt(
                        5,
                        user.getUserId()
                );
            }

            int rows =
                    ps.executeUpdate();

            if (rows > 0) {
                status = true;
            }

            ps.close();
            con.close();

        } catch (Exception e) {

            e.printStackTrace();
        }

        return status;
    }


    // ==================================================
    // DELETE USER
    // ==================================================

    public boolean deleteUser(int userId) {

        boolean status = false;

        String sql =
                "DELETE FROM users WHERE user_id=?";

        try {

            Connection con =
                    DBConnection.getConnection();

            PreparedStatement ps =
                    con.prepareStatement(sql);

            ps.setInt(
                    1,
                    userId
            );

            int rows =
                    ps.executeUpdate();

            if (rows > 0) {

                status = true;
            }

            ps.close();
            con.close();

        } catch (Exception e) {

            e.printStackTrace();
        }

        return status;
    }
}