FROM bahachalbia/0206 as builder

# Set the working directory to the project root
WORKDIR /app

# Copy the pom.xml file to the working directory
COPY pom.xml .

# Build all dependencies
RUN mvn dependency:go-offline

# Copy the rest of the project source code
COPY src ./src

# Build the project
RUN mvn package

FROM openjdk:13-jdk-alpine

# Set the working directory to the project root
WORKDIR /app

# Copy the built JAR file from the builder stage
COPY --from=builder /app/target/*.jar app.jar
EXPOSE 8080
# Run the JAR file
ENTRYPOINT ["java", "-jar", "app.jar"]
