#!/bin/bash

#################################################################################
#                                                                               
#                       Exercício 5                                           	
# Crie um script que gere um arquivo compactado de backup de todo o diretório
# home do usuário atual (/home/<usuario>).
# Considere que:
# • O arquivo de backup será criado no diretório /home/<usuario>/Backup
# • O nome do arquivo de backup deve seguir o padrão backup_home_AAAAMMDDHHMM.tgz, exemplo
# 		backup_home_201708241533.tgz
# • Caso o diretório /home/<usuario>/Backup não exista, o script deve criá-lo
# • Antes de criar o backup, o script deve consultar se existe algum arquivo
# de backup criado na última semana. Se exisitir, o usuário deve ser
# consultado se deseja continuar. Se o usuário optar por não continuar, o
# script deve abortar com código de saída 1.
# • Após gerar o backup, o script deve informar o nome do arquivo gerado.					
#                                                                               
# Autor: Mateus Silva (mateushls01@gmail.com)                                   
#                                                                               
# Data Criação: 3/04/2022                                                       
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






