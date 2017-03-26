with text_io; use text_io;

package body p_arbre_n is

-----------------------------------------------------------
-- Fonction An_Vide
-- Sémantique : Détecter si un arbre n−aire est vide ou non
-- Paramètres : a : arbre_n
-- Type retour : booléen (vaut vrai si a est vide)
-- Pre-condition : Aucune
-- Post-condition : vrai si a est vide
-- Erreur : Aucune
-----------------------------------------------------------

function An_Vide(a : in arbre_n) return boolean is
begin 
	return a = null;
end;

-----------------------------------------------------------
-- Fonction An_Creer_Vide
-- Sémantique : Créer un arbre n−aire vide
-- Paramètres : /
-- Type retour : arbre_n
-- Pre-condition : Aucune 
-- Post-condition : l'arbre est vide
-- Erreur : Aucune
-----------------------------------------------------------

function An_Creer_Vide return arbre_n is
begin
	return null;
end;

-----------------------------------------------------------
-- Fonction An_Valeur
-- Sémantique : Retourner la valeur rangée à la racine d’un arbre n−aire
-- Paramètres : a : arbre_n
-- Type retour : T
-- Pre-condition : l'arbre n'est pas vide 
-- Post-condition : la valeur est celle de la racine
-- Erreur : Aucune
-----------------------------------------------------------

function An_Valeur(a : in arbre_n) return T is
begin
	return a.all.data;
end;

-----------------------------------------------------------
-- Fonction An_Est_Feuille
-- Sémantique : Indiquer si un arbre n−aire est une feuille (pas de fils)
-- Paramètres : a : arbre_n
-- Type retour : booléen (vaut vrai si a n’a pas de fils )
-- Pre-condition : Aucune
-- Post-condition : vrai si l'abre est une feuille
-- Erreur : Aucune
-----------------------------------------------------------

function An_Est_Feuille(a : in arbre_n) return boolean is
begin
	return a.all.fils = null;
end;

-----------------------------------------------------------
-- Fonction An_Creer_Feuille
-- Sémantique : Créer un arbre n−aire avec une valeur mais sans fils, ni frère ,
-- ni père
-- Paramètres : nouveau : T
-- Type retour : arbre_n
-- Pre-condition : Aucune 
-- Post-condition : l'arbre est une feuille sans pere, ni frere, ni fils
-- Erreur : Aucune
-----------------------------------------------------------

function An_Creer_Feuille(nouveau : in T) return arbre_n is
begin
	return new T_noeud'(nouveau, null, null, null, null);
end;

-----------------------------------------------------------
-- Fonction An_Pere
-- Sémantique : Retourner l’arbre n−aire père d’un arbre n−aire
-- Paramètres : a : arbre_n
-- Type retour : arbre_n
-- Pre-condition : Aucune 
-- Post-condition : retourne le pere de l'arbre
-- Erreur : Arbre_inexistant : si l'arbre n'a pas de pere
-----------------------------------------------------------

function An_Pere(a : in arbre_n) return arbre_n is
begin
	if a.all.pere = null then
		raise Arbre_inexistant;
	else
		return a.all.pere;
	end if;
end;

-----------------------------------------------------------
-- Fonction An_Frere
-- Sémantique : Retourner le nieme Frere d ’ un arbre n−aire
--        le numero 1 est le premier frere droit
--        le numero 0 est l’arbre lui−même.
--        le numero −1 est le premier frere gauche
-- Paramètres : a : arbre_n,
--              n : entier, le numéro du frère
-- Type retour : arbre_n
-- Pre-condition : n = -1, 0 ou 1 et a non vide
-- Post-condition : retourne le frere demandé suivant n
-- Erreur : Arbre_inexistant : si le frere demandé n'existe pas
-----------------------------------------------------------

function An_frere(a: in arbre_n; n : in integer) return arbre_n is
begin
  if n = 0 then
	return a;
  else
	if n > 0 and then a.all.frere_d /= null then
		return An_frere(a.all.frere_d, n-1);
	elsif a.all.frere_g /= null then
		return An_frere(a.all.frere_g, n+1);
	else
		raise Arbre_inexistant;
	end if;
  end if;
end;

-----------------------------------------------------------
-- Fonction An_Fils
-- Sémantique : Retourner le nieme fils de a
--   le numero 1 est le premier fils
--   Attention : le 2ème fils est le frère droit, pas le petit−fils
-- Paramètres : a : arbre_n ,
--              n : entier , le numéro du fils
-- Type retour : arbre_n
-- Pre-condition : a non vide
-- Post-condition : retourne le nième fils de l'abre
-- Erreur : Arbre_inexistant : si le fils demandé n'existe pas
-----------------------------------------------------------

function An_Fils(a : in arbre_n; n : in integer) return arbre_n is 
begin
  if a.all.fils = null then
	raise Arbre_inexistant;
  else
	return An_frere(a.all.fils, n-1);
  end if;
end;
-----------------------------------------------------------
-- Procédure An_Afficher
-- Sémantique : Afficher le contenu complet d’un arbre n−aire
-- Paramètres : a : arbre_n
-- Pre-condition : Aucune
-- Post-condition : Aucune
-- Erreur : Aucune
-----------------------------------------------------------

procedure An_afficher(a : in arbre_n) is
begin
	if a /= null then
                put("Noeud(");
		afficher_T(a.all.data);
	        put(", ");
		if a.all.fils /= null then
			An_afficher(a.all.fils);
		else
			null;
		end if;
                put("), ");
		if a.all.frere_d /= null then
			An_afficher(a.all.frere_d);
		else
			null;
		end if;
	else
		null;
	end if;
end;

-----------------------------------------------------------
-- Fonction An_Nombre_Noeuds
-- Sémantique : Retourner le nombre total de noeuds d’un arbre n−aire
-- Paramètres : a : arbre_n
-- Type retour : Entier
-- Pre-condition : Aucune 
-- Post-condition : le retour est le nombre de noeud de l'arbre
-- Erreur : Aucune
-----------------------------------------------------------

function An_Nombre_Noeuds(a : in arbre_n) return integer is
count : integer;
begin
	if a = null then 
		return 0;
	else
		count := 1;
		if a.all.fils /= null then
			count := count + An_Nombre_Noeuds(a.all.fils);
		else
			null;
		end if;

		if a.all.frere_d /= null then
			count := count + An_Nombre_Noeuds(a.all.frere_d);
		else
			null;
		end if;

		return count;
	end if;
end;

-----------------------------------------------------------
-- Fonction An_Rechercher
-- Sémantique : Rechercher une valeur dans un arbre n−aire et
-- retourner l’arbre n−aire dont la valeur est racine si elle
-- est trouvée , un arbre n−aire vide sinon
-- Paramètres : a : arbre_n ,
--              data : T, la valeur à rechercher
-- Type retour : arbre_n
-- Pre-condition : Aucune 
-- Post-condition : data est la racine du sous arbre retourné,
--                si la valeur n'est pas dans l'arbre data est vide
-- Erreur : Aucune
-----------------------------------------------------------

function An_Rechercher(a : in arbre_n; data : in T) return arbre_n is
resultat : arbre_n;
begin
	resultat := null;
	if a /= null then
		if a.all.data = data then
			resultat := a;
		else  
			if a.all.frere_d /= null and then resultat = null then
				resultat := An_Rechercher(a.all.frere_d, data);
			else
				if a.all.fils /= null and then resultat = null then
					resultat := An_Rechercher(a.all.fils, data);
				else
					null;
				end if;
			end if;
		end if;
	else
		null;
	end if;
	return resultat;
end;

-----------------------------------------------------------
-- Fonction An_Nombre_Noeuds_Valeur
-- Sémantique : Retourner le nombre de noeuds d’un arbre n−aire
-- dont la valeur est égale à une valeur donnée.
-- Paramètres : a : arbre_n,
--              data : T, la valeur à rechercher
-- Type retour : Entier
-- Pre-condition : Aucune
-- Post-condition : le nombre de noeud avec data comme valeur
-- Erreur : Aucune
-----------------------------------------------------------

function An_Nombre_Noeuds_Valeur(a : in arbre_n; data : in T) return integer is
count : integer;
begin
	if a = null then 
		return 0;
	else
		if a.all.data = data then
			count := 1;
		else
			count := 0;
		end if;

		if a.all.fils /= null then
			count := count + An_Nombre_Noeuds_Valeur(a.all.fils, data);
		else
			null;
		end if;

		if a.all.frere_d /= null then
			count := count + An_Nombre_Noeuds_Valeur(a.all.frere_d, data);
		else
			null;
		end if;

		return count;
	end if;
end;

-----------------------------------------------------------
-- Fonction An_Est_Racine
-- Sémantique : Indiquer si un arbre n−aire est sans père
-- Paramètres : a : arbre_n
-- Type retour : booléen (vaut vrai si a n’a pas de père)
-- Pre-condition : Aucune
-- Post-condition : vrai si l'abre est une racine
-- Erreur : Aucune
-----------------------------------------------------------

function An_Est_Racine(a : in arbre_n) return boolean is 
begin
	if a = null then 
		return true;
	else
		return a.all.pere = null;
	end if;
end;

-----------------------------------------------------------
-- Procédure An_Changer_Valeur
-- Sémantique : Changer la valeur du noeud d’un arbre n−aire
-- Paramètres : a : arbre_n
--              data : T, la nouvelle valeur
-- Pre-condition : Aucune 
-- Post-condition : la valeur du noeud de l'arbre est data
-- Erreur : Arbre_vide : si l'arbre en paramètre est vide
-----------------------------------------------------------

procedure An_Changer_Valeur(a : in out arbre_n; data : in T) is
begin
	if a = null then
		raise Arbre_vide;
	else
		a.all.data := data;
	end if;
end;

-----------------------------------------------------------
-- Procédure An_Inserer_Fils
-- Sémantique : Insérer un arbre n−aire sans frère en position de premier
-- fils d’un arbre n−aire a. L’ancien fils de a devient alors le premier
-- frère de l’arbre n−aire insére.
-- Paramètres : a : arbre_n,
--              a_ins : arbre n, l’arbre à insérer
-- Pre-condition : a_ins n'a pas de frere, a et a_ins ne sont pas vide
-- Post-condition : a_ins est le premier fils de a
-- Erreur : Aucune
-----------------------------------------------------------

procedure An_Inserer_Fils(a : in out arbre_n; a_ins : in arbre_n) is 
begin
	if a.all.fils = null then
		a_ins.all.pere := a;
		a.all.fils := a_ins;
	else
		a_ins.all.pere := a;
		a.all.fils.all.frere_g := a_ins;
		a_ins.all.frere_d := a.all.fils;
		a.all.fils := a_ins;
	end if;
end;

-----------------------------------------------------------
-- Procédure An_Inserer_Frere
-- Sémantique : Insérer un arbre n−aire sans frère en position de premier
-- frère d’un arbre n−aire a
-- Paramètres : a : arbre_n,
--              a_ins : arbre n, l’arbre à insérer
-- Pre-condition : Aucune
-- Post-condition : a_ins est le premier frere de a
-- Erreur : Aucune
-----------------------------------------------------------

procedure An_Inserer_Frere(a : in out arbre_n; a_ins : in arbre_n) is
begin
	if a.all.frere_d = null then
		a_ins.all.pere := a.all.pere;
		a_ins.all.frere_g := a;
		a.all.frere_d := a_ins;
	else
		a_ins.all.pere := a.all.pere;
		a_ins.all.frere_d := a.all.frere_d;
		a.all.frere_d.all.frere_g := a_ins;
		a_ins.all.frere_g := a;
		a.all.frere_d := a_ins;
	end if;
end;

-----------------------------------------------------------
-- Procédure supprimer_arbre
-- Sémantique : Supprime l'arbre passer en parametre
-- Paramètres : a : arbre_n
-- Pre-condition : Aucune
-- Post-condition : l'arbre a été suprimé
-- Erreur : aucune
-----------------------------------------------------------

procedure supprimer_arbre(a : in  arbre_n) is
begin
	if An_Est_Racine(a) then
          null;
	else
		if a = An_Pere(a).all.fils then
			An_Pere(a).all.fils := a.all.frere_d;
		else
			null;
		end if;
		if a.all.frere_g /= null then
			a.all.frere_g.all.frere_d := a.all.frere_d;
		else
			null;
		end if;
		if a.all.frere_d /= null then
			a.all.frere_d.all.frere_g := a.all.frere_g;
		else
			null;
		end if;
    end if;
end;

-----------------------------------------------------------
-- Procédure An_Supprimer_frere
-- Sémantique : Supprime le nieme frere d’un arbre n−aire
-- Paramètres : a : arbre_n,
--              n : entier, le numéro du frère (et tous ses descendants) à supprimer
-- Pre-condition : Aucune
-- Post-condition : le nieme frere est supprimé
-- Erreur : Arbre_inexistant : si il n'y a pas de nieme frere
-----------------------------------------------------------

procedure An_Supprimer_frere(a : in out arbre_n; n : in integer) is 
begin
	supprimer_arbre(An_frere(a, n));
end;

-----------------------------------------------------------
-- Procédure An_Supprimer_fils
-- Sémantique : Supprime le nieme fils d’un arbre n−aire
-- Paramètres : a : arbre_n,
--              n : entier, le numéro du fils (et tous ses descendants) à supprimer
-- Pre-condition : Aucune
-- Post-condition : le nieme fils est supprimé
-- Erreur : Arbre_inexistant : si il n'y a pas de nieme fils
-----------------------------------------------------------

procedure An_Supprimer_fils(a : in out arbre_n; n : in integer) is
begin
	supprimer_arbre(An_Fils(a, n));
end;

end;
