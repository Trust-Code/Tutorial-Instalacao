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


# 2º Passo - Baixar as dependencias do Odoo

* Baixar o arquivo [dependencias apt-get](apt-requirements)
* Baixar o arquivo [dependencias pip](pip-requirements)
* sudo apt-get install -y --no-install-recommends $(grep -v '^#' apt-requirements)




# 3º Passo - Baixar o código do Odoo


# 4º Passo - Rodar o Odoo
