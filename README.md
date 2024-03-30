Setup PHP Development Environment with Laravel Valet and WSL 2 (Works with Ubuntu 22.04)

# WSL Kurulumu
Win + R tuşlarına basın ve control yazıp enter diyin. Açılan pencereden programlar ve özellikleri seçin
açılan pencerede sol tarafta windows özelliklerini aç veya kapat ı tıkla.

# WSL'yi yükleme
- Gidin ve Win + R tuşlarına basın ve şunu çalıştırın: Kontrol, bu bilinen eski Panel Kontrolünü açacaktır.
- Bundan sonra Programlar'a gidin, bir sonraki pencerede şunu seçin: Windows özelliklerini aç veya kapat
- Açılan yeni pencerede listenin sonuna kadar arama yapın ve şunları kontrol edin: Linux için Windows Alt Sistemleri, Tamam'a basın ve özellik hazır olana kadar bekleyin.
- İşiniz bittiğinde, Windows makineyi yeniden başlatmanızı isteyecektir, bunu yapın.

Ubuntu'yu yükleme
Windows PC'niz yeniden başlatıldıktan sonra gidin ve Windows Mağazanızda arama yapın:

- Sudo visudo'yu çalıştırın
- Git ve ALL ALL = (root) NOPASSWD dosyasının sonuna şunu ayarla: /usr/sbin/service ve
  <kullanıcı adınız> ALL=(ALL) NOPASSWD: ALL ve kaydedin. Bu, her sudo komutunu kullandığınızda sudo şifrenizi vermenize gerek kalmamasını sağlayacaktır.
# Türkçe:

Bu script WSL üzerinde bir geliştirme ortamı kurmak için tasarlanmıştır.

# Kurulum sırasında yapılacaklar:

Gerekli paketlerin yüklenmesi
PHP ve Composer'ın kurulması
Valet'in kurulması ve dnsmasq ayarlarının yapılması
MySQL'in kurulması ve root şifresinin ayarlanması
RabbitMQ'nun kurulması

# Kullanım:
Scripti WSL'e kopyalayın.
Scripte chmod +x install.sh komutunu çalıştırın.
Scripti çalıştırmak için ./install.sh komutunu kullanın.
Notlar:

Script çalıştırmadan önce WSL'in güncel olduğundan emin olun.
Script çalıştırırken root veya sudo kullanıcısı olarak çalıştığınızdan emin olun.
Script, kullanıcıdan bazı girdiler isteyecektir. Bu girdileri dikkatli bir şekilde girin.
Kurulum tamamlandıktan sonra:

Geliştirme ortamınız kullanıma hazırdır.
Projenizi oluşturmak için belirttiğiniz klasöre ve çalışmaya başlayın
MySQL'e bağlanmak için mysql -u root -p komutunu kullanın.
RabbitMQ'ya bağlanmak için rabbitmqctl status komutunu kullanın.


Scripti çalıştırmadan önce lütfen README dosyasını dikkatlice okuyun.

# Installing WSL
- Go and press Win + R and execute: Control, this will open the old known Panel Control.
- After that go to Programs, inside the next window select: Turn Windows features on or off
- Within in the new window popup, search until the end of the list and check: Windows Subsystems for Linux, press OK and wait until the feature is ready.
- When is done, Windows will ask to restart the machine, do it.

Installing Ubuntu
After your Windows PC has been restarted, go and search in your Windows Store:

- Run sudo visudo
- Go and set at the end of the file ALL ALL = (root) NOPASSWD: /usr/sbin/service and 
<your_username> ALL=(ALL) NOPASSWD: ALL and save. This will make you don't have to give your sudo password every time you use a sudo command.


# English:

This script is designed to set up a development environment on WSL.

# What the script does:

Installs the required packages
Installs PHP and Composer
Installs Valet and configures dnsmasq
Installs MySQL and sets the root password
Installs RabbitMQ
# Usage:

Copy the script to WSL.
Run the chmod +x install.sh command on the script.
Run the script using the ./install.sh command.
Notes:

Make sure WSL is up to date before running the script.
Make sure you are running as root or sudo user when running the script.
The script will ask for some inputs from the user. Enter these inputs carefully.
After the installation is complete:

Your development environment is ready to use.
Go to the folder you specified and start working to create your project
Use the mysql -u root -p command to connect to MySQL.
Use the rabbitmqctl status command to connect to RabbitMQ.

Please read the README file carefully before running the script.
