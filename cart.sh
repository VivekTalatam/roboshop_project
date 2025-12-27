dnf module disable nodejs -y
dnf module enable nodejs:20 -y
dnf install nodejs -y
useradd roboshop
mkdir /app
curl -L -o /tmp/cart.zip https://roboshop-artifacts.s3.amazonaws.com/cart-v3.zip
cd /app 
unzip /tmp/cart.zip
cd /app 
npm install 
cp cart.service /etc/systemd/system/cart.service
sed -i -e 's/<REDIS-SERVER-IP>/redis-dev.botparts.shop' -e 's/<CATALOGUE-SERVER-IP>/catalogue-dev.botparts.shop' /etc/systemd/system/cart.service
systemctl daemon-reload
systemctl enable cart
systemctl start cart