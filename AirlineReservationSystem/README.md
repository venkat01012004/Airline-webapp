# SkyWings Airline Reservation System

A complete, production-ready **Airline Reservation System** built entirely with core Java web technologies — no frameworks, no magic. This project demonstrates a full end-to-end flight booking platform: searching flights, booking tickets, making payments, and managing everything through an admin dashboard.

## Tech Stack

| Layer            | Technology                              |
|-------------------|------------------------------------------|
| Language          | Java 21                                   |
| Build Tool        | Apache Maven 3.9+                         |
| Web Server        | Apache Tomcat 9.x                         |
| Web Layer         | JSP + JSTL 1.2 + Servlets (`javax.servlet.*`) |
| Data Access       | Plain JDBC (no ORM)                       |
| Database          | MySQL 8.x                                 |
| Frontend          | HTML5, CSS3, JavaScript, Bootstrap 5      |
| CI/CD             | Jenkins Declarative Pipeline              |
| Version Control   | Git / GitHub                              |

**No Spring, Spring Boot, Hibernate, Docker, Kubernetes, React or Angular is used anywhere in this project.**

## Features

- Modern, responsive airline booking homepage
- User registration and login (SHA-256 password hashing)
- Flight search by source, destination and date
- Ticket booking with live seat availability checks
- Simulated payment gateway with booking confirmation / e-ticket
- Booking history with cancellation support
- Contact Us page with message storage
- Admin Dashboard with key metrics (flights, bookings, users, revenue)
- Admin flight management (add / edit / delete flights)
- Admin view of all bookings and registered users
- Role-based access control via servlet filters (`AuthFilter`, `AdminFilter`)
- Centralized error handling (404 / 500 pages)

## Project Structure

```
AirlineReservationSystem/
├── src/
│   ├── main/
│   │   ├── java/
│   │   │   └── com/airline/
│   │   │       ├── controller/   # Servlets (request handling)
│   │   │       ├── model/        # POJOs (User, Flight, Booking, Payment...)
│   │   │       ├── dao/          # JDBC data access objects
│   │   │       ├── service/      # Business logic layer
│   │   │       ├── util/         # DB connection, password hashing, validation
│   │   │       ├── filter/       # Auth / Admin servlet filters
│   │   │       └── listener/     # ServletContext / HttpSession listeners
│   │   ├── resources/
│   │   │   └── db.properties     # JDBC connection settings
│   │   └── webapp/
│   │       ├── css/              # Stylesheets
│   │       ├── js/                # Client-side JavaScript
│   │       ├── images/            # Static images
│   │       ├── includes/          # header.jsp / footer.jsp
│   │       ├── admin/             # Admin dashboard & management pages
│   │       ├── customer/          # Customer profile page
│   │       ├── booking/           # Booking confirmation page
│   │       ├── error/             # 404 / 500 error pages
│   │       ├── WEB-INF/web.xml
│   │       ├── index.jsp
│   │       ├── login.jsp
│   │       ├── register.jsp
│   │       ├── search-flight.jsp
│   │       ├── book-flight.jsp
│   │       ├── my-bookings.jsp
│   │       ├── payment.jsp
│   │       └── contact.jsp
│   └── test/
│       └── java/com/airline/      # JUnit tests
├── .gitignore
├── Jenkinsfile
├── pom.xml
├── README.md
└── database.sql
```

## Prerequisites

- JDK 21
- Apache Maven 3.9 or higher
- Apache Tomcat 9.x
- MySQL 8.x
- (Optional) Jenkins with the Maven and JDK tool plugins configured

## Database Setup

1. Start your MySQL server.
2. Run the provided script to create the schema and seed sample data:

   ```bash
   mysql -u root -p < database.sql
   ```

   This creates the `airline_reservation` database with tables for `users`, `flights`, `bookings`, `payments`, and `contact_messages`, along with sample flights and two demo accounts.

3. Update `src/main/resources/db.properties` with your MySQL credentials if they differ from the defaults:

   ```properties
   db.driver=com.mysql.cj.jdbc.Driver
   db.url=jdbc:mysql://localhost:3306/airline_reservation?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true
   db.username=root
   db.password=root
   ```

## Demo Credentials

| Role     | Email               | Password   |
|----------|---------------------|------------|
| Admin    | admin@airline.com   | Admin@123  |
| Customer | john@example.com    | John@123   |

## Build & Run Locally

1. **Build the WAR file:**

   ```bash
   mvn clean package
   ```

   This produces `target/AirlineReservationSystem.war`.

2. **Deploy to Tomcat 9:**

   Copy the WAR file into your Tomcat `webapps` directory:

   ```bash
   cp target/AirlineReservationSystem.war $CATALINA_HOME/webapps/
   ```

   Start (or restart) Tomcat:

   ```bash
   $CATALINA_HOME/bin/startup.sh
   ```

3. **Access the application:**

   ```
   http://localhost:8080/AirlineReservationSystem/
   ```

## Running Tests

```bash
mvn test
```

## CI/CD with Jenkins

The included `Jenkinsfile` defines a declarative pipeline with the following stages:

1. **Checkout** – pulls the latest source from GitHub
2. **Build** – compiles the project with Maven
3. **Test** – runs the JUnit test suite and publishes results
4. **Package** – builds `AirlineReservationSystem.war`
5. **Archive Artifact** – archives the WAR file as a Jenkins build artifact
6. **Deploy to Tomcat** – copies the WAR into a configured Tomcat `webapps` directory (runs on the `main` branch)

To use it, create a Jenkins Pipeline job pointing at this repository and ensure the `Maven3` and `JDK21` tool names (or update them in the `Jenkinsfile`) are configured under **Manage Jenkins → Tools**.

## Deploying to GitHub

```bash
git init
git add .
git commit -m "Initial commit: Airline Reservation System"
git branch -M main
git remote add origin <your-github-repo-url>
git push -u origin main
```

## Notes

- Passwords are hashed using SHA-256 before being stored — no plain text passwords are ever persisted.
- The payment page simulates a payment gateway for demonstration purposes; no real transactions are processed.
- All database access uses plain JDBC with `PreparedStatement` and try-with-resources to prevent SQL injection and resource leaks.
- Servlets are registered via annotations (`@WebServlet`, `@WebFilter`, `@WebListener`); `web.xml` handles welcome files, session configuration and error pages.

## License

This project is provided for educational and demonstration purposes.
