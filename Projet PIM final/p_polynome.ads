with text_io; use text_io;
with ada.integer_text_io; use ada.integer_text_io;
with p_arbre_n;

package p_polynome is

type T_poly is private;

 

-----------------------------------------------------------
-- Fonction encoder
-- Sémantique : Encode un polynome a partir d'un tableau de ccarractere
--				en un arbre
-- Paramètres : tab : string, tableau de carractere
-- Type retour : T_poly
-- Pre-condition : Le tableau respecte les conditions de l'enoncé
-- Post-condition : l'arbre correspond au polynome entré
-- Erreur : Aucune
-----------------------------------------------------------

function encoder(tab : in string; n :in integer) return T_poly;

-----------------------------------------------------------
-- Fonction decoder
-- Sémantique : décode un polynome 
-- Paramètres : a : T_poly
-- Type retour : T_poly 
-- Pre-condition : Aucune
-- Post-condition : vrai si a est vide
-- Erreur : Aucune
-----------------------------------------------------------

function decoder(a : in T_poly) return string;

-----------------------------------------------------------
-- procedure afficher
-- Sémantique : affiche un polynome
-- Paramètres : a : T_poly
-- Pre-condition : Aucune
-- Post-condition : vrai si a est vide
-- Erreur : Aucune
-----------------------------------------------------------

procedure afficher(a : in T_poly);

-----------------------------------------------------------
-- Fonction additionner
-- Sémantique : additionne 2 polynomes
-- Paramètres : a : T_poly
--				b : T_poly
-- Type retour : T_poly
-- Pre-condition : Aucune
-- Post-condition : retourne l'arbre representent la somme des 2 polynomes
-- Erreur : Aucune
-----------------------------------------------------------

function additionner(a : in T_poly; b : in T_poly) return T_poly;

private

type T is record 
  var : character;
  is_var : boolean;
  exp : integer;
  is_exp : boolean;
  coef : integer;
  is_coef : boolean;  
end record;


procedure afficher_T(e : in T);
package p_arbre_poly is new p_arbre_n(T, afficher_T);
use p_arbre_poly;

type T_poly is new arbre_n;

end;
