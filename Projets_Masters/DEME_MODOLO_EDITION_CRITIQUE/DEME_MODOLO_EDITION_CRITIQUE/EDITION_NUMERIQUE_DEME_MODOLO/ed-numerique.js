//Fichier crée par Ada Desideri
//dans le cadre d'un mémoire de M2 à l'Université de Lille
//sous la direction de Camilla Cederna, Nathalie Gasiglia, Antonietta Sanna e Angelo Mario del Grosso
//
//->> Script pour la gestion de l'interactivité de l'édition numérique de "Une étrange aventure" <<-
// - roman de science ficti†on inédit d'Elisa Chimenti -


//variable pour sauvegarder les définitions qui apparaissent dans le carré "visualisation des notes", et pour éventuellement les conter
var glossaireDinamique = [];  // >> tableau pour stocker les mots définis récemment dans le glossaire dynamique

//variable pour sauvegarder les type de mots dont on a déjà affiché la liste dans le carré "listes mots", et pour éventuellement les conter
var listesMots = [];  // >> tableau pour éviter de réafficher une même liste de mots plusieurs fois

//fonction qui vérifie s'il existe un noued dans l'arbre html qui a comme identifiant "id"
function noeudExiste(id){
    var exists = document.getElementById(id);  // >> recherche du noeud HTML par son ID
    if (exists != null) return true;  // >> retourne vrai si l'élément existe
    else return false;  // >> sinon retourne faux
}
   
//fonction qui affiche la transcription diplomatique
function afficheDiplo(){
    if (document.getElementById("texte-diplo").getAttribute("hidden") == "hidden") {
        document.getElementById("texte-diplo").removeAttribute("hidden");  // >> rend visible le texte diplomatique
    }
    document.getElementById("texte-lecture").setAttribute("hidden", "hidden");  // >> masque le texte de lecture
 
    document.getElementById('nav-lect').setAttribute("hidden",'hidden');  // >> masque la navigation
    document.getElementById('glossaire-p').setAttribute("hidden",'hidden');  // >> masque le glossaire
    document.getElementById('colonne-mots').setAttribute("hidden",'hidden');  // >> masque la colonne de mots
}
  
//fonction qui affiche la transcription de lecture
function afficheLecture(){
    if (document.getElementById("texte-lecture").getAttribute("hidden") == "hidden") {
        document.getElementById("texte-lecture").removeAttribute("hidden");  // >> rend visible le texte de lecture
    }
    document.getElementById("texte-diplo").setAttribute("hidden", "hidden");  // >> masque le texte diplomatique
    /* document.getElementById("texte-trad").setAttribute("hidden", "hidden");*/
    document.getElementById('nav-lect').removeAttribute("hidden");  // >> affiche la navigation
    document.getElementById('glossaire-p').removeAttribute("hidden");  // >> affiche le glossaire
    document.getElementById('colonne-mots').removeAttribute("hidden");  // >> affiche la colonne des mots
}

// fonction qui transforme une chaine en une chaine où aucun "<" n'apparaît
function estraireItem(texte){
    var item = "";
    for (i in texte){
        if(texte[i] != "<") item += texte[i];  // >> ajoute les caractères tant que "<" n’est pas rencontré
        else return item;  // >> retourne l’item dès qu’un "<" est détecté
    }
}

//fonction pour faire la place au nouvel élément à ajouter dans le tableau glossaire dinamique
function deplaceElementsTab(glossaireDinamique){
    for(i=glossaireDinamique.length;i>0;i--)
        glossaireDinamique[i] = glossaireDinamique[i-1];  // >> décale chaque élément d’une position vers la droite
}

//fonction pour ajouter un élément au tableau glossaire dinamique
function ajouteElementTab(glossaireDinamique, i){
    //on vérifie que dans le glossaire il y a moins que 3 éléments...
    if(glossaireDinamique.length<2){
        //...on déplace simplement les éléments et on ajoute le nouveau
        deplaceElementsTab(glossaireDinamique)
        glossaireDinamique[0] = i;  // >> insère l’élément en tête de liste
    }
    //sinon d'abord on enlève le premier élément et ensuite on déplace les autres éléments et on ajoute le nouveau
    else{
        glossaireDinamique.pop();  // >> supprime l’élément le plus ancien
        deplaceElementsTab(glossaireDinamique)
        glossaireDinamique[0] = i;  // >> insère le nouvel élément en tête
    }
}

//fonction pour afficher un nouvel élément dans le glossaire dinamique
function ajouteElementGlossaireDin(texteDict, i){
    //on cree un text node 
    var texteN = document.createTextNode(texteDict);  // >> crée le contenu textuel
    // on cree le paragraphe 
    var par = document.createElement('p');  // >> crée un nouveau paragraphe
    //on donne le meme id que l'élément "a" précédé par "par" au paragraphe et on ajoute un attribut
    par.setAttribute("id", "par"+i);
    par.setAttribute('class', 'historique');
    //on accroche le texte au paragraphe
    par.appendChild(texteN);
    //on accroche le paragraphe au menu
    document.getElementById("glossaire-perso").insertBefore(par, document.getElementById("glossaire-perso").firstChild);  // >> insère en haut du glossaire
}
  
//fonction pour afficher une définition dans le glossaire dinamique
function Dictionnaire(oggetto){
    var i = oggetto.id;  // >> récupère l’id de l’élément cliqué
    if(glossaireDinamique.includes(i)) return;  // >> ne rien faire si la définition est déjà affichée
    ajouteElementTab(glossaireDinamique, i);  // >> ajoute l’id dans le tableau du glossaire
    var iDef = "def" + i;  // >> construit l’id du span contenant la définition
    var item = document.getElementById("item"+i).innerHTML;  // >> récupère le mot
    var def = document.getElementById(iDef).innerHTML;  // >> récupère la définition
    var texteDict = item + " : " + def;  // >> formatage mot : définition
    
    if(glossaireDinamique.length<2){
        ajouteElementGlossaireDin(texteDict, i);  // >> ajoute directement si pas encore 2 éléments
    }
    else{
        document.getElementById("glossaire-perso").removeChild(document.getElementById("glossaire-perso").lastChild);  // >> retire le plus ancien
        ajouteElementGlossaireDin(texteDict, i);  // >> insère le nouveau
    }
}

//***********************************/
//************************************ SOUSLIGNAGE DES MOTS ET DES BORNES */

//fonction pour souligner les noms propres de personnages
function sousligne_nom_propre_pers(){
    var personnages = document.getElementsByClassName('nom.propre.personnage')
    if(personnages[0].hasAttribute('style') && personnages[0].style.backgroundColor != 'inherit'){
        for(let e of personnages){
            e.style.backgroundColor = 'inherit';  // >> supprime la coloration
            e.style.fontStyle = 'inherit';  // >> style par défaut
            e.style.fontWeight ='normal';  // >> police normale
        }
    }
    else{
        for(let e of personnages){
            e.style.backgroundColor = '#D46A6A';  // >> applique une couleur de fond
            e.style.fontWeight = 'bold';  // >> texte en gras
        }
    }
    creer_liste_mots("Noms propres", personnages);  // >> crée une liste avec les noms trouvés
}

//fonction appelée pour souligner les personnages
function sousligne_pers(){
    sousligne_nom_propre_pers();  // >> redirige vers la fonction précédente
}

//fonction pour souligner les lieux et afficher les régions associées
function sousligne_lieux(){
    var lieux = document.getElementsByClassName('lieu')
    var regions = document.getElementsByClassName('region')
    if(lieux[0].hasAttribute('style') && lieux[0].style.backgroundColor != 'inherit'){
        for(let e of lieux){
            e.style.backgroundColor = 'inherit';  // >> réinitialise le style
        }
        for(let e of regions){
            e.setAttribute('hidden','hidden');  // >> masque les régions
            e.style.backgroundColor = 'inherit';
        }
    }
    else{
        for(let e of lieux){
            e.style.backgroundColor = '#407F7F';  // >> couleur pour les lieux
        }
        for(let e of regions){
            e.removeAttribute('hidden')  // >> affiche les régions
            e.style.backgroundColor = '#003333';  // >> couleur sombre
            e.style.color = 'white';  // >> texte blanc
        }
    }
    creer_liste_mots("Lieux", lieux);  // >> crée une liste avec les lieux
}

//fonction qui crée une liste avec les mots selectionnés avec un bouton, et qui les fait apparaître dans le carré Listes de mots
function creer_liste_mots(titre, tableau){
    if(listesMots.includes(titre)) return;  // >> ne fait rien si la liste est déjà créée
    else{
        listesMots.push(titre);  // >> ajoute le titre pour le suivi
        var t = document.createTextNode(titre);
        var h2 = document.createElement('h2');
        h2.setAttribute('class','h2_listes')
        h2.appendChild(t);

        var h3 = document.createElement('h3');
        var texte_nb = document.createTextNode("Nombre d'éléments : " + tableau.length );
        h3.appendChild(texte_nb);

        var list = document.createElement('ul');
        for(let e of tableau){
            let txt = document.createTextNode(e.innerHTML);
            let item = document.createElement('li');
            item.appendChild(txt);
            list.appendChild(item);
        }
        document.getElementById('div-listes').insertBefore(list, document.getElementById('div-listes').firstChild)
        document.getElementById('div-listes').insertBefore(h3, document.getElementById('div-listes').firstChild)
        document.getElementById('div-listes').insertBefore(h2, document.getElementById('div-listes').firstChild)
    }
}

//fonction pour éliminer toutes les listes de mots affichées
function nettoye_listes(){
    var div = document.getElementById('div-listes')
    var h2s = div.getElementsByTagName('h2')
    while(h2s.length > 0){
        document.getElementById('div-listes').removeChild(h2s[0]);  // >> supprime tous les titres
    }
    var listes = div.getElementsByTagName('ul')
    while(listes.length > 0){
        document.getElementById('div-listes').removeChild(listes[0]);  // >> supprime toutes les listes
    }
    listesMots=[];  // >> vide le tableau de contrôle
}
