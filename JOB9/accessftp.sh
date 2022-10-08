#!/bin/bash


while IFS="," read -r id prenom nom mdp role
do
   #mettre le nom en minuscule
   username=${prenom,,}
   #suppression des spaces
   username=$(echo $username | sed 's/ //g') 
   
   if [[ $1 = "-s" ]]; then
  	sudo userdel $username
   	sudo rm -r "/home/$username"   
   	printf "\x1b[31m- utilisateur supprimer: $username \x1b[0m\n"
   else
      #creation dun utilisateur avec id, prenom et mot de passe
      sudo useradd -m -u $id $username  
      #Si l’utilisateur est un admin, donnez-lui le rôle de super utilisateur de votre système
      if [[ $role = "Admin" ]]; then
         sudo usermod -aG sudo $username
         sudo usermod -aG nogroup $username
      fi
      
      #donner une couleur specifique
      printf "\x1b[32m+ nouvel utilisateur:$prenom $nom\x1b[0m\n"  
   fi
done < <(tail -n +2 'Shell_Userlist.csv')
