use strict;   # mode algorithmique
use warnings; # messages d'alerte
use utf8;     # caractères accentués dans le code Perl
binmode(STDOUT,':utf8'); # caractères accentués dans le terminal

open(HTML,'>concordancier_songer_silence.html');
binmode(HTML,':utf8');


print HTML "<body style=\"background-color: BurlyWood;
text-align: center;
border : solid ForestGreen 10px;
margin-left : 15%;
margin-right : 15%;\">\n";
print HTML "<a href= https://fabien-torre.fr/Enseignement/Cours/perl.php style=\"font-size: x-large;\" >PERL pour les nul(le)s!! Vous voulez apprendre à coder en PERL🤔? Et faire genre...comme moi? Alors, je vous conseille les notes de cours sur le langage Perl
de M.de Fabien Torre 😎😎
</a>\n";
print HTML "<div>\n";
print HTML "<table style=\"border : solid red 10px;\">\n";
print HTML "<h1 style=\"color: ForestGreen;\">Projet PERL</h1>\n";
print HTML "<h2>concordancier du verbe ''songer'' dans Thérèse Desqueyroux</h2>\n";

print HTML "<a href= http://www.alyon.org/litterature/livres/XX/monades/therese_desqueyroux_de_francois_mauriac.html>TEXTE_COMPLET</a>\n";


my $nb_occurrences = 0;# permet de créer une variable, qui nous permettra de compter le nombre d'occurrences (songer) que nous avons dans le fichier texte

open(IN,"thérèse-desqueyroux.txt");
binmode(IN,':utf8');
my $nb_lignes      = 0;

while (my $ligne = <IN>) {

  chop $ligne;

  $nb_lignes = $nb_lignes+1;

  if ($ligne =~ /^(.*\W)(songe\w*)(.*)$/i) {
    $nb_occurrences = $nb_occurrences+1;

    my $gauche = $1;
    my $cible  = $2;
    my $droite = $3;
    # affichage des caractères
    $gauche = substr($gauche,-100,100);
    $droite = substr($droite,0,85);

    # affichages du concordancier en HTML
    print HTML "<tr>";
    print HTML "<td style=\"color: purple;\">$nb_lignes</td>";
    print HTML "<td style=\"  text-align: right;
    color: ForestGreen;\">$gauche</td>";
    print HTML "<td style=\"  background-color: gold;
      font-weight: bold;
      text-align: center;\">$cible</td>";
    print HTML "<td style=\"color: #f50c28;\">$droite</td>";
    print HTML "</tr>\n";

    print "$nb_lignes:$ligne\n";
  }

}

close(IN);
print HTML "</table>\n";
print HTML "<p style=\"font-style: oblique;
  font-family: serif;\">$nb_occurrences occurrences trouvées (songer et ses déclinaisons).</p>\n";
print HTML "</div>\n";

print HTML "<div>\n";
print HTML "<table style=\"border : solid red 10px;\">\n";
print HTML "<h2>concordancier du mot ''silence'' dans Thérèse Desqueyroux</h2>\n";
my $nb_occurrences_silence = 0;# permet de créer une variable, qui nous permettra de compter le nombre d'occurrences (songer) que nous avons dans le fichier texte

open(IN,"thérèse-desqueyroux.txt");
binmode(IN,':utf8');
my $nb_lignes      = 0;

while (my $ligne = <IN>) {

  chop $ligne;

  $nb_lignes = $nb_lignes+1;

  if ($ligne =~ /^(.*\W)(silence)(.*)$/i) {
    $nb_occurrences_silence = $nb_occurrences_silence+1;

    my $gauche = $1;
    my $cible  = $2;
    my $droite = $3;
    # affichage des caractères
    $gauche = substr($gauche,-100,100);
    $droite = substr($droite,0,100);

    # affichages du concordancier en HTML
    print HTML "<tr>";
    print HTML "<td style=\"color: purple;\">$nb_lignes</td>";
    print HTML "<td style=\"  text-align: right;
    color: ForestGreen;\">$gauche</td>";
    print HTML "<td style=\"  background-color: gold;
      font-weight: bold;
      text-align: center;\">$cible</td>";
    print HTML "<td style=\"color: #f50c28;\">$droite</td>";
    print HTML "</tr>\n";

    print "$nb_lignes:$ligne\n";
  }

}

close(IN);



print HTML "</table>\n";
print HTML "<p style=\"font-style: oblique;
  font-family: serif;\">$nb_occurrences_silence occurrences trouvées (silence).</p>\n";
print HTML "</div>\n";

print HTML "<body>\n";

close(HTML);
