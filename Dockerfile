FROM bahachalbia/maven:3.6.3-openjdk-13

COPY . .
WORKDIR .

RUN mvn  install 


