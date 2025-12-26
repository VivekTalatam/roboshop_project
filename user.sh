dnf module disable nodejs -y
dnf module enable nodejs:20 -y
dnf install nodejs -y
useradd roboshop
mkdir /app
curl -L -o /tmp/user.zip https://roboshop-artifacts.s3.amazonaws.com/user-v3.zip 
cd /app 
unzip /tmp/user.zip
cd /app 
npm install
cp user.service /etc/systemd/system/user.service
sed -i -e 's/<REDIS-IP-ADDRESS>/<Write-IP-Addr-After-Creating-VM>' -e 's/<MONGODB-SERVER-IP-ADDRESS>/<Write-IP-Addr-After-Creating-VM>' /etc/systemd/system/user.service
systemctl daemon-reload
systemctl enable user
systemctl start user