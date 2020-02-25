#!/bin/bash
  
if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

read -p 'Git Repo: ' gitrepo
read -p 'Project Name: ' projectname
read -p 'Site Name: ' sitename
read -p 'Requirements.txt File Name: ' requirements
read -p 'Installation App Directory: ' installdir

if [ "${installdir: -1}" == '/' ];then
installdir="${installdir::-1}"
fi


YUM_PACKAGE_NAME="python3-pip apache2 libapache2-mod-wsgi-py3 git"
DEB_PACKAGE_NAME="python3-pip apache2 libapache2-mod-wsgi-py3 git"

YUM_CMD=$(which yum)
APT_GET_CMD=$(which apt-get)
if [[ ! -z $YUM_CMD ]]; then
    yum install $YUM_PACKAGE_NAME
 elif [[ ! -z $APT_GET_CMD ]]; then
    apt-get install $DEB_PACKAGE_NAME
 else
    echo "error can't install package $PACKAGE"
    exit 1;
 fi

#diable firewall
sudo ufw disable

#install virtualenv
sudo pip3 install virtualenv

#clone repo
cd $installdir
git clone $gitrepo

basename=$(basename $gitrepo)
repodir=${basename%.*}


cd $repodir
virtualenv venv
source venv/bin/activate
pip install -r $requirements
python manage.py collectstatic
deactivate


#create site.conf
echo '<VirtualHost *:80>
        ServerAdmin ericabraham.ea@gmail.com
        ServerName '$sitename'
        DocumentRoot '$installdir'

        Alias /static '$installdir'/'$repodir'/staticfiles
        <Directory "'$installdir'/'$repodir'/staticfiles">
                Options FollowSymLinks
                Order allow,deny
                Allow from all
                Require all granted
        </Directory>


        ErrorLog ${APACHE_LOG_DIR}/'$projectname'_error.log
        CustomLog ${APACHE_LOG_DIR}/'$projectname'_access.log combined

        WSGIDaemonProcess '$projectname' python-home='$installdir'/'$repodir'/venv python-path='$installdir'/'$repodir'
        WSGIProcessGroup '$projectname'
        WSGIScriptAlias / '$installdir'/'$repodir'/'$projectname'/wsgi.py

        <Directory '$installdir'/'$repodir'/'$projectname'/>
                <Files wsgi.py>
                        Require all granted
                </Files>
        </Directory>
</VirtualHost>' > /etc/apache2/sites-available/$sitename.conf

chown -R www-data:www-data $installdir/$repodir
cd /etc/apache2/sites-available/
a2ensite $sitename.conf
systemctl restart apache2

echo "====================================================="
echo "   Your Django Application is sucessfully Deployed   "
echo "                 Made with <3 by Eric                "		
echo "====================================================="





