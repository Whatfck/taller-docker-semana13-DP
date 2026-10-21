#Compilacion
FROM maven:3.9.6-eclipse-temurin-21-alpine AS builder

# area de trabajo
WORKDIR /app

# Argumento obligatorio del taller: ID del estudiante inyectado en tiempo de construcción
ARG STUDENT_ID

# optimizacion copiando el pom
COPY pom.xml .

# descargar dependencias
RUN mvn dependency:go-offline -B

# copiamos codigo
COPY src ./src

# compila y empaqueta creamos jar omitimos pruebas unitarias
RUN mvn clean package -DskipTests

# ejecucion
FROM eclipse-temurin:21-jre-alpine AS runtime

# area de trabajo
WORKDIR /app

# creamos usuario no privilegiado: sensor_user con UID 10001 en grupo sensorgroup
RUN addgroup -S sensorgroup && adduser -S sensor_user -G sensorgroup -u 10001

# copiamos el jar
COPY --from=builder /app/target/*.jar app.jar

# asignamos permisos
RUN chown -R sensor_user:sensorgroup /app

# ARG no cruza etapas: hay que redeclararlo en runtime
ARG STUDENT_ID
ENV OPERATOR_ID=${STUDENT_ID}

#cambiamos de usuario
USER sensor_user

#puerto de exposicion
EXPOSE 8080

# Parámetros optimizados para la JVM en entornos de contenedores
ENV JAVA_OPTS="-XX:+UseContainerSupport -XX:MaxRAMPercentage=75.0"

# Punto de entrada de ejecución del contenedor
ENTRYPOINT ["sh", "-c", "java $JAVA_OPTS -jar app.jar"]