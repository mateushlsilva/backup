#!/bin/bash

#################################################################################
#                                                                               
#                       Backup                                           	
# Esse script vai compactar o diretorio home, em um formato tgz.
# O nome do arquivo de backup segue o padrão backup_home_AAAAMMDDHHMM.tgz 
# O arquivo backup_home_AAAAMMDDHHMM.tgz será colocado em um disco secundário.
# 					
#                                                                               
# Autor: Mateus Silva (mateushls01@gmail.com)                                   
#                                                                               
# Data Criação: 13/12/2022                                                       
#                                                                               
#################################################################################

criaDiretorio(){
	if [ ! -d $1 ]
	then
		echo "Criando Diretório $1"
		mkdir -p $1
	fi
	if [ ! -d /opt/backup/ ]
	then
		sudo mkdir -p /opt/backup/
	fi
}

remove5Dias(){
	DAYS5=$(find $1 -name backup_home\*tgz | grep -c tgz)
	if [ $DAYS5 -gt 4 ]
	then
		DATAD=$(date +%d)
		if [ $(expr $DATAD - 4) -lt 10 ]
		then
			CAL=0$(expr $DATAD - 4) 
		else
			CAL=$(expr $DATAD - 4)
		fi
		cd $1
		rm -rf  backup_home_??????$CAL*.tgz
	fi
}

criaBackup(){
	echo "Criando Backup ... $2" >> /opt/backup/log.out
	tar zcvpf $1/$2 --absolute-names --exclude="$3/Downloads" --exclude="$3/.*" --exclude="$3/Lixeira" --exclude="$1" "$3"/* > /dev/null
	echo "O backup de nome \""$2"\" foi criado em $1" >> /opt/backup/log.out
}

USU=/media/mateus/hd300/bakup
DATA=$(date +%Y%m%d%H%M)
ARQ=backup_home_"$DATA".tgz
HOMEUSER=/home/*


criaDiretorio $USU
remove5Dias $USU
criaBackup $USU $ARQ $HOMEUSER






