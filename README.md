# Backup


Script responsável por gerar um backup do diretorio /home no formato tgz acada vez que o computador for ligado!
O backup será colocado em um disco separado.

Para fazer funcionar deve-se seguir os seguintes passos.
---
Clonar o repositorio no diretorio /opt do sistema.
```
sudo su
cd /opt; git clone https://github.com/mateushlsilva/backup.git
```
Depois deve-se alterar a variavel `USU` do arquivo `backup.sh`.
```
nano backup.sh
```
Trocar o caminho `/media/mateus/hd300/bakup` pelo o caminho do seu disco secundario.

Depois rodar os seguintes comandos:
```
chmod +x *
./service.sh
```
