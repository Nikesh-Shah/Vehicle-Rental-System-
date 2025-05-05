package model;

import java.sql.Timestamp;

public class User {
    private int userId;
    private String fname;
    private String lname;
    private String email;
    private String password;
    private int role;
    private String phone;
    private Timestamp createdAt;

    // Role constants
    public static final int ROLE_USER = 0;
    public static final int ROLE_ADMIN = 1;

    public User() {}


    public User(String fname, String lname, String email, String password, String phone) {
        this.fname = fname;
        this.lname = lname;
        this.email = email;
        this.password = password;
        this.phone = phone;
        this.role = ROLE_USER; // Default role
    }

    // Constructor with all fields
    public User(int userId, String fname, String lname, String email,
                String password, int role, String phone) {
        this.userId = userId;
        this.fname = fname;
        this.lname = lname;
        this.email = email;
        this.password = password;
        this.role = role;
        this.phone = phone;
    }

    // Getters and Setters
    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }
    public String getFname() { return fname; }
    public void setFname(String fname) { this.fname = fname; }
    public String getLname() { return lname; }
    public void setLname(String lname) { this.lname = lname; }
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }
    public int getRole() { return role; }
    public void setRole(int role) { this.role = role; }
    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    // Role check methods
    public boolean isAdmin() {
        return this.role == ROLE_ADMIN;
    }

    public boolean isUser() {
        return this.role == ROLE_USER;
    }
    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public Timestamp getCreatedAt() {
        return this.createdAt;
    }
}