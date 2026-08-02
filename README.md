# 🚀 Background Job Scheduler System

A Java Web Application that automates job scheduling and execution. The system allows administrators to create, schedule, monitor, and manage background jobs. Jobs are executed automatically at the scheduled date and time, and execution details are stored in a job history log.

---

## 📌 Project Overview

The **Background Job Scheduler System** is developed using **Java, JSP, Servlets, JDBC, MySQL, Maven, and Apache Tomcat**. It provides an easy-to-use interface for managing scheduled jobs and automatically executes pending jobs using a background scheduler.

---

## ✨ Features

### 🔐 Authentication
- User Login
- User Logout
- Session Management

### 📊 Dashboard
- Total Users
- Total Jobs
- Completed Jobs
- Failed Jobs

### 💼 Job Management
- Add Job
- Edit Job
- Delete Job
- View All Jobs
- Schedule Date & Time
- Execution Status

### ⏰ Background Scheduler
- Runs automatically every 10 seconds
- Detects pending jobs
- Executes scheduled jobs
- Updates execution status automatically

### 📜 Job History
- Stores execution logs
- Displays execution history
- Shows execution time, status, and result

---

## 🛠️ Technologies Used

### Frontend
- JSP
- HTML
- CSS
- Bootstrap 5
- Bootstrap Icons

### Backend
- Java
- Jakarta Servlet
- JDBC

### Database
- MySQL

### Server
- Apache Tomcat 10

### Build Tool
- Maven

### IDE
- IntelliJ IDEA

---

## 📂 Project Structure

```
BackgroundJobScheduler
│
├── src
│   ├── main
│   │   ├── java
│   │   │   ├── controller
│   │   │   ├── dao
│   │   │   ├── model
│   │   │   ├── scheduler
│   │   │   └── util
│   │   │
│   │   └── webapp
│   │       ├── jsp
│   │       ├── css
│   │       └── WEB-INF
│
├── pom.xml
└── README.md
```

---

## 🗄️ Database Tables

### Users
- User ID
- Full Name
- Email
- Password
- Role

### Jobs
- Job ID
- Job Name
- Description
- Job Type
- Job Status
- Schedule Date
- Schedule Time
- Execution Status

### Job History
- History ID
- Job ID
- Job Name
- Execution Time
- Status
- Result

---

## 🔄 Project Workflow

```
User Login
      │
      ▼
Dashboard
      │
      ▼
Create Job
      │
      ▼
Save in Database
      │
      ▼
Scheduler Checks Every 10 Seconds
      │
      ▼
Scheduled Time Reached
      │
      ▼
Execute Job
      │
      ▼
Update Status → Completed
      │
      ▼
Store Execution History
      │
      ▼
View Job History
```

---

## ▶️ How to Run the Project

### 1. Clone the Repository

```bash
git clone https://github.com/YOUR_USERNAME/BackgroundJobScheduler.git
```

### 2. Open the Project

Open the project in **IntelliJ IDEA**.

### 3. Configure MySQL

- Create the database.
- Import the SQL file.
- Update database credentials in:

```
DBConnection.java
```

### 4. Build the Project

Run:

```bash
mvn clean
```

```bash
mvn package
```

### 5. Deploy

Copy the generated WAR file from the `target` folder into the **Tomcat webapps** directory.

### 6. Start Apache Tomcat

Start the Tomcat server.

### 7. Open the Application

```
http://localhost:8080/BackgroundJobScheduler-1.0-SNAPSHOT/
```

### 8. Login

Login using your registered user credentials.

---

## 📸 Screenshots

You can add screenshots here:

- Login Page
- Dashboard
- Job Management
- Add Job
- Job History

---

## 🚀 Future Enhancements

- Email Notifications
- Quartz Scheduler Integration
- Search and Filter Jobs
- Dashboard Charts
- PDF Export
- Excel Export
- User Role Management
- Analytics Dashboard
- Responsive Admin Panel

---

## 👨‍💻 Author

**Vaishnavi Girase**

MCA (Master of computer Application)

---

## 📄 License

This project is developed for educational and learning purposes.