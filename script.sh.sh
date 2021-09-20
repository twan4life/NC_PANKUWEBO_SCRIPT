
#webserver installeren
echo " Lucien Antoine Berkley script"
sudo apt-get update && sudo apt-get dist-upgrade
sudo apt-get install mysql-server
echo "welke webserver wil je installeren (apache/nginx)"
read webserver
     if [ $webserver = 'apache' ]
         then
apt-get install apache2 php mysql
     elif [ $webserver = 'nginx' ]
         then
apt-get install nginx apache2 php mysql
     else
echo "bedankt voor het keuze"
     fi

#nextcloud installeren
echo "nu gaan e de nextcloud installatie doen"
echo "downloaden nextcloud"
echo "wilt u nextcloud installeren (Y/N)"
read keuze
    if [ $keuze = 'Y' ]
      then
wget -P aa/var/www/nextcloud https://download.nextcloud.com/server/releases/nextcloud-21.0.2.zip
unzip aaja/var/www/nextcloud/nextcloud-21.0.2.zip
    elif [ $keuze = 'N' ]
        then
echo 'no nextcloud geinstaleeNrd'
    fi

 #fail2ban installatie
 echo " Fail2ban installatie"
 curl -L https://packagecloud.io/AtomEditor/atom/gpgkey | sudo apt-key add -
 echo "fail2ban automatisch(A), handmatig(H) of geen(G) installatie "
 echo "welke wil je A/H/G"
  read keuze
     if [ $keuze = 'A' ]
      then
         echo "fail2ban+Sendmail+Firewallactive"
sudo apt-get install fail2ban
echo  'backing up copy for .conf file'
cd /etc/fail2ban
sudo cp fail2ban.conf fail2ban.local
sudo cp jail.conf jail.local
apt-get install sendmail
sed -i 's/loglevel = INFO/loglevel = DEBUG/g' /etc/fail2ban/fail2ban.conf
sed -i 's/dbmaxmatches = 10/dbmaxmatches = 5/g' /etc/fail2ban/fail2ban.conf


sudo fail2ban-client start
    elif [ $keuze = "H" ]
    then
echo "zelf configureren"
apt-get install fail2ban
cd /etc/fail2ban
sudo nano fail2ban.conf
    elif [ $keuze = "G" ]
    then
      echo "succes"
    fi

  #configureren van HTTPS
  echo "configureren van HTTPS"
  sudo git clone https://github.com/certbot/certbot /etc/letsencrypt
  sudo snap install core;
  sudo snap refresh core
  sudo apt-get remove certbot
  sudo snap install --classic certbot
  sudo ln -s /snap/bin/certbot /usr/bin/certbot
  sudo certbot renew --dry-run

  #Firewal
  sudo apt install ufw
  sudo ufw allow ssh
  sudo ufw enable
  sudo ufw app list
  echo " 3 verschillende Firewal profiel"
  echo "Apache his profile manages only port 80 (unencrypted web traffic)(A),
  Apache Full his profile manages only port 80 (unencrypted web traffic) (H)
  Apache secure profile manages only port 443(G)
  OpenSSH profile manages port 22 (Again, be careful with this one,
  as if you are connected to your server via ssh and you choose to deny this profile,
  you will be disconnected from your server) (O) "
  echo "welke wil je A/H/G/O"
   read keuze
      if [ $keuze = 'A' ]
       then
          echo "Apache"
 sudo ufw allow 'Apache'

     elif [ $keuze = "H" ]
     then
 echo "Apache Full"
        sudo ufw allow 'Apache Full'

     elif [ $keuze = "G" ]
     then
       echo "Apache secure"
         sudo ufw allow 'Apache Secure'

       elif [ $keuze = "O" ]
       then
         echo "OpenSSH"
          sudo ufw allow 'OpenSSH'

     fi
