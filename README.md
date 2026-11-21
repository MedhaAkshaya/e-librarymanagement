Enterprise Academic E-Library & Digital Resource Circulation System

## Requirements
- JDK 21 (recommended; set `JAVA_HOME`)
- Apache Maven 3.9+
- Spring Tool Suite 4 / Eclipse
- Postman

## Import into Spring Tool Suite
1. Extract this ZIP.
2. Open STS → **File → Import → Maven → Existing Maven Projects**.
3. Browse to the extracted `PS038_ELibrary_Microservices` folder.
4. Select the root `pom.xml` and click Finish.
5. Wait for Maven dependencies to download. Use **Project → Clean** if STS shows stale build markers.

## Start services (six terminals, from project root)
Start in this order. Run each command from the project root:

```bash
mvn -pl eureka-server spring-boot:run
mvn -pl auth-service spring-boot:run
mvn -pl book-service spring-boot:run
mvn -pl fine-service spring-boot:run
mvn -pl borrow-service spring-boot:run
mvn -pl api-gateway spring-boot:run
```

Eureka at http://localhost:8761

This is a runnable academic/demo baseline, not a production deployment. The demo JWT secret is shared by Auth and Gateway for local testing; replace it with a strong secret stored outside source control. Add role-based authorization, password hashing, persistent production databases, transaction/outbox handling for cross-service consistency, validation, rate limiting, HTTPS, and centralized logging before production. H2 databases are file-backed locally in each service.
