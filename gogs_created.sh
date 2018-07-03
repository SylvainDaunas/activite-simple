#!/bin/bash
#---------------------------------------------------------------------#
#@(#) SCRIPT : gogs_created.sh
#---------------------------------------------------------------------#
#@(#) Fonction             : Script permettant la creation auto depot gogs
#@(#) Auteur               : DEA Bourges
#@(#) Parametres d'entree  :
#@(#) Parametres de sortie :
#@(#) Retour               : 0=Ok, Sup a 0=Erreur
#@(#) Scripts appeles      : Script du PDIS modifie pour nos besoins
#---------------------------------------------------------------------#
#	1.00	SDS + RLL 	27/04/18	 Version initiale
#---------------------------------------------------------------------#

#---------------------------------------------------------------------#
# Variables
#---------------------------------------------------------------------#
#NNIADM=""
#NNIRW=""
#NNIR=""
#NNILIST="$NNIADM $NNIRW $NNIR"
#APPLICATION=""
#NAME_DEPOT="dep_$APPLICATION"
#DESCRIPTION_DEPOT="Dépôt pour l'application $APPLICATION"
clear

f_saisie_depot(){
	echo "             loading ..."
	sleep 0.3
	echo -e " \033[34m#######################################\033[0m"
	sleep 0.3
	echo -e " \033[34m##     _____  ____   _____  _____    ##\033[0m"
	sleep 0.3
	echo -e " \033[34m##    / ____|/ __ \ / ____|/ ____|   ##\033[0m"
	sleep 0.3
	echo " ##   | |  __| |  | | |  __| (___     ##"
	sleep 0.3
	echo " ##   | | |_ | |  | | | |_ |\___ \    ##"
	sleep 0.3
	echo " ##   | |__| | |__| | |__| |____) |   ##"
	sleep 0.3
	echo -e " \033[31m##    \_____|\____/ \_____|_____/    ##\033[0m"
	sleep 0.3
	echo -e " \033[31m##                                   ##\033[0m"
	sleep 0.3
	echo -e " \033[31m#######################################\033[0m"
	sleep 0.3
	echo ""
	
	echo "Création du dépot, déclaration du NOM (uniquement) sans le dep_ :"
	printf "Votre choix ? : " 
	read APPLICATION
	if [[ -z $APPLICATION ]]; then
		echo "Erreur de saisie, merci de remplir le champ"
		sleep 2
		clear
		f_saisie_depot
	fi
	APPLICATION=$(echo $APPLICATION | tr '[:lower:]' '[:upper:]')
	NAME_DEPOT="dep_$APPLICATION"
	DESCRIPTION_DEPOT="Dépôt pour l'application $APPLICATION"
	Depot_test=""
	Depot_test=$(curl --insecure --silent -X GET https://${URL}/api/v1/users/AdminAEI/repos?token=${TOKEN} | grep -icw "$NAME_DEPOT" )
	if [[ -z $Depot_test ]]; then
		echo "Problème de communication avec le serveur"
		exit
	elif [[ $Depot_test -eq 1 ]];then
		echo "Erreur depot deja existant : $NAME_DEPOT"
	else
		f_saisie_organisation
	fi	
}	
