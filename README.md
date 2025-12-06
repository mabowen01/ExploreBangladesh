
# ExploreBangladesh - Web Application

ExploreBangladesh is a dynamic and educational Java-based web application showcasing the culture and tourism of Bangladesh.
It offers interactive sections on food, music, sports, scenery, and movies along with detailed travel guides.

## 📌 Overview

This application is built using JSP, Servlets, and MySQL, following MVC architecture.
It features a dual interface:
- A public user section to explore content
- An admin panel for managing uploaded content

## ✨ Features

### User Features
- Explore categorized content: Food, Music, Sports, Scenery, Movies
- Like and comment functionality
- Travel info sections (sightseeing, emergency, events, guides)
- User login, registration, and session-based access

### Admin Features
- Secure admin login
- Add, edit, delete content items in each category
- Manage scenery, sports, music, movies, and food
- Admin dashboard interface

## 🛠️ Technologies Used

- Java EE (JSP, Servlets)
- Apache Tomcat 10.1
- MySQL Database
- JSTL (Jakarta Standard Tag Library)
- Eclipse IDE

## 📁 Project Structure

```
ExploreBangladesh/
├── src/
│   ├── main/java/         # Java servlets & DB connection
│   └── main/webapp/       # JSPs, images, admin interface
├── WEB-INF/
│   └── lib/               # Libraries (JSTL, MySQL Connector)
```

## ⚙️ Setup Instructions

### 1. Prerequisites
- JDK 17+
- Apache Tomcat 10.1
- MySQL Server
- Eclipse IDE

### 2. Database Setup
Create a MySQL database and configure `DBConnection.java` with your credentials:

```java
private static final String URL = "jdbc:mysql://localhost:3306/explore_bangladesh";
private static final String USER = "your_username";
private static final String PASSWORD = "your_password";
```

### 3. Running the Application
1. Import into Eclipse as a Dynamic Web Project.
2. Verify JARs in `WEB-INF/lib` are in the build path.
3. Deploy on Tomcat 10.1.
4. Visit: `http://localhost:8080/ExploreBangladesh`

## 🔐 Default Admin Credentials

```
Username: admin
Password: admin123
```

## 📜 License & Notes

This project is for educational use only. For production deployment, ensure proper security practices.
