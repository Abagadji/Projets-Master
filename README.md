#NOTES
#git config --global --list pour connaître les infos sur ton git email et nom #**\*\*\*\***\_\_\_**\*\*\*\*** --mail #**\*\*\*\***\_\_\_**\*\*\*\*** --name

comment versionner en local ?

#1- git add. copie tous les fichiers et les mets en zone d'attente ou zone d'index, mais ne sauvegarde pas.
#2- git commit -m "message" > il est important de mettre un bon message, car si on code beaucoup, plus on fait des sauvegarde, plus il faut mettre de bonnes explications pour se retrouver et on pourra mieux se retrouver dans nos commit.
#3- git status permet de savoir quels sont les fichiers qui sont en zone d'attente et ceux qui ont été modifiés
pour coder depuis git bash c'est "code ." et ca ouvre l'éditeur de code
#4- git log permet de gérer les commit ou voir les commit
#5- git checkout sha-1 permet de revenir à une version précédente (il ne faut pas oublier de copier le numéro du commit qui est représenté ini par "sha-1")
#6- git checkout master si ont veut revenir à la version la plus récente

#Comment versionner sur un dépôt distant ?
#interface github
#créer un new repository en lui donnant un name. Quand on crée un repository, on nous donne un lien.

#Comment exploiter ce lien ?
#on peut fait un git clone + le lien qui nous a été donné, cela récupère le repository depuis le dépôt distant. en faisant ca dans le git bash, un dossier va être crée au nom du repository. Dans ce dossier, on aura déjà un git init. Toutes les sauvegardes seront gérées par ce git init.
#1- git add.
#2- git commit -m "message"
#3- git push u- origin master ou main

git add. ajoute tous les fichiers pour un commit, on peut préciser quel fichier a été doit être ajouté. Pour le faire on fait git add +fichier que l'on veut mettre en commit.

si on veut rajouter tous les fichiers html par exemple, sans nommer tous les fichiers on peut faire "git add "\*.html"
Ou git add --all

si l'on veut ignorer certains fichiers, on peut se créer un fichier "touch .gitignore" et on liste à l'intérieur ce qu'on souhaite : _.tmp (pour une extension) ; log.txt (pour un fichier) ; tmp/_ (pour un dossier)
