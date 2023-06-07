## migra_directadmin
Script em sh para gerar o backup dos arquivos de uma revenda e seus clientes para servidor Directadmin novo.
Você precisa ter um mínimo de conhecimento para usar este script

## Sobre o uso
GerarBackup.sh -> Deixar em uma pasta de sua preferência no servidor de origem

-> Todos os backups serão gerados pelo GerarBackup.sh e enviados para a pasta /home/admin/admin_backups;
-> O script vai gerar o backup de todos os revendedores do DirectAdmin, enviá-los para o novo servidor e você deve restaurar manualmente no destino
-> Você precisa gerar uma chave para acesso SSH

# Antes do uso
## Editar o seguinte em GerarBackup.sh

TOGENERATE="/backups" -> Caminho onde o arquivo de backup será gerado no servidor local

HOST="server.suaempresa.tld" -> Servidor de destino

USUARIO="root" -> Usuário para o SSH

CHAVESSH="/root/.ssh/chave_rsa" -> Caminho para a chave SSH

PORTA="22022" -> Porta SSH

## Após editar
-> Recomendo abrir uma screen no servidor de origem (Instale com 'apt install screen -y' ou 'yum install screen -y' e depois execute 'screen -S migracao');
-> Execute o script GerarBackup.sh (Ex: /bin/sh /root/GerarBackup.sh) dentro da screen;
-> Seja feliz (eu acho).

## Recomendação
-> Acompanhe o servidor de destino para ter certeza de que tudo está ok.

-----> Use por sua conta e risco <-----
