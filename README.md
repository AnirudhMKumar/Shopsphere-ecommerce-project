# Shopsphere E-Commerce Project

A fully functional Java-based web application for an online e-commerce platform. This project implements a complete shopping experience from product browsing to order management, built using Java Servlets, JSP, and MySQL.

## 🚀 Features

* **User Authentication:** Secure user registration, login, and profile management.
* **Product Catalog:** Browse products, view individual product details, and high-quality images.
* **Shopping Cart:** Add products, update quantities, and manage cart items seamlessly.
* **Order Management:** Place orders and view order history.
* **Admin Dashboard:** Admins can view customer orders and update order statuses.
* **Responsive UI:** Clean, modern, and engaging user interface.

## 🛠️ Tech Stack

* **Frontend:** HTML5, CSS3, JavaScript, JSP (JavaServer Pages)
* **Backend:** Java Servlets (Java EE)
* **Database:** MySQL
* **Server:** Apache Tomcat (v10+)
* **IDE/Environment:** Eclipse IDE for Enterprise Java Web Developers

## 🔧 Local Setup Instructions

Follow these steps to run the application locally in your Eclipse environment.

### 1. Database Setup
1. Ensure MySQL is installed and running.
2. Import the `ecommerce_db.sql` file provided in the repository root to create the database schema and sample data.
   ```sql
   mysql -u root -p < ecommerce_db.sql
   ```

### 2. Configure Database Credentials
For security reasons, database credentials are not tracked in version control. 
1. Navigate to `src/main/java/` in the project.
2. Create a new file named `db.properties`.
3. Add your MySQL credentials to the file in the following format:
   ```properties
   db.url=jdbc:mysql://localhost:3306/ecommerce_db
   db.username=YOUR_MYSQL_USERNAME
   db.password=YOUR_MYSQL_PASSWORD
   db.driver=com.mysql.cj.jdbc.Driver
   ```

### 3. Import and Run in Eclipse
1. Open Eclipse and select **File > Import > General > Existing Projects into Workspace**.
2. Select the cloned repository folder.
3. Ensure you have the **MySQL Connector/J** (`mysql-connector-j-x.x.x.jar`) added to your `WEB-INF/lib` folder or Java Build Path.
4. Add the project to your Apache Tomcat server runtime.
5. Right-click the project -> **Run As > Run on Server**.

---
*Developed as a comprehensive e-commerce showcase highlighting MVC architecture using Java Servlets and JSP.*
