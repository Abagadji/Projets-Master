//Fichier crée par Ada Desideri
//dans le cadre d'un mémoire de M2 à l'Université de Lille
//sous la direction de Camilla Cederna, Nathalie Gasiglia, Antonietta Sanna e Angelo Mario del Grosso
//
//->> Script pour la gestion de l'interactivité de l'édition numérique de "Une étrange aventure" <<-
// - roman de science ficti†on inédit d'Elisa Chimenti -
//


//variable pour sauvegarder les définitions qui apparaissent dans le carré "visualisation des notes", et pour éventuellement les conter
var glossaireDinamique = [];

//variable pour sauvegarder les type de mots dont on a déjà affiché la liste dans le carré "listes mots", et pour éventuellement les conter
var listesMots = [];

//fonction qui vérifie s'il existe un noued dans l'arbre html qui a comme identifiant "id"
function noeudExiste(id){
    var exists = document.getElementById(id);
    if (exists != null) return true;
    else return false;
}
   
//fonction qui affiche la transcription diplomatique
function afficheDiplo(){
    if (document.getElementById("texte-diplo").getAttribute("hidden") == "hidden") {
        document.getElementById("texte-diplo").removeAttribute("hidden");
    }
    document.getElementById("texte-lecture").setAttribute("hidden", "hidden");
 
    document.getElementById('nav-lect').setAttribute("hidden",'hidden');
    document.getElementById('glossaire-p').setAttribute("hidden",'hidden');
    document.getElementById('colonne-mots').setAttribute("hidden",'hidden');
}
  

//fonction qui affiche la transcription de lecture
function afficheLecture(){
    if (document.getElementById("texte-lecture").getAttribute("hidden") == "hidden") {
        document.getElementById("texte-lecture").removeAttribute("hidden");
    }
    document.getElementById("texte-diplo").setAttribute("hidden", "hidden");
   /*  document.getElementById("texte-trad").setAttribute("hidden", "hidden");*/
    document.getElementById('nav-lect').removeAttribute("hidden");
    document.getElementById('glossaire-p').removeAttribute("hidden");
    document.getElementById('colonne-mots').removeAttribute("hidden");
}
// fonction qui transforme une chaine en une chaine où aucun "<" n'apparaît
function estraireItem(texte){
    var item = "";
    for (i in texte){
    if(texte[i] != "<") item += texte[i];
    else return item;
    }
}

//fonction pour faire la place au nouvel élément à ajouter dans le tableau glossaire dinamique
function deplaceElementsTab(glossaireDinamique){
    for(i=glossaireDinamique.length;i>0;i--)
        glossaireDinamique[i] = glossaireDinamique[i-1]
}

//fonction pour ajouter un élément au tableau glossaire dinamique
function ajouteElementTab(glossaireDinamique, i){
    //on vérifie que dans le glossaire il y a moins que 3 éléments...
    if(glossaireDinamique.length<2){
        //...on déplace simplement les éléments et on ajoute le nouveau
        deplaceElementsTab(glossaireDinamique)
        glossaireDinamique[0] = i;
    }
    //sinon d'abord on enlève le premier élément et ensuite on déplace les autres éléments et on ajoute le nouveau
    else{
        glossaireDinamique.pop();
        deplaceElementsTab(glossaireDinamique)
        glossaireDinamique[0] = i;
    }
}

//fonction pour afficher un nouvel élément dans le glossaire dinamique
function ajouteElementGlossaireDin(texteDict, i){
    //on cree un text node 
    var texteN = document.createTextNode(texteDict);
    // on cree le paragraphe 
    var par = document.createElement('p');
    //on donne le meme id que l'élément "a" précédé par "par" au paragraphe et on ajoute un attribut
    par.setAttribute("id", "par"+i);
    par.setAttribute('class', 'historique');
    //on accroche le texte au paragraphe
    par.appendChild(texteN);
    //on accroche le paragraphe au menu
    document.getElementById("glossaire-perso").insertBefore(par, document.getElementById("glossaire-perso").firstChild);
}
  
//fonction pour afficher une définition dans le glossaire dinamique
//cette fonction est appelée lors d'un onclick sur un élément a, qui contient un span, qui contient le mot (ou le numero de note culturelle) dont on veut donner la définition. L'élément "a" a un attribut id liée de manière unique avec le mot, et le span a un attribut id qui a la forme "item"+id de l'élément "a"
function Dictionnaire(oggetto){
        //on récupère l'identifiant de l'élément "a"
        var i = oggetto.id;
        //si le tableau du glossaire contient déjà cet identifiant, on ne fait rien
        if(glossaireDinamique.includes(i)) return;
        //on ajoute l'id de l'element au debut du tableau
        ajouteElementTab(glossaireDinamique, i);
        //on génère une chaine qui correpond à l'identifiant du span qui contient la définition associé au mot qu'on veut afficher dans le glossaire
        var iDef = "def" + i; 
        //on recupere le texte du span qui contient le mot 
        var item = document.getElementById("item"+i).innerHTML;
        //on recupere le texte du span qui contient la définition
        var def = document.getElementById(iDef).innerHTML;
        //on concatene le mot et sa definition
        var texteDict = item + " : " + def;
        
        //si dans le glossaire dinamique on a moins que 3 éléments, on ajoute simplement l'élément
        if(glossaireDinamique.length<2){
            ajouteElementGlossaireDin(texteDict, i);
            }
        //sinon on enlève le dernier élément avant d'ajouter le nouveau
        else{
            document.getElementById("glossaire-perso").removeChild(document.getElementById("glossaire-perso").lastChild);
            ajouteElementGlossaireDin(texteDict, i);
        }
    }
            
//***********************************/
//************************************ SOUSLIGNAGE DES MOTS ET DES BORNES */

//les fonctions de souslignage marchent toutes de la même manière : on récupère les spans avec la bonne classe, si le mot est déjà souligné on enlève la formattation, sinon on ajoute un fond coloré et on change eventuellement la couleur du texte et le gras
            
function sousligne_nom_propre_pers(){
    var personnages = document.getElementsByClassName('nom.propre.personnage')
    if(personnages[0].hasAttribute('style') && personnages[0].style.backgroundColor != 'inherit'){
        for(let e of personnages){
            e.style.backgroundColor = 'inherit';
            e.style.fontStyle = 'inherit';
            e.style.fontWeight ='normal';
        }
}
    else{
        for(let e of personnages){
            e.style.backgroundColor = '#D46A6A';
            e.style.fontWeight = 'bold';
        }
    }
    creer_liste_mots("Noms propres", personnages);
}



function sousligne_pers(){
    sousligne_nom_propre_pers();
   
}

//avec le soulignage des lieux on fait apparaître (et disparaître) aussi le nom de la région
function sousligne_lieux(){
                var lieux = document.getElementsByClassName('lieu')
                var regions = document.getElementsByClassName('region')
                if(lieux[0].hasAttribute('style') && lieux[0].style.backgroundColor != 'inherit'){
                    for(let e of lieux){
                        e.style.backgroundColor = 'inherit';
                    }
                    for(let e of regions){
                        e.setAttribute('hidden','hidden');
                        e.style.backgroundColor = 'inherit';
                    }
                }
                else{
                    for(let e of lieux){
                        e.style.backgroundColor = '#407F7F';
                    }
                    for(let e of regions){
                        e.removeAttribute('hidden')
                        e.style.backgroundColor = '#003333';
                        e.style.color = 'white';
                    }
                }
                creer_liste_mots("Lieux", lieux);
            }



//fonction qui crée une liste avec les mots selectionnés avec un bouton, et qui les fait apparaître dans le carré Listes de mots
function creer_liste_mots(titre, tableau){

    //si cette liste est déja affichée on ne fait rien
    if(listesMots.includes(titre)) return;
    //sinon...
    else{

        //on ajoute titre au tableau de controle
        listesMots.push(titre);
                //on crée un noeud textuel, contenu dans un élément h2, avec le nom du type d'éléments affichés
                var t = document.createTextNode(titre);
                var h2 = document.createElement('h2');
                //attribut utile pour la css
                h2.setAttribute('class','h2_listes')
                h2.appendChild(t);

                //on crée un text node pour afficher le nombre d'éléments de la liste
                var h3 = document.createElement('h3');
                var texte_nb = document.createTextNode("Nombre d'éléments : " + tableau.length );
                h3.appendChild(texte_nb);

                //on crée élément unordered liste pour ajouter tous les mots
                var list = document.createElement('ul');
                //pour chaque mot...
                for(let e of tableau){
                    //on crée un noeud textuel avec le mot suivi par la page où il apparaît
                    let txt = document.createTextNode(e.innerHTML/*+ ' (/\*p.' + *\/e.getAttribute('data-num-page') + ')'*/);
                    //on crée un élément list item pour accrochser le texte à la liste
                    let item = document.createElement('li');
                    item.appendChild(txt);
                    list.appendChild(item);
                }
                //on accroche la liste tout en haut du carré
               document.getElementById('div-listes').insertBefore(list, document.getElementById('div-listes').firstChild)
               //on accroche le texte avec le nombre des éléments tout en haut
               document.getElementById('div-listes').insertBefore(h3, document.getElementById('div-listes').firstChild)
                //on accroche le titre tout en haut du carré
               document.getElementById('div-listes').insertBefore(h2, document.getElementById('div-listes').firstChild)
    }
}

//fonction pour éliminer toutes les listes de mots affichées
function nettoye_listes() {
    var div = document.getElementById('div-listes');
    var h2s = div.getElementsByTagName('h2');
    while (h2s.length > 0) {
        div.removeChild(h2s[0]);
    }
    var listes = div.getElementsByTagName('ul');
    while (listes.length > 0) {
        div.removeChild(listes[0]);
    }
    var h3s = div.getElementsByTagName('h3');
    while (h3s.length > 0) {
        div.removeChild(h3s[0]);
    }
    // Vider le tableau de contrôle
    listesMots = [];
}
