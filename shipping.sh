dnf install maven -y
useradd roboshop
mkdir /app 
curl -L -o /tmp/shipping.zip https://roboshop-artifacts.s3.amazonaws.com/shipping-v3.zip 
cd /app 
unzip /tmp/shipping.zip
cd /app 
mvn clean package 
mv target/shipping-1.0.jar shipping.jar
cp shipping.service /etc/systemd/system/shipping.service
sed -i -e 's/<CART-SERVER-IPADDRESS>/<Write Cart IP after VM creation>' -e 's/<MYSQL-SERVER-IPADDRESS>/<Write mysql IP after VM creation>'
systemctl daemon-reload 
systemctl enable shipping
systemctl start shipping
dnf install mysql -y 
mysql -h <MYSQL-SERVER-IPADDRESS> -uroot -pRoboShop@1 < /app/db/schema.sql
mysql -h <MYSQL-SERVER-IPADDRESS> -uroot -pRoboShop@1 < /app/db/app-user.sql 
mysql -h <MYSQL-SERVER-IPADDRESS> -uroot -pRoboShop@1 < /app/db/master-data.sql
systemctl restart shipping