#!/bin/bash

version="1.0"
count=0
log_file="log.txt"


# Fonction logger action
logger() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" >> ./$log_file
}

# Verification arguments
if [[ "$1" == "-v" || "$1" == "--version" ]]; then
    echo "gestion.sh v ${version}"
    exit 0
elif [[ "$1" == "-h" || "$1" == "--help" ]]; then
	echo ""
	echo "------ HELP ------"
    echo "Utilisation : ./gestion.sh [OPTION]"
    echo "Options disponibles :"
    echo "  -v, --version   Affiche la version du script"
	echo "------------------"
    exit 0
fi

# Verification fichier log
if [ -f ${log_file} ]; then
	echo ""
else
	touch ${log_file}
fi

# Boucle menu
while true; do
	echo ""
    echo "------ MENU ------"
    echo "1. Lister les fichiers du dossier courant"
    echo "2. Créer un nouveau fichier"
    echo "3. Supprimer un fichier"
    echo "4. Afficher le contenu d’un fichier"
    echo "5. Quitter"
    echo "------------------"
	echo ""
    read -p "Choisissez une option (1-5) : " choix

    case $choix in
        1)
            echo "Fichiers dans le dossier courant :"
            ls -lh
            logger "Liste des fichiers affichée"
            ((count++))
            ;;
        2)
            read -p "Entrez le nom du nouveau fichier : " nom_fichier
            if [ -f ./${nom_fichier} ]; then
                echo "Erreur : le fichier existe déjà."
                logger "Échec de création : $nom_fichier existe déjà"
            else
                touch ${nom_fichier}
                echo "Fichier ${nom_fichier} créé."
                logger "Fichier créé : {$nom_fichier}"
                ((count++))
            fi
            ;;
        3)
            read -p "Entrez le nom du fichier à supprimer : " nom_fichier
            if [ -f ./${nom_fichier} ]; then
                rm ./$nom_fichier
                echo "Fichier $nom_fichier supprimé."
                logger "Fichier supprimé : ${nom_fichier}"
                ((count++))
            else
                echo "Erreur : le fichier n'existe pas."
                logger "Échec suppression : ${nom_fichier} n'existe pas"
            fi
            ;;
        4)
            read -p "Entrez le nom du fichier à afficher : " nom_fichier
            if [ -f ./${nom_fichier} ]; then
                echo "Contenu de ${nom_fichier} :"
                cat "$nom_fichier"
                logger "Affichage contenu : ${nom_fichier}"
                ((count++))
            else
                echo "Erreur : le fichier n'existe pas."
                logger "Échec affichage : ${nom_fichier} n'existe pas"
            fi
            ;;
        5)
            echo "Vous avez exécuté ${count} action(s)."
			echo "Au revoir !"
            logger "Script terminé après ${count} action(s)"
            exit 0
            ;;
		egg)
			echo ""
			echo "         .---."
			echo "       .'=^=^='."
			echo "      /=^=^=^=^= "
			echo "     :^=========^;"
			echo "     |^  GG :D  ^|"
			echo "     :^=^=^=^=^=^:"
			echo "       =^=^=^=^=/"
			echo "        .=^=^=.'"
			echo "          --- "
			((count++))
			logger "A trouvé l'oeuf en ${count} coup(s)"
			;;
        *)
            echo "Option invalide. Veuillez choisir entre 1 et 5."
            ;;
    esac
done
