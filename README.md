# Tutorial Instalação para Desenvolvedores


# 1º Passo - Instalar o Postgres

- Atualizar o sistema antes de tudo
    * sudo apt-get update

- Instalar o postgresql
    * sudo apt-get install postgresql
    * sudo apt-get install pgadmin3

- Criar usuários
    * sudo su postgres
    * psql
    * alter user postgres with password '123';
    * Acessar o pgadmin com o usuário postgres e criar um usuário para o Odoo por lá


# 2º Passo - Baixar as dependências do Odoo

* Baixar o arquivo [dependencias apt-get](apt-requirements)
* Baixar o arquivo [dependencias pip](pip-requirements)
* sudo apt-get install -y --no-install-recommends $(grep -v '^#' apt-requirements)
* sudo pip install --upgrade pip
* sudo pip install -r pip-requirements
* sudo npm install -g less
* wget http://download.gna.org/wkhtmltopdf/0.12/0.12.1/wkhtmltox-0.12.1_linux-trusty-amd64.deb
* sudo dpkg -i wkhtmltox-0.12.1_linux-trusty-amd64.deb


# 3º Passo - Baixar o código do Odoo

* git clone https://github.com/odoo/odoo.git

# 4º Passo - Rodar o Odoo
