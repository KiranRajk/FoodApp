# 🍔 FoodApp – Online Food Ordering Web Application

FoodApp is a full-stack web application that allows users to explore restaurants, browse menus, add food items to a cart, and place orders. It is built using Java web technologies, JDBC, and MySQL.

The project demonstrates server-side application development, database connectivity, session management, authentication, and CRUD operations using the DAO pattern.

## 🚀 Features

- **User Registration:** Create a new customer account.
- **User Authentication:** Login with password verification using BCrypt password hashing.
- **Restaurant Listing:** Browse available restaurants.
- **Menu Browsing:** Explore restaurant menus and food items.
- **Shopping Cart:** Add items, increase or decrease quantities, and clear the cart.
- **Checkout:** Place orders and select a payment method.
- **Order History:** View previous orders and their details.
- **Session Management:** Maintain user and cart information across requests.
- **Logout:** Securely end the current session.

## 🛠️ Technologies Used

### Backend
- Java
- Java Servlets
- JavaServer Pages (JSP)
- JDBC
- DAO Pattern

### Frontend
- HTML5
- CSS3
- JavaScript

### Database
- MySQL

### Development Tools
- Eclipse IDE
- Apache Tomcat 10
- Git and GitHub

### Libraries
- MySQL Connector/J
- jBCrypt

## 🏗️ Project Structure

```text
FoodApp/
├── src/
│   └── main/
│       ├── java/
│       │   └── com/tap/
│       │       ├── controller/
│       │       ├── Dao/
│       │       ├── DaoImpl/
│       │       ├── model/
│       │       └── util/
│       └── webapp/
│           ├── css/
│           ├── includes/
│           ├── WEB-INF/
│           ├── cart.jsp
│           ├── checkout.jsp
│           ├── login.jsp
│           ├── menu.jsp
│           ├── orders.jsp
│           ├── restaurant.jsp
│           └── signup.jsp
├── .gitignore
├── .project
├── .classpath
└── README.md
```

## ⚙️ Prerequisites

Before running the application, install:

- Java Development Kit (JDK)
- Eclipse IDE with web development tools
- Apache Tomcat 10.1
- MySQL Server
- MySQL Connector/J

## 🔧 Setup and Installation

### 1. Clone the repository

```bash
git clone https://github.com/KiranRajk/FoodApp.git
```

### 2. Import the project into Eclipse

1. Open Eclipse.
2. Select **File → Import**.
3. Choose **General → Existing Projects into Workspace**.
4. Browse to the cloned project directory.
5. Finish the import.

### 3. Configure MySQL

Create the required database:

```sql
CREATE DATABASE foodapp;
```

Create the necessary tables and populate them with the required application data.

### 4. Configure database credentials

The application reads database configuration from environment variables.

Configure these variables on your system:

| Variable | Description |
|---|---|
| `FOODAPP_DB_URL` | JDBC URL for the MySQL database |
| `FOODAPP_DB_USERNAME` | MySQL username |
| `FOODAPP_DB_PASSWORD` | MySQL password |

Example JDBC URL:

```text
jdbc:mysql://localhost:3306/foodapp
```

Do not commit actual database passwords or other secrets to GitHub.

### 5. Configure Apache Tomcat

1. Add Apache Tomcat 10.1 to Eclipse.
2. Associate the FoodApp project with the Tomcat server.
3. Ensure the required libraries are available.
4. Start the server.

### 6. Run the application

Deploy the application to Tomcat and open it in your browser.

The local URL will generally be:

```text
http://localhost:8080/FoodApp/
```

The context path may differ depending on your Eclipse and Tomcat configuration.

## 🔐 Security

- Passwords are hashed using BCrypt.
- Database credentials are supplied through environment variables.
- User sessions are invalidated during logout.

## 🗄️ Database

MySQL stores the application's data, including users, restaurants, menus, orders, and order items.

**Note:** The database schema and sample data must be configured separately before running the application.

## 👨‍💻 Author

**Kiran Raj K**

GitHub: [KiranRajk](https://github.com/KiranRajk)

## 📌 Future Enhancements

- Payment gateway integration
- Restaurant and menu search
- Order status tracking
- Improved form validation
- Responsive UI improvements