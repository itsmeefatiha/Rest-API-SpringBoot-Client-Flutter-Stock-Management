# Use an official OpenJDK runtime as a parent image
FROM openjdk:17-jdk-alpine

# Set the working directory in the container
WORKDIR /app

# Copy the application JAR file into the container at /app
COPY target/your-application.jar /app/your-application.jar

# Expose the port your application will run on
EXPOSE 4440

# Specify the command to run on container startup
CMD ["java", "-jar", "your-application.jar"]