

package body p_polynome is


-----------------------------------------------------------
-- Procedure afficher_T
-- Sémantique : affiche un element de type T
-- Paramètres : e : t, element a afficher
-- Pre-condition : Aucune
-- Post-condition :Aucune
-- Erreur : Aucune
-----------------------------------------------------------
procedure afficher_T(e : T) is 
begin
        if e.is_coef then
                put(e.coef, 0);
                put("*");
        else 
                null;
        end if;
        if e.is_var then
                put(e.var);
        else
                null;
        end if; 
        if e.is_exp then
                put("^");
                put(e.exp, 0);
        else
                null;
        end if;
end;

-----------------------------------------------------------
-- Fonction lire_entier
-- Sémantique : lis un entier dans un tableau
-- Paramètres : tab : string, tableau de carractere
--              index : integer, indice de depart
--              n : interger, taille du tableau
-- Type retour : integer
-- Pre-condition : Aucune
-- Post-condition : l'entier retourné est celui dans le tableau
-- Erreur : Aucune
-----------------------------------------------------------

function lire_entier(tab : in string; index : in out integer; n : in integer) return integer is
result : integer;
begin
        result := 0;
	while index <= n and CHARACTER'POS(tab(index)) >= 48 and CHARACTER'POS(tab(index)) <= 57 loop
		result := result *10 + (CHARACTER'POS(tab(index))-48);
		index := index + 1;
	end loop;
	return result;
end;


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

function encoder(tab : in string; n :in integer) return T_poly is
index : integer;
mult : integer;
expo : integer;
temp : integer;
arb : T_poly;
result : T_poly;
result_rechercher: T_poly;
data : T;
begin
    result := An_creer_vide;
	index := 1;
	while index <= n loop
        arb := result;
		temp := index;
		index := index + 1;
        expo := -1;
		mult := lire_entier(tab, index, n);
		if tab(temp) = '-' then
			mult := -1*mult;
		else
			null;
		end if;
		while index <= n and not (tab(index) = '+' or tab(index) = '-') loop
            if expo = -1 then
                data := (var => tab(index), is_var => true, exp=>0, is_exp => false, is_coef => false, coef => 0);
            else
                data := (var => tab(index), is_var => true, is_exp => true, exp => expo, is_coef => false, coef => 0);
            end if;
            if An_vide(result) then
			    result := An_Creer_Feuille(data);
                arb := result;
            else
                result_rechercher := An_Rechercher(arb, data);
	          	if not An_vide(result_rechercher) then
			        arb := result_rechercher;
		        else
    				result_rechercher := An_Creer_Feuille(data);
        			An_Inserer_Fils(arb, result_rechercher);
	        		arb := result_rechercher;
		        end if;
            end if;
            index := index + 1;
            expo := lire_entier(tab, index, n);
		end loop;
        data := (is_var => false, var => '0', exp => expo, is_exp => true, coef => mult, is_coef =>true);
        An_Inserer_Fils(arb, An_creer_Feuille(data));
        end loop;
  return result;
end;

-----------------------------------------------------------
-- Fonction décoder
-- Sémantique : décode un polynome 
-- Paramètres : a : T_poly
-- Type retour : booléen (vaut vrai si a est vide)
-- Pre-condition : Aucune
-- Post-condition : vrai si a est vide
-- Erreur : Aucune
-----------------------------------------------------------

function decoder(a : in T_poly) return string is 
begin
        return "";
end;


-----------------------------------------------------------
-- procedure afficher
-- Sémantique : affiche un polynome
-- Paramètres : a : T_poly
-- Pre-condition : Aucune
-- Post-condition : vrai si a est vide
-- Erreur : Aucune
-----------------------------------------------------------

procedure afficher(a : in T_poly) is 
begin
        An_afficher(a);
end;

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

function additionner(a : in T_poly; b : in T_poly) return T_poly is 
begin
        return a;
end;

end;
