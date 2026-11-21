@echo off
start cmd /k "mvn -pl eureka-server spring-boot:run"
timeout /t 10
start cmd /k "mvn -pl auth-service spring-boot:run"
start cmd /k "mvn -pl book-service spring-boot:run"
start cmd /k "mvn -pl fine-service spring-boot:run"
start cmd /k "mvn -pl borrow-service spring-boot:run"
timeout /t 8
start cmd /k "mvn -pl api-gateway spring-boot:run"
