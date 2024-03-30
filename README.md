Setup PHP Development Environment with Laravel Valet and WSL 2 (Works with Ubuntu 22.04)
Bu script WSL üzerinde bir geliştirme ortamı kurmak için tasarlanmıştır.

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

1.- Bundan sonra Windows tarafında yeni bir uygulama kurmamız gerekiyor,
Acrylic DNS Proxy'den bahsediyorum. Bu uygulamanın yaptığı şey, bu localhost'un 
Windows tarafınızda çalışmasını sağlamak için Windows ile Laravel Valet arasında bir 
proxy iletişimi kurmaktır. İndirin ve yükleyin.
- [Acrylic DNS Download](https://mayakron.altervista.org/support/acrylic/Home.htm)

2.- Kurulduktan sonra açın, bu yerel DNS hizmetinin arka planda çalışmaya başlamasını 
sağlayacaktır. Ve 127.0.0.1 DNS’ye işaret eden .test domainini kurmamız gerekiyor.

Dosyaya Git > Acrylic Sunucuyu Aç

Ve dosya kümesinin sonunda: 127.0.0.1 *.test ardından Ctrl + S ile kaydedin. 
DNS hizmetini yeniden başlatmak için Evet tuşuna basın.

3.- Bir sonraki adımda DNS'yi bilgisayarımızdaki ana İnternet bağlantı noktamıza ayarlamamız 
gerekiyor, bunun için bu aşağıdaki Windows Configuration linkini kontrol edin.

- [Windows Configuration](https://mayakron.altervista.org/support/acrylic/Windows10Configuration.htm)


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
# English:

# Installing WSL
- Go and press Win + R and execute: Control, this will open the old known Panel Control.
- After that go to Programs, inside the next window select: Turn Windows features on or off
- Within in the new window popup, search until the end of the list and check: Windows Subsystems for Linux, press OK and wait until the feature is ready.
- When is done, Windows will ask to restart the machine, do it.

Installing Ubuntu
After your Windows PC has been restarted, go and search in your Windows Store:

- Run sudo visudo
- Go and set at the end of the file ALL ALL = (root) NOPASSWD: /usr/sbin/service and 
<your_username> ALL=(ALL) NOPASSWD: ALL and save. This will make you don't have to give 
your sudo password every time you use a sudo command.

This script is designed to set up a development environment on WSL.

1.- After that, we need to install a new app in the Windows side, i'm talking about 
Acrylic DNS Proxy. What this app does is to establish a proxy communication between 
Windows and Laravel Valet to make this localhost works in your Windows side. 
Download it and install it.
- [Acrylic DNS Download](https://mayakron.altervista.org/support/acrylic/Home.htm)

2.- Once is installed just open it, this will make the local DNS service start running in the 
backgroud. And we need to set up the domain .test pointed into 127.0.0.1 DNS.

Go to File > Open Acrylic Host

And at the end of the file set: 127.0.0.1 *.test then save it with Ctrl + S. 
Press Yes to restart the DNS service.

3.- The next installation is to set DNS to our main Internet port on our computer
required, for that check the Windows Configuration link below.

- [Windows Configuration](https://mayakron.altervista.org/support/acrylic/Windows10Configuration.htm)

 
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
