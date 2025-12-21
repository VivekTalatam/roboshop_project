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
sed -i 's/<MONGODB-SERVER-IPADDRESS>/<write-IP-Addr-After-Creatig-VM>/g' /etc/systemd/system/catalogue.service