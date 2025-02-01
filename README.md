# CRAVE-Food-Delivery-Application

[![Java](https://img.shields.io/badge/Java-11%2B-orange)](https://www.oracle.com/java/)
[![Spring](https://img.shields.io/badge/Spring-5.0%2B-green)](https://spring.io/)
[![MySQL](https://img.shields.io/badge/MySQL-8.0%2B-blue)](https://www.mysql.com/)

A robust, scalable food delivery platform built with Java and Spring Framework.

[Features](#features) •
[Tech Stack](#tech-stack) •
[Getting Started](#getting-started) •
[Documentation](#documentation) •
[Contributing](#contributing)

</div>

## Overview

Crave is an enterprise-grade food delivery management system that connects customers with local restaurants through a seamless digital platform. The application streamlines the entire food delivery process, from order placement to delivery tracking, while providing an intuitive interface for all stakeholders.

## Features

### Core Functionality

- **Multi-tenant Architecture**
  - Role-based access control (Customer, Restaurant, Delivery Partner, Admin)
  - Isolated data management for each tenant
  - Customizable dashboards per user role

- **Order Management**
  - Real-time order tracking
  - Delivery partner assignment

- **Restaurant Integration**
  - Dynamic menu management
  - Analytics and reporting dashboard
  - Order acceptance workflow

- **Customer Experience**
  - Intuitive menu browsing
  - Advanced search and filtering
  - Order customization
  - Add to cart functionality
  - Order history 
  

## Tech Stack

### Backend
- **Java 11+**
- **Spring Framework**
  - Spring Boot
  - Spring MVC
  - Spring Security
  - Spring Data JPA
- **Hibernate ORM**
- **Maven**

### Frontend
- **JSP (JavaServer Pages)**
- **JavaScript (ES6+)**
- **Bootstrap 5**
- **HTML5/CSS3**

### Database
- **MySQL 8.0+**
- **Redis** (for caching)

### Tools & Infrastructure
- **Git** - Version control
- **JUnit** - Testing framework
- **Log4j** - Logging
- **Swagger** - API documentation
- **Docker** - Containerization

## Getting Started

### Prerequisites

- JDK 11 or higher
- Maven 3.6+
- MySQL 8.0+
- Docker (optional)

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/tap-foods.git
   cd tap-foods
   ```

2. **Configure database**
   ```bash
   mysql -u root -p < database/init.sql
   ```

3. **Configure application properties**
   ```bash
   cp src/main/resources/application.properties.example src/main/resources/application.properties
   # Update application.properties with your database credentials
   ```

4. **Build and run**
   ```bash
   mvn clean install
   java -jar target/tap-foods-1.0.0.jar
   ```

### Docker Deployment

```bash
docker-compose up --build
```

## Project Structure

```
tap-foods/
├── src/
│   ├── main/
│   │   ├── java/
│   │   │   └── com/tapfoods/
│   │   │       ├── config/
│   │   │       ├── controller/
│   │   │       ├── model/
│   │   │       ├── repository/
│   │   │       ├── service/
│   │   │       └── util/
│   │   ├── resources/
│   │   └── webapp/
│   └── test/
├── database/
├── docker/
├── docs/
└── scripts/
```

## Documentation

- [API Documentation](docs/api.md)
- [Database Schema](docs/schema.md)
- [Deployment Guide](docs/deployment.md)
- [Contributing Guidelines](CONTRIBUTING.md)

## Security

- JWT-based authentication
- Role-based access control
- Input validation and sanitization
- XSS protection
- CSRF protection
- Rate limiting

## Performance Optimization

- Connection pooling
- Query optimization
- Caching implementation
- Load balancing ready
- Lazy loading for large datasets

## Monitoring and Logging

- Centralized logging system
- Performance metrics tracking
- Error tracking and reporting
- Audit trails for critical operations

## Contributing

We welcome contributions! Please see our [Contributing Guidelines](CONTRIBUTING.md) for details.

1. Fork the repository
2. Create your feature branch
3. Commit your changes
4. Push to the branch
5. Create a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- TAP Academy for project guidance and support
- All contributors who have helped shape Tap Foods

## Contact

For support or queries:
- Email: karthik.p6603@gmail.com.com

---

<div align="center">
Made with ❤️ by Karthik
</div>
