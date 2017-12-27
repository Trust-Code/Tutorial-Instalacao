#! /bin/bash

ODOO_VERSION='10'

echo "Esse script é focado na instalação do odoo V.$ODOO_VERSION"
echo "com o foco em desenvolvimento."

echo "Atualizando cache do sistema"
sudo apt-get update

echo "Instalando git"
sudo apt-get install git -y
echo "Pacote git instalado"

echo "Instalando postgresql"
sudo apt install postgresql -y
echo "Pacote postgreql instalado"

echo "Instalando pgadmin"
sudo apt install pgadmin3 -y
echo "pgAdmin instalado"

echo "Instalando python-dev"
sudo apt install python-dev -y
echo "Pacote python-dev instalado"

echo "Instalando gcc"
sudo apt install gcc -y
echo "Pacote gcc instalado"

echo "Criando usuário postgreSQL ..."
sudo -u postgres -- psql -c "ALTER USER postgres WITH PASSWORD '123';"
sudo -u postgres -- psql -c "DROP ROLE odoo;"
sudo -u postgres -- psql -c "CREATE ROLE odoo LOGIN ENCRYPTED PASSWORD 'md5f7b7bca97b76afe46de6631ff9f7175c' NOSUPERUSER INHERIT CREATEDB CREATEROLE REPLICATION"

echo "==== Instalando dependências Odoo ===="
sudo apt-get install --no-install-recommends python-pip -y
sudo apt-get install --no-install-recommends libxml2-dev -y
sudo apt-get install --no-install-recommends libxslt-dev -y
sudo apt-get install --no-install-recommends libsasl2-dev -y
sudo apt-get install --no-install-recommends libldap2-dev -y
sudo apt-get install --no-install-recommends libpq-dev -y
sudo apt-get install --no-install-recommends libjpeg-dev -y
sudo apt-get install --no-install-recommends nodejs -y
sudo apt-get install --no-install-recommends npm -y
sudo apt-get install node-less -y
sudo npm install -g less
sudo ln -s /usr/bin/nodejs /usr/bin/node


echo "==== Instalando dependências da Localização Brasileira ===="
sudo apt-get install --no-install-recommends python-libxml2 -y
sudo apt-get install --no-install-recommends libxmlsec1-dev -y
sudo apt-get install --no-install-recommends python-openssl -y
sudo apt-get install --no-install-recommends python-cffi -y

echo "==== Instalando dependências do WKHTMLTOX ===="
sudo apt-get install --no-install-recommends zlib1g-dev -y
sudo apt-get install --no-install-recommends fontconfig -y
sudo apt-get install --no-install-recommends libfreetype6 -y
sudo apt-get install --no-install-recommends libx11-6 -y
sudo apt-get install --no-install-recommends libxext6 -y
sudo apt-get install --no-install-recommends libxrender1 -y
sudo apt-get install --no-install-recommends libjpeg-turbo8 -y

wget https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.1/wkhtmltox-0.12.1_linux-trusty-amd64.deb -P ~/
sudo dpkg -i ~/wkhtmltox-0.12.1_linux-trusty-amd64.deb

echo "==== Instalação dependências pip para os módulos ===="

if [ $ODOO_VERSION == '10' ]
then

    echo "======== Caso a versão a versão seja odoo 10 ========"
    echo "============= Virtualenv 2,7 será criado ============"

    mkdir ~/src
    cd ~
    wget http://www.python.org/ftp/python/2.7.9/Python-2.7.9.tgz
    tar -zxvf Python-2.7.9.tgz
    cd Python-2.7.9
    sudo mkdir /odoopython

    sudo ./configure --prefix=/odoopython
    sudo make
    sudo make install

    cd ~/src
    wget  https://pypi.python.org/packages/d4/0c/9840c08189e030873387a73b90ada981885010dd9aea134d6de30cd24cb8/virtualenv-15.1.0.tar.gz#md5=44e19f4134906fe2d75124427dc9b716
    tar -zxvf virtualenv-15.1.0.tar.gz
    cd virtualenv-15.1.0/
    sudo /odoopython/bin/python setup.py install
    mkdir ~/odooenv27
    /odoopython/bin/virtualenv ~/odooenv27/ve -p /odoopython/bin/python2.7
    source ~/odooenv27/ve/bin/activate

fi



pip install --upgrade pip
pip install --upgrade setuptools
pip install Babel==1.3
pip install Jinja2==2.7.3
pip install Mako==1.0.1
pip install MarkupSafe==0.23
pip install Pillow==2.7.0
pip install Python-Chart==1.39
pip install PyYAML==3.11
pip install Werkzeug==0.9.6
pip install argparse==1.2.1
pip install decorator==3.4.0
pip install docutils==0.12
pip install feedparser==5.1.3
pip install gdata==2.0.18
pip install gevent==1.0.2
pip install greenlet==0.4.7
pip install jcconv==0.2.3
pip install lxml==3.4.1
pip install mock==1.0.1
pip install ofxparse==0.14
pip install passlib==1.6.2
pip install psutil==2.2.0
pip install psycogreen==1.0
pip install psycopg2==2.5.4
pip install pyPdf==1.13
pip install pydot==1.0.2
pip install pyparsing==2.0.3
pip install pyserial==2.7
pip install python-dateutil==2.4.0
pip install python-ldap==2.4.19
pip install python-openid==2.2.5
pip install pytz==2014.10
pip install pyusb==1.0.0b2
pip install qrcode==5.1
pip install reportlab==3.1.44
pip install requests==2.6.0
pip install six==1.9.0
pip install suds-jurko==0.6
pip install vobject==0.6.6
pip install wsgiref==0.1.2
pip install XlsxWriter==0.7.7
pip install xlwt==0.7.5
pip install openpyxl==2.4.0-b1
pip install boto==2.38.0
pip install odoorpc
pip install suds_requests
pip install pytrustnfe
pip install python-boleto
pip install python-cnab
pip install wheel
pip install http://labs.libre-entreprise.org/frs/download.php/897/pyxmlsec-0.3.1.tar.gz
echo ">>> pip e seus requerimentos estão instalados. <<<"

echo "Clonando repositório oficial Odoo no GitHub. Isso pode demorar um bom tempo."
echo "Se sua internet é lenta, recomenda-se tomar um café enquanto aguarda."
git clone -b  $ODOO_VERSION.0 https://github.com/odoo/odoo.git ~/odoo

echo "Terminando o arquivo de configuração, quase lá."
rm ~/odoo/odoo-config
echo ""
echo "[options]" >> ~/odoo/odoo-config
echo "addons_path = addons,odoo/addons,~/odoo-brasil" >> ~/odoo/odoo-config
echo "admin_passwd = admin" >> ~/odoo/odoo-config
echo "auto_reload = False" >> ~/odoo/odoo-config
echo "csv_internal_sep = ," >> ~/odoo/odoo-config
echo "db_host = localhost" >> ~/odoo/odoo-config
echo "db_maxconn = 64" >> ~/odoo/odoo-config
echo "db_name = False" >> ~/odoo/odoo-config
echo "db_port = False" >> ~/odoo/odoo-config
echo "db_template = template0" >> ~/odoo/odoo-config
echo "db_user = odoo" >> ~/odoo/odoo-config
echo "db_password = 123" >> ~/odoo/odoo-config

echo "Clonando repositório oficial dos módulos Odoo Brasil no GitHub."
echo "Agora falta pouco."
git clone https://github.com/Trust-Code/odoo-brasil.git ~/odoo-brasil

echo "==== Instalação e configuração Odoo Brasil completa ===="
echo "---- PostgreSQL ---- "
echo ">> Usuário: odoo -- Senha: 123"
echo ">> Usuário: postgres -- Senha = 123"
echo "---- Instância Odoo ----"
echo "Pasta de instalação: ~/odoo"
echo "Pasta de Addons: addons, ~/odoo/addons, ~/odoo-brasil"
echo "========================================================"
echo "A instalação está completa !"
echo "Obrigado por usar este script !!!"
