#! /bin/bash

ODOO_VERSION='11'

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
sudo apt install python3-dev -y
echo "Pacote python-dev instalado"

echo "Instalando gcc"
sudo apt install gcc -y
echo "Pacote gcc instalado"

echo "Criando usuário postgreSQL ..."
sudo -u postgres -- psql -c "ALTER USER postgres WITH PASSWORD '123';"
sudo -u postgres -- psql -c "DROP ROLE odoo;"
sudo -u postgres -- psql -c "CREATE ROLE odoo LOGIN ENCRYPTED PASSWORD 'md5f7b7bca97b76afe46de6631ff9f7175c' NOSUPERUSER INHERIT CREATEDB CREATEROLE REPLICATION"
sudo -u postgres -- createdb v11dev

echo "==== Instalando dependências Odoo ===="
sudo apt-get install -y --no-install-recommends $(grep -v '^#' apt-requirements)

echo "==== Instalação dependências pip para os módulos ===="

if [ $ODOO_VERSION == '10' ]
then

    echo "======== Caso a versão a versão seja odoo 10 ========"
    echo "============= Virtualenv 2.7 será criado ============"

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
    pip install urllib3
    pip install pytrustnfe
    pip install python-boleto
    pip install python-cnab
    pip install wheel

elif [ $ODOO_VERSION == '11' ]
then
    echo "======== Caso a versão a versão seja odoo 11 ========"
    echo "============= Virtualenv 3.5 será criado ============"

    mkdir ~/odooenv35
    sudo apt install python3-pip -y
    sudo pip3 install virtualenv
    cd ~/odooenv35
    mkdir envpacks
    cd envpacks

    virtualenv -p /usr/bin/python3.5 ~/odooenv35/ve
    source ~/odooenv35/ve/bin/activate
    # Odoo
    pip3 install Babel==2.3.4
    pip3 install decorator==4.0.10
    pip3 install docutils==0.12
    pip3 install ebaysdk==2.1.4
    pip3 install feedparser==5.2.1
    pip3 install gevent==1.1.2
    pip3 install greenlet==0.4.10
    pip3 install html2text==2016.9.19
    pip3 install Jinja2==2.8
    pip3 install lxml==4.2.3
    pip3 install Mako==1.0.4
    pip3 install MarkupSafe==0.23
    pip3 install mock==2.0.0
    pip3 install num2words==0.5.4
    pip3 install ofxparse==0.16
    pip3 install passlib==1.6.5
    pip3 install Pillow==3.4.1
    pip3 install psutil==4.3.1
    pip3 install psycogreen==1.0
    pip3 install psycopg2==2.7.1
    pip3 install pydot==1.2.3
    pip3 install pyldap==2.4.28
    pip3 install pyparsing==2.1.10
    pip3 install PyPDF2==1.26.0
    pip3 install pyserial==3.1.1
    pip3 install python-dateutil==2.5.3
    pip3 install python-openid==2.2.5
    pip3 install pytz==2016.7
    pip3 install pyusb==1.0.0
    pip3 install PyYAML==3.12
    pip3 install qrcode==5.3
    pip3 install reportlab==3.3.0
    pip3 install requests==2.11.1
    pip3 install six==1.10.0
    pip3 install suds-jurko==0.6
    pip3 install vatnumber==1.2
    pip3 install vobject==0.9.3
    pip3 install Werkzeug==0.11.11
    pip3 install XlsxWriter==0.9.3
    pip3 install xlwt==1.3.*
    pip3 install xlrd==1.0.0
    pip3 install phonenumbers==8.8.11

    # odoo-brasil
    pip3 install suds-jurko-requests
    pip3 install xmlsec

    # trustcode-addons
    pip3 install boto3>=1.5.12
    pip3 install plotly==2.4.1
    pip3 install pandas==0.19.2
    pip3 install relatorio==0.6.4
    pip3 install urllib3==1.22
    pip3 install pyopenssl==17.2.0
    pip3 install num2words==0.5.6
    pip3 install twilio
    pip3 install pika==0.12.0
    pip3 install iugu
    #Versão que roda em python3 não está no repo oficial. Git it
    git clone https://github.com/ghyde/jcconv
    cd jcconv
    python setup.py install
    cd ..
    #pip3 install suds_requests
    git clone https://github.com/armooo/suds_requests
    cd suds_requests/
    python setup.py install
    cd ..
    pip3 install urllib3
    #pip3 install pytrustnfe
    git clone https://github.com/danimaribeiro/PyTrustNFe
    cd PyTrustNFe/
    python setup.py install
    cd ..
    git clone https://github.com/Trust-Code/PyTrustCnab240.git
    cd PyTrustCnab240
    python setup.py install
    cd ..
    pip3 install python3-boleto
    pip3 install python3-cnab
    pip3 install wheel
    sudo npm install -g less
fi



echo ">>> pip e seus requerimentos estão instalados. <<<"

echo "Clonando repositório oficial Odoo no GitHub. Isso pode demorar um bom tempo."
echo "Se sua internet é lenta, recomenda-se tomar um café enquanto aguarda."
git clone --depth 1 https://github.com/odoo/odoo.git ~/odoo
cd ~/odoo
git checkout $ODOO_VERSION.0


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
cd ~/odoo-brasil
git checkout $ODOO_VERSION.0

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
echo "iniciar o sistema com os comandos"
if [ $ODOO_VERSION == '10' ]
then
    echo "source ~/odooenv27/ve/bin/activate"
    echo "cd ~/odoo-brasil"
    echo "git checkout $ODOO_VERSION.0"
    echo "cd ~/odoo"
    echo "git checkout $ODOO_VERSION.0"
    echo "./odoo-bin --config=odoo-config"
elif [ $ODOO_VERSION == '11' ]
then
    echo "source ~/odooenv35/ve/bin/activate"
    echo "cd ~/odoo-brasil"
    echo "git checkout $ODOO_VERSION.0"
    echo "cd ~/odoo"
    echo "git checkout $ODOO_VERSION.0"
    echo "./odoo-bin --config=odoo-config -d v11dev"
fi
