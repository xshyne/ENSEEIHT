with text_io; use text_io;
with ada.integer_text_io; use ada.integer_text_io;
with p_arbre_n;



procedure test_arbre is

procedure afficher_T(e : in integer);
package p_arbre_int is new p_arbre_n(integer, afficher_T);
use p_arbre_int;

procedure afficher_T(e:in integer) is
begin
	put(e, 0);
end;


arb: arbre_n;
arb2: arbre_n;


begin
arb := An_Creer_Vide;
put_line(Boolean'image(An_Vide(arb)));

arb := An_Creer_Feuille(8);
put_line(Boolean'image(An_Est_Feuille(arb)));
put_line(Boolean'image(not(An_Vide(arb))));
put_line(Boolean'image((1 = An_Nombre_Noeuds(arb))));

An_Inserer_Fils(arb, An_Creer_Feuille(5));
put_line(Boolean'image(An_Est_Feuille(An_Creer_Feuille(5))));
put_line(Boolean'image((2 = An_Nombre_Noeuds(arb))));
put_line(Boolean'image(An_Pere(An_Fils(arb, 1)) = arb));

An_Inserer_Fils(arb, An_Creer_Feuille(4));
put_line(Boolean'image(An_frere(An_Fils(arb, 1), 1) = An_Fils(arb,2)));
An_afficher(arb);
put_line(Boolean'image(An_Nombre_Noeuds_Valeur(arb, 8) = 1));
An_Changer_Valeur(arb, 1);
An_afficher(arb);
put_line(Boolean'image(An_Nombre_Noeuds_Valeur(arb, 8) = 0));

put_line(Boolean'image(not(An_Est_Racine(An_Fils(arb, 1)))));
put_line(Boolean'image(An_Est_Racine(arb)));

end test_arbre;
