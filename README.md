# PS038 – Enterprise Academic E-Library & Digital Resource Circulation System

A six-service Spring Boot microservices implementation for the PS038 use case.

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

Windows PowerShell uses the same `mvn` commands. Wait for Eureka at http://localhost:8761 before starting the other services. Gateway base URL: `http://localhost:8080`.

## Demo credentials
- Admin: `admin` / `admin123`
- Student: `student` / `student123`

Login through Postman request `1. Login - student` or `2. Login - admin`. Copy the returned `token` into the collection variable `token` (Postman collection scripts automatically save it).

## API summary (call through gateway)
| Method | Endpoint | Purpose |
|---|---|---|
| POST | `/api/auth/login` | Login and receive JWT |
| GET | `/api/books` | List books |
| GET | `/api/books?q=java` | Search books by title/author |
| GET | `/api/books/{id}` | Get book |
| POST | `/api/books` | Add book |
| PUT | `/api/books/{id}` | Update book |
| DELETE | `/api/books/{id}` | Delete book |
| POST | `/api/borrows` | Borrow a book |
| GET | `/api/borrows` | List borrow records |
| GET | `/api/borrows?username=student` | List a user's borrows |
| POST | `/api/borrows/{id}/return` | Return book and calculate fine |
| GET | `/api/fines/calculate?dueDate=2026-01-01&returnDate=2026-01-05` | Calculate fine |

All endpoints except `/api/auth/**` require `Authorization: Bearer <JWT>`. Fine is ₹5 per overdue day by default. Borrow period is 14 days.

## Test quickly
1. Login using the Postman collection.
2. `GET /api/books` should show three seeded books.
3. Borrow a book using `POST /api/borrows` with `{"bookId":1,"username":"student"}`.
4. Return the generated borrow ID using `POST /api/borrows/{id}/return`.
5. The response contains the borrow record and fine calculation.

## Notes / production hardening
This is a runnable academic/demo baseline, not a production deployment. The demo JWT secret is shared by Auth and Gateway for local testing; replace it with a strong secret stored outside source control. Add role-based authorization, password hashing, persistent production databases, transaction/outbox handling for cross-service consistency, validation, rate limiting, HTTPS, and centralized logging before production. H2 databases are file-backed locally in each service.
