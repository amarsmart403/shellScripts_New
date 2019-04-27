#!/bin/bash
DATE=$(date +%F)
USER_ID=$(id -u)
LOG=/tmp/stack.log
TOMCAT_URL=http://mirrors.estointernet.in/apache/tomcat/tomcat-9/v9.0.19/bin/apache-tomcat-9.0.19.tar.gz
STUDENT_URL=https://github.com/devops2k18/DevOpsSeptember/raw/master/APPSTACK/student.war
MYSQL_URL=https://github.com/devops2k18/DevOpsSeptember/raw/master/APPSTACK/mysql-connector-java-5.1.40.jar
R="\e[31m"
G="\e[32m"
N="\e[0m"

VALIDATE(){
	if [ $1 -ne 0 ]; then
		echo -e "$2 ...$R FAILURE $N"
		exit 1
	else
		echo -e "$2 ... $G SUCCESS $N"
	fi
}

echo "started scrit execution on $DATE"

yum install httpd -y  &>> $LOG

VALIDATE $? "Installing Apache"

systemctl start httpd  &>> $LOG

VALIDATE $? "Starting httpd"

systemctl enable httpd  &>> $LOG

VALIDATE $? "Enabling httpd"

#application server installations
yum install java -y &>> $LOG

VALIDATE $? "Installing Java"

wget $TOMCAT_URL -O /root/tomcat/apache-tomcat-9.0.19.tar.gz &>> $LOG

VALIDATE $? "Downloading tomcat"

cd /root/tomcat

tar -xf apache-tomcat-9.0.19.tar.gz

VALIDATE $? "Extracting tomcat"

cd apache-tomcat-9.0.19/webapps

wget $STUDENT_URL &>> $LOG

VALIDATE $? "Downloading student.war"

cd ../lib

wget $MYSQL_URL &>> $LOG

VALIDATE $? "Downloading MYSQL JAR"

cd ../conf

sed -i -e '$ i <Resource name="jdbc/TestDB" auth="Container" type="javax.sql.DataSource" maxTotal="100" maxIdle="30" maxWaitMillis="10000" username="student" password="student@1" driverClassName="com.mysql.jdbc.Driver" url="jdbc:mysql://10.142.0.22:3306/studentapp"/>' context.xml

VALIDATE $? "Editing context.xml"