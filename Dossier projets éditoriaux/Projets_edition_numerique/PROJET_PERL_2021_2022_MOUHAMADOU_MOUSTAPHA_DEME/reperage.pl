use strict;   # mode algorithmique
use warnings; # messages d'alerte
use utf8;     # caractères accentués dans le code Perl
binmode(STDOUT,':utf8'); # caractères accentués dans le terminal


open(IN,"thérèse-desqueyroux.txt");
binmode(IN,':utf8');

my $nb_occurrences = 0;#création d'une variable, pour le décompte du nombre d'occurences du verbe "songer"
my $nb_occurrences_silence = 0;#création d'une variable, pour le décompte du nombres d'occurences du mot "silence"

my $nb_lignes      = 0; #création d'une variable, pour le décompte de lignes

while (my $ligne = <IN>) { # lecture d'une ligne

  chop $ligne; #on enlève le retour chariot

  $nb_lignes = $nb_lignes+1; #incrémentation de +1 à chaque ligne trouvées

  if ($ligne =~ /\Wsonge\w*/i) { #expression régulière permettant de voir si dans la ligne nous avon le verbe "songer"
    $nb_occurrences = $nb_occurrences+1;#incrémentation de +1 à chaque occurence du verbe "songer" trouvée

    $ligne =~ s/(\W)(songe\w*)/$1>>> 😃 $2 😃 <<</ig;

    print "$nb_lignes:$ligne\n";
  }
  if ($ligne =~ /\Wsilence/i) { #expression régulière permettant de voir si dans la ligne nous avons le mot "silence"
    $nb_occurrences_silence = $nb_occurrences_silence+1;#incrémentation de +1 à chaque occurence (silence) trouvée

    $ligne =~ s/(\W)(silence)/$1>>> 😃 $2 😃 <<</ig;

    print "$nb_lignes:$ligne\n";
  }

}

close(IN);



print "$nb_occurrences occurrences trouvées(songer et ses déclinaisons).\n";
print "$nb_occurrences_silence occurrences trouvées(silence).\n";
