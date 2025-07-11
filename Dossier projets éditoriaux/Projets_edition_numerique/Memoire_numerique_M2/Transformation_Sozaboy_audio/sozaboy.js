// Fonction pour surligner une phrase spécifique dans le texte
function highlightSentence(sentenceOrder) {
  document.getElementById("sent-" + sentenceOrder).style.background = "chocolate";
}

// Fonction pour enlever le surlignement d'une phrase spécifique
function clearSentence(sentenceOrder){
  document.getElementById("sent-" + sentenceOrder).style.background = "transparent";
}

// Objet définissant à quel moment (en secondes) chaque phrase doit être surlignée
var sentences_time_division = {
  0: 1,
  26: 2,
  27: 3,
  30: 4,
  46: 5,
  85: 6,
  110: 7,
  153: 8,
};

// Récupération des éléments HTML nécessaires pour le fonctionnement du script
let audio = document.getElementById("myAudio"); // Élément <audio> pour gérer la lecture sonore
var h1 = document.getElementsByTagName('h1')[0]; // Élément <h1> affichant le timer
var start = document.getElementById('strt'); // Bouton "Start"
var stop = document.getElementById('stp'); // Bouton "Stop"
var reset = document.getElementById('rst'); // Bouton "Reset"
var sec = 0; // Compteur de secondes
var min = 0; // Compteur de minutes
var hrs = 0; // Compteur d'heures
var t; // Variable pour stocker l'intervalle du timer

// Fonction qui gère l'incrémentation du temps
function tick(){
    sec++;
    if (sec >= 60) {
        sec = 0;
        min++;
        if (min >= 60) {
            min = 0;
            hrs++;
        }
    }
}

// Fonction qui met à jour le timer affiché et relance le suivi du temps
function add() {
    tick();
    h1.textContent = (hrs > 9 ? hrs : "0" + hrs) 
             + ":" + (min > 9 ? min : "0" + min)
             + ":" + (sec > 9 ? sec : "0" + sec);
    timer(); // Continue le timer
}

// Fonction principale du timer, qui met en surbrillance les phrases au bon moment
function timer() {
  var currentTime = min * 60 + sec; // Conversion du temps total en secondes

  if (currentTime >= audio.duration) {
    clearTimeout(t); // Arrête le timer si l'audio est terminé
  } else {
    t = setTimeout(add, 1000); // Appelle la fonction add() toutes les secondes

    if (sentences_time_division[currentTime]) { // Vérifie s'il y a une phrase à surligner
      var order = sentences_time_division[currentTime];
      if (order !== 1) {
        clearSentence(order - 1); // Efface le surlignement de la phrase précédente
      }
      highlightSentence(order); // Surligne la phrase actuelle
      console.log(currentTime); // Affiche le temps actuel dans la console pour debug
    }
  }
}

// Événement du bouton "Start" pour démarrer l'audio et le timer
start.onclick = function (){
  audio.play(); // Lance la lecture de l'audio
  timer(); // Démarre le timer
}

// Événement du bouton "Stop" pour mettre en pause l'audio et arrêter le timer
stop.onclick = function (){
  audio.pause(); // Met l'audio en pause
  clearTimeout(t); // Arrête le timer
}

// Événement du bouton "Reset" pour tout réinitialiser
reset.onclick = function (){
  clearTimeout(t); // Arrête le timer
  
  // Supprime le surlignement de toutes les phrases en parcourant l'objet des temps
  Object.values(sentences_time_division).forEach(function(order) {
    clearSentence(order);
  });

  // Réinitialise l'affichage du timer
  h1.textContent = "00:00:00";
  sec = 0; min = 0; hrs = 0;

  // Réinitialise et redémarre l'audio depuis le début
  audio.pause(); // Met l'audio en pause
  audio.currentTime = 0; // Revient au début de l'audio
  audio.play(); // Relance la lecture depuis le début

  // Redémarre le timer
  timer();
}

// Gestion du bouton "Remonter vers le haut de la page"
const btnScrollToTop = document.querySelector('#btnScrollToTop');

// Ajoute un effet de défilement fluide lorsque l'utilisateur clique sur le bouton
btnScrollToTop.addEventListener('click', () => {
  window.scrollTo({
    top: 0,
    behavior: 'smooth' // Effet de défilement fluide
  });
});

// Affiche ou masque le bouton de retour en haut selon le défilement de la page
window.addEventListener('scroll', () => {
  if (window.pageYOffset > 200) { // Si l'utilisateur a défilé plus de 200px
    btnScrollToTop.style.display = 'block'; // Affiche le bouton
  } else {
    btnScrollToTop.style.display = 'none'; // Cache le bouton
  }
});
