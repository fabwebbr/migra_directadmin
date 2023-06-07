#!/bin/sh

# Qual revendedor será migrado?
REVENDA="xyz"

# Onde os backups ficarão salvos?
TOGENERATE="/home/admin/admin_backups/"

# Servidor de destino
HOST="da2.srvhr.com.br"
USUARIO="root"
CHAVESSH="/root/.ssh/FW"
PORTA="22022"

#####################################################################################
######################## Abaixo já está tudo pronto #################################

# Migrando a conta principal do revendedor....
 echo "Gerando backup do Revendedor: $REVENDA";
 /usr/local/directadmin/directadmin admin-backup --destination=${TOGENERATE} --user=$REVENDA;

 echo "Enviando para destino...";
 rsync -avzhe "ssh -p ${PORTA} -i ${CHAVESSH}" ${TOGENERATE}/reseller.admin.$REVENDA.tar.gz ${USUARIO}@${HOST}:/home/admin/admin_backups/;
 ssh -p ${PORTA} -i ${CHAVESSH} ${USUARIO}@${HOST} "chown -R admin:admin /home/admin/admin_backups";

 echo "Arquivo enviado para o destino e já pode ser restaurado"

 echo "---------------------------------------------------"
 rm -rf ${TOGENERATE}/reseller.admin.$REVENDA.tar.gz;
 sleep 10;

echo "Pausa para o café e o servidor de destino respirar... (60s)"; sleep 60; echo "Café tomado.. vamos retomar.."

# Migrando os clientes das revendas...
 echo "------------------------------------------";
 echo "Gerando backup dos clientes da Revenda: $REVENDA";

# Inicia o backup dos clientes da revenda
 for b in `cat /usr/local/directadmin/data/users/$REVENDA/users.list`; do
  echo "Gerando backup de $b";
  /usr/local/directadmin/directadmin admin-backup --destination=${TOGENERATE} --user=${b};
  sleep 5;

  echo "Enviando para destino...";
  rsync -avzhe "ssh -p ${PORTA} -i ${CHAVESSH}" ${TOGENERATE}/user.$i.$b.tar.gz ${USUARIO}@${HOST}:/home/admin/admin_backups/;
  ssh -p ${PORTA} -i ${CHAVESSH} ${USUARIO}@${HOST} 'chown -R admin:admin /home/admin/admin_backups';

  ssh -p ${PORTA} -i ${CHAVESSH} ${USUARIO}@${HOST} "/bin/sh Restore.sh ${i} ${b}";
  echo "Backup está no destino e irá iniciar a restauração em breve";
  sleep 10;

  rm -rf ${TOGENERATE}/user.$i.$b.tar.gz;
 done;
# Fim do backup dos clientes da revenda

 echo "Arquivos da revenda $REVENDA foram movidos.";
 echo "------------------------------------------";
