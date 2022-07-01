#!/bin/sh

# Onde os backups ficarão salvos?
TOGENERATE="/backup_hdd/backups"

# Servidor de destino
HOST="da2.srvhr.com.br"
USUARIO="root"
CHAVESSH="/root/.ssh/FW"
PORTA="22022"

#####################################################################################
######################## Abaixo já está tudo pronto #################################

# Migrando os revendedores antes de tudo....
for a in `cat /usr/local/directadmin/data/admin/reseller.list`; do
 echo "Gerando backup do Revendedor: $a";
 /usr/local/directadmin/directadmin admin-backup --destination=${TOGENERATE} --user=$a;

 echo "Enviando para destino...";
 rsync -avzhe 'ssh -p ${PORTA} -i ${CHAVESSH}' ${TOGENERATE}/reseller.admin.$a.tar.gz ${USUARIO}@${HOST}:/home/admin/admin_backups/;
 ssh -p ${PORTA} -i ${CHAVESSH} ${USUARIO}@${HOST} 'chown -R admin:admin /home/admin/admin_backups';

 echo "Arquivo enviado e adicionado à fila de restauração."
 ssh -p ${PORTA} -i ${CHAVESSH} ${USUARIO}@${HOST} "/bin/sh /root/Restore.sh admin ${a}";

 echo "---------------------------------------------------"
 rm -rf ${TOGENERATE}/reseller.admin.$a.tar.gz;
 sleep 10;
done;

echo "Pausa para o café e o servidor de destino respirar... (300s)"; sleep 300; echo "Café tomado.. vamos retomar.."

# Migrando os clientes das revendas...
for i in `cat /usr/local/directadmin/data/admin/reseller.list`; do
 echo "------------------------------------------";
 echo "Gerando backup dos clientes da Revenda: $i";

# Inicia o backup dos clientes da revenda
 for b in `cat /usr/local/directadmin/data/users/$i/users.list`; do
  echo "Gerando backup de $b";
  /usr/local/directadmin/directadmin admin-backup --destination=${TOGENERATE} --user=${b};
  sleep 5;

  echo "Enviando para destino...";
  rsync -avzhe 'ssh -p ${PORTA} -i ${CHAVESSH}' ${TOGENERATE}/user.$i.$b.tar.gz ${USUARIO}@${HOST}:/home/admin/admin_backups/;
  ssh -p ${PORTA} -i ${CHAVESSH} ${USUARIO}@${HOST} 'chown -R admin:admin /home/admin/admin_backups';

  ssh -p ${PORTA} -i ${CHAVESSH} ${USUARIO}@${HOST} "/bin/sh Restore.sh ${i} ${b}";
  echo "Backup está no destino e irá iniciar a restauração em breve";
  sleep 10;

  rm -rf ${TOGENERATE}/user.$i.$b.tar.gz;
 done;
# Fim do backup dos clientes da revenda

 echo "Arquivos da revenda $i foram movidos. Nova pausa para o café (300s)...";
 echo "------------------------------------------";
 sleep 300;
done
