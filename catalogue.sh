dnf module disable nodejs -y
dnf module enable nodejs:20 -y
dnf install nodejs -y
useradd roboshop
mkdir /app 
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue-v3.zip 
cd /app 
unzip /tmp/catalogue.zip
cd /app 
npm install
cp catalogue.service /etc/systemd/system/catalogue.service
cp mongo.repo /etc/yum.repos.d/mongo.repo
sed -i 's/<MONGODB-SERVER-IPADDRESS>/mongodb.dev.botparts.shop/g' /etc/systemd/system/catalogue.service
dnf install mongodb-mongosh -y
mongosh --host mongodb-dev.botparts.shop </app/db/master-data.js