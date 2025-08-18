# Etapa de build
FROM maven:3.9.9-eclipse-temurin-17 AS build

WORKDIR /app
COPY pom.xml .
RUN mvn dependency:go-offline

COPY . .
RUN mvn clean package -DskipTests

# Etapa de execução
FROM eclipse-temurin:17-jdk-jammy

WORKDIR /app
EXPOSE 8080

COPY --from=build /app/target/todolist-1.0.0.jar app.jar

ENTRYPOINT ["java", "-jar", "app.jar"]
