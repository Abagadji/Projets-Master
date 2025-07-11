use strict;   # mode algorithmique
use warnings; # messages d'alerte
use utf8;     # caractères accentués dans le code Perl
binmode(STDOUT,':utf8'); # caractères accentués dans le terminal


open(HTML,'>concordanciers_occurences.html');
binmode(HTML,':utf8');


print HTML "<link rel=\"stylesheet\" href=\"concordanciers_occurences.css\">\n";
print HTML "<body>\n";
print HTML "<a href= https://fabien-torre.fr/Enseignement/Cours/perl.php>PERL pour les nul(le)s!! Vous voulez apprendre à coder en PERL🤔? Et faire genre...comme moi? Alors, je vous conseille les notes de cours sur le langage Perl
de M.de Fabien Torre 😎😎
</a>\n";

print HTML "<body>\n";

print HTML "<div>\n";
print HTML "<table>\n"; # création d'un tableau.
print HTML "<h1>Projet PERL</h1>\n";
print HTML "<h2>concordancier du verbe ''songer'' dans Thérèse Desqueyroux</h2>\n";
print HTML "<a href= http://www.alyon.org/litterature/livres/XX/monades/therese_desqueyroux_de_francois_mauriac.html>TEXTE_COMPLET</a>\n";
my $nb_occurrences = 0;#création d'une variable, pour le décompte du nombre d'occurences du verbe "songe

open(IN,"thérèse-desqueyroux.txt");
binmode(IN,':utf8');
my $nb_lignes      = 0; #création d'une variable, pour le décompte du nombre de lignes

while (my $ligne = <IN>) {  # lecture d'une ligne avec une bloucle while.

  chop $ligne; #on enlève le retour chariot

  $nb_lignes = $nb_lignes+1; #incrémentation de +1 à chaque ligne trouvées

  if ($ligne =~ /^(.*\W)(songe\w*)(.*)$/i) { #expression régulière permettant de voir si dans la ligne nous avons le verbe "songer"
    $nb_occurrences = $nb_occurrences+1; #incrémentation de +1 à chaque occurence du verbe "songer" trouvée

    my $gauche = $1; # création d'une variable pour le contexte de gauche.
    my $cible  = $2; # création d'une variable pour la cible.
    my $droite = $3; # création d'une variable pour le contexte de droite.
    # affichage des caractères pour les contextes de gauche et de droite.
    $gauche = substr($gauche,-100,100);
    $droite = substr($droite,0,85);

    # affichages du concordancier en HTML
    print HTML "<tr>"; # création d'une balise <tr> qui définit une rangée dans le tableau
    print HTML "<td class=\"position\">$nb_lignes</td>";
    print HTML "<td class=\"gauche\">$gauche</td>";# création d'une balise <td> qui définit une cellule
    print HTML "<td class=\"cible\">$cible</td>";
    print HTML "<td class=\"droite\">$droite</td>";
    print HTML "</tr>\n";

    print "$nb_lignes:$ligne\n";
  }

}

close(IN);



print HTML "</table>\n";
print HTML "<p>$nb_occurrences occurrences trouvées (songer et ses déclinaisons).</p>\n"; #affiche le nombre de caractères trouvés.
print HTML "</div>\n";

print HTML "<div>\n";
print HTML "<table>\n";
print HTML "<h2>concordancier du mot ''silence'' dans Thérèse Desqueyroux</h2>\n";
my $nb_occurrences_silence = 0;

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
    $droite = substr($droite,0,85);

    # affichages du concordancier en HTML
    print HTML "<tr>";
    print HTML "<td class=\"position\">$nb_lignes</td>";
    print HTML "<td class=\"gauche\">$gauche</td>";
    print HTML "<td class=\"cible\">$cible</td>";
    print HTML "<td class=\"droite\">$droite</td>";
    print HTML "</tr>\n";

    print "$nb_lignes:$ligne\n";
  }

}

close(IN);



print HTML "</table>\n";

print HTML "<p>$nb_occurrences_silence occurrences trouvées (silence).</p>\n";

print HTML "<body>\n";

close(HTML);
