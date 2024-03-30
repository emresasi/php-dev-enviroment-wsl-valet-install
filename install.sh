#!/bin/bash -i

# Install required packages / Gerekli paketleri yükle
sudo apt-get update && sudo apt-get upgrade

echo " -------------------------------------------- Prepares the installation for PHP. / PHP için kurulumu hazırlayacaktır.  --------------------------------------------"

#Prepares the installation for PHP. / PHP için kurulumu hazırlayacaktır.
sudo add-apt-repository ppa:ondrej/php

# Install required packages / Gerekli paketleri yükle
sudo apt-get update

#Prepare for Laravel Valet / Laravel Valet'e hazırlanın
#We have few additional dependencies to install  / Yüklememiz gereken birkaç ek bağımlılığımız var
sudo apt-get install network-manager libnss3-tools jq xsel
sudo apt install curl git zip unzip redis-server mysql-server nginx -y

sudo apt install php8.1-{cli,common,curl,fpm,gd,mbstring,mysql,opcache,readline,sqlite3,xml,zip}
sudo apt install php8.2-{cli,common,curl,fpm,gd,mbstring,mysql,opcache,readline,sqlite3,xml,zip}
sudo apt install php8.3-{cli,common,curl,fpm,gd,mbstring,mysql,opcache,readline,sqlite3,xml,zip}


echo "-------------------------------------------- Composer kurulumu --------------------------------------------"

# Install Composer / Composer kurulumu
curl -sS https://getcomposer.org/installer | php

# Install Composer globally / Composer global olarak yükle
sudo mv composer.phar /usr/local/bin/composer

# Add Composer to PATH /  Composer'ı PATH'e ekle
echo 'export PATH=$HOME/.config/composer/vendor/bin:$PATH' >> ~/.bashrc

# You can reinstall the bash shell / Bash kabuğunu yeniden yükle
source ~/.bashrc
export PATH=$PATH:$HOME/bin




echo "-------------------------------------------- Valet installation / Valet kurulumu --------------------------------------------"

#Valet installation / Valet kurulumu
composer global require cpriego/valet-linux tightenco/takeout

echo "-------------------------------------------- Dnsmasq installation / Dnsmasq kurulumu --------------------------------------------"

echo "Dnsmasq install start - Dnsmasq kurulum başlangıcı"

sudo systemctl stop systemd-resolved

# Install required packages / Gerekli paketleri yükle
sudo apt update
sudo apt install dnsmasq

# File to be edited / Düzenlenecek dosya
dosya="/etc/dnsmasq.conf"

# Line to change / Değiştirilecek satır
satir="port=5353"

# Sed command to uncheck / İşaretini kaldırmak için sed komutu
sed -i "s/^#${satir}/${satir}/" "${dosya}"

# Checking for changes / Değişikliklerin kontrol edilmesi
echo "File content - Dosya içeriği:"
cat "${dosya}"

echo "**Process completed - İşlem tamamlandı!**"

sudo systemctl restart dnsmasq

echo "Dnsmasq install done - Dnsmasq kurulumu tamamlandı"




# Check file existence / Dosya varlığını kontrol et
if [ -f /etc/wsl.conf ]; then
  # If file exists, check if appended / Dosya mevcutsa, ekleme yapılıp yapılmadığını kontrol et
  if ! grep -q "generateResolvConf = false" /etc/wsl.conf; then
    echo "[network]" | sudo tee -a /etc/wsl.conf
    echo "generateResolvConf = false" | sudo tee -a /etc/wsl.conf
  fi
else
  # If the file does not exist, add it / Dosya mevcut değilse, ekle
  echo "[network]" | sudo tee -a /etc/wsl.conf
  echo "generateResolvConf = false" | sudo tee -a /etc/wsl.conf
fi

echo "-------------------------------------------- Valet installation / valet kurulumu --------------------------------------------"

# Valet installation / Valet kurulumu
valet install


# Valet /etc/resolv.conf even in our wsl.conf file edit if we leave the file as a symlink
# Changes it to a symlink that will be reset after WSL is restarted. Therefore it is recommended to copy the valet resolv configuration.

# Valet /etc/resolv.conf, dosyayı bir sembolik bağlantı olarak bırakırsak, wsl.conf dosya düzenlememizde bile
# WSL yeniden başlatıldıktan sonra sıfırlanacak olan bir sembolik bağlantıya değiştirir . Bu nedenle vale resolv yapılandırmasının kopyalanması önerilir.

sudo unlink /etc/resolv.conf
sudo cp /opt/valet-linux/valet-dns /etc/resolv.conf
sudo chattr +i /etc/resolv.conf

# Valet dns setting / Valet dns ayarlama
echo 'nameserver 8.8.8.8' | sudo tee /opt/valet-linux/dns-servers

valet use 8.1
composer global update
valet use 8.2
valet use 8.3


#Get folder name from User to create Environment folder / Envoirement klasörünü oluşturulmak için Kullanıcıdan klasör adını alın
echo  "Write the folder with the directory you want to open it in. For example: /home/username/folder_name."
echo  "Klasörü açacağınız dizinle beraber yazın. Örk: /home/username/folder_name şeklinde."
echo -n "Enter folder name - Klasör adı girin: "
read klasor_adi

# Check if the folder exists / Klasörün var olup olmadığını kontrol edin
if [ -d "$klasor_adi" ]; then
  echo "The folder already exists - Klasör zaten var."
else
  # Create the folder / Klasörü oluşturun
  mkdir "$klasor_adi"

  # Enter the created folder / Oluşturulan klasöre girin
  cd "$klasor_adi"

  echo "The folder has been successfully created and entered. - Klasör başarıyla oluşturuldu ve girildi."
	
	valet park

fi

echo "-------------------------------------------- MySQL installation / MySQL kurulumu --------------------------------------------"

read -s -p "MySQL root şifresini girin: " mysql_password
echo

# Adım 1: mysql servisini durdurma (Stopping the MySQL service)
sudo service mysql stop

# Adım 2: mysql kullanıcısının ev dizinini /var/lib/mysql/ olarak değiştirme (Changing the home directory of the mysql user to /var/lib/mysql/)
sudo usermod -d /var/lib/mysql/ mysql

# Adım 3: mysql servisini başlatma (Starting the MySQL service)
sudo service mysql start

# MySQL'ye oturum açma ve komutları çalıştırma (Logging in to MySQL and executing commands)
sudo mysql -u root -p$mysql_password <<EOF
# Adım 4: root kullanıcısının şifresini belirleme (Setting the password for the root user)
ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '$mysql_password';
# Adım 5: Yetkileri güncelleme (Updating privileges)
FLUSH PRIVILEGES;
EOF

# Adım 6: mysql servisini yeniden başlatma (Restarting the MySQL service)
sudo service mysql restart


# RabbitMQ installation /  RabbitMQ kurulumu
echo "--------------------------------------------------- RabbitMQ install start ---------------------------------------------------"

sudo apt-get install curl gnupg apt-transport-https -y

## Team RabbitMQ's main signing key
curl -1sLf "https://keys.openpgp.org/vks/v1/by-fingerprint/0A9AF2115F4687BD29803A206B73A36E6026DFCA" | sudo gpg --dearmor | sudo tee /usr/share/keyrings/com.rabbitmq.team.gpg > /dev/null
## Community mirror of Cloudsmith: modern Erlang repository
curl -1sLf https://github.com/rabbitmq/signing-keys/releases/download/3.0/cloudsmith.rabbitmq-erlang.E495BB49CC4BBE5B.key | sudo gpg --dearmor | sudo tee /usr/share/keyrings/rabbitmq.E495BB49CC4BBE5B.gpg > /dev/null
## Community mirror of Cloudsmith: RabbitMQ repository
curl -1sLf https://github.com/rabbitmq/signing-keys/releases/download/3.0/cloudsmith.rabbitmq-server.9F4587F226208342.key | sudo gpg --dearmor | sudo tee /usr/share/keyrings/rabbitmq.9F4587F226208342.gpg > /dev/null

## Add apt repositories maintained by Team RabbitMQ
sudo tee /etc/apt/sources.list.d/rabbitmq.list <<EOF
## Provides modern Erlang/OTP releases
##
deb [signed-by=/usr/share/keyrings/rabbitmq.E495BB49CC4BBE5B.gpg] https://ppa1.novemberain.com/rabbitmq/rabbitmq-erlang/deb/ubuntu jammy main
deb-src [signed-by=/usr/share/keyrings/rabbitmq.E495BB49CC4BBE5B.gpg] https://ppa1.novemberain.com/rabbitmq/rabbitmq-erlang/deb/ubuntu jammy main

# another mirror for redundancy
deb [signed-by=/usr/share/keyrings/rabbitmq.E495BB49CC4BBE5B.gpg] https://ppa2.novemberain.com/rabbitmq/rabbitmq-erlang/deb/ubuntu jammy main
deb-src [signed-by=/usr/share/keyrings/rabbitmq.E495BB49CC4BBE5B.gpg] https://ppa2.novemberain.com/rabbitmq/rabbitmq-erlang/deb/ubuntu jammy main

## Provides RabbitMQ
##
deb [signed-by=/usr/share/keyrings/rabbitmq.9F4587F226208342.gpg] https://ppa1.novemberain.com/rabbitmq/rabbitmq-server/deb/ubuntu jammy main
deb-src [signed-by=/usr/share/keyrings/rabbitmq.9F4587F226208342.gpg] https://ppa1.novemberain.com/rabbitmq/rabbitmq-server/deb/ubuntu jammy main

# another mirror for redundancy
deb [signed-by=/usr/share/keyrings/rabbitmq.9F4587F226208342.gpg] https://ppa2.novemberain.com/rabbitmq/rabbitmq-server/deb/ubuntu jammy main
deb-src [signed-by=/usr/share/keyrings/rabbitmq.9F4587F226208342.gpg] https://ppa2.novemberain.com/rabbitmq/rabbitmq-server/deb/ubuntu jammy main
EOF

## Update package indices
sudo apt-get update -y

## Install Erlang packages
sudo apt-get install -y erlang-base \
                        erlang-asn1 erlang-crypto erlang-eldap erlang-ftp erlang-inets \
                        erlang-mnesia erlang-os-mon erlang-parsetools erlang-public-key \
                        erlang-runtime-tools erlang-snmp erlang-ssl \
                        erlang-syntax-tools erlang-tftp erlang-tools erlang-xmerl

## Install rabbitmq-server and its dependencies
sudo apt-get install rabbitmq-server -y --fix-missing

sudo rabbitmq-plugins enable rabbitmq-management
