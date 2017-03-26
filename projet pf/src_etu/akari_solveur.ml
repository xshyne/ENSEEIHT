open Bdd_base;;



(* ************************************************************************* *)
(* FONCTIONS AVANCEES SUR LES BDD                                            *)
(* ************************************************************************* *)
let est_bdd un_bdd =
  let rec aux l = function
    | Top -> true
    | Bot -> true
    | Node(b1, c, b2) when List.mem c l || (l <> [] && c < (List.hd l)) -> false
    | Node(b1, c, b2) -> (aux (c::l) b1) && (aux (c::l) b2)
  in aux [] un_bdd;;

(* test
est_bdd (posvariable (Case.make 0 0)) = true;;
est_bdd (negvariable (Case.make 0 0)) = true;;
let case = Case.make 0 1 in est_bdd (node(node(top, case, bot), case, top)) = false;;
*)



let rec conjonction bdd1 bdd2 = match bdd1, bdd2 with
  |Top, g -> g
  |Bot, _ -> bot
  |f, Top -> f
  |_, Bot -> bot
  | Node(b1, c1, b2), Node(b3, c2, b4) when c1 = c2 -> node(conjonction b1 b3, c1, conjonction b2 b4)
  | Node(b1, c1, b2), Node(b3, c2, b4) when c1 < c2 -> node(conjonction b1 bdd2, c1, conjonction b2 bdd2)
  | Node(b1, c1, b2), Node(b3, c2, b4)  -> node(conjonction bdd1 b3 , c2, conjonction bdd1 b4)
;;

(* test
conjonction top (posvariable (Case.make 0 0)) = (posvariable (Case.make 0 0));;
conjonction (posvariable (Case.make 0 0)) bot = bot;;
let case1 = Case.make 0 0 and case2 = Case.make 0 1 in 
  conjonction (posvariable case1) (negvariable case2) = node(node(bot, case2, bot), case1, node(top, case2, bot));;
*)

let rec disjonction bdd1 bdd2 = match bdd1, bdd2 with
  |Top, g -> top
  |Bot, g -> g
  |f, Top -> top
  |f, Bot -> f
  | Node(b1, c1, b2), Node(b3, c2, b4) when c1 = c2 -> node(disjonction b1 b3, c1, disjonction b2 b4)
  | Node(b1, c1, b2), Node(b3, c2, b4) when c1 < c2-> node(disjonction b1 bdd2, c1, disjonction b2 bdd2)
  | Node(b1, c1, b2), Node(b3, c2, b4)  -> node(disjonction bdd1 b3 , c2, disjonction bdd1 b4)
;;
(* test
disjonction top (posvariable (Case.make 0 0)) = top;;
disjonction (posvariable (Case.make 0 0)) bot = (posvariable (Case.make 0 0)) ;;
let case1 = Case.make 0 0 and case2 = Case.make 0 1 in 
  disjonction (posvariable case1) (negvariable case2) = node(node(top, case2, bot), case1, node(top, case2, top));;
*)


let rec combinaisons k l = match k,l with
  | 0, [] -> top
  | 0, h::t -> node(combinaisons k t, h, bot)
  | k, [] -> bot
  | k, h::t -> node(combinaisons k t, h, combinaisons (k-1) t);;
(*)
let case1 = Case.make 0 0 and case2 = Case.make 0 1 in 
  combinaisons 1 [case1, case2] = node(node(bot, case2, top), case1, node(top, case2, bot));;
*)

let rec positivite un_bdd x lampes = match un_bdd with 
  | Top -> false
  | Bot -> false
  | Node(b1, c, b2) when List.mem c lampes -> (positivite b2 x lampes) 
  | Node(b1, c, b2) when c = x -> let rec aux = function
                | Top -> false
                | Bot -> true
                | Node(b3, c2, b4) when List.mem c2 lampes -> aux b4
                | Node(b3, c2, b4) -> (aux b3) && (aux b4)
                in aux b1
  | Node(b1, c, b2) ->  (positivite b1 x lampes) || (positivite b2 x lampes)
;;
(*
let case = Case.make 0 0 in positivite (posvariable case) case [] = true;;
let case = Case.make 0 0 in positivite (negvariable case) case [] = false;;
*)

(* ************************************************************************* *)
(* FONCTIONS PRINCIPALES SUR LES REGLES DE AKARI        *)
(* ************************************************************************* *)


type statut =
  | Noir of int option
  | Vide;;


type grille = Case.t -> statut;;


let adjacentes taille case = 
  let x, y = Case.get_x case, Case.get_y case in
  (if y > 0 then [Case.make x (y-1)] else []) @
  (if x > 0 then [Case.make (x-1) y] else []) @
  (if x < (taille-1) then [Case.make (x+1) y] else []) @
  (if y < (taille-1) then [Case.make x (y+1)] else [])
;;
(*test 
adjacentes 3 (Case.make 0 0) = [Case.make 1 0 ; Case.make 0 1];;
adjacentes 3 (Case.make 1 1) = [Case.make 1 0 ; Case.make 0 1; Case.make 2 1; Case.make 1 2];;

*)

let voisines_visibles taille une_grille case =
  let rec visible = function
    | [] -> []
    | h::t -> match une_grille h with
                | Noir(a) -> []
                | Vide -> h::(visible t)
  in (List.rev (visible (Case.haut taille case))) @ (List.rev (visible (Case.gauche taille case))) @ (visible (Case.droite taille case)) @ (visible (Case.bas taille case));;

(*test
voisines_visibles 2 grille1 (Case.make 1 1) = [Case.make 1 0; Case.make 0 1];;
voisines_visibles 3 grille2 (Case.make 0 0) = [Case.make 1 0; Case.make 2 0; Case.make 0 1; Case.make 0 2];;
*)


let voisines_visibles_vertical taille une_grille case =
  let rec visible = function
    | [] -> []
    | h::t -> match une_grille h with
                | Noir(a) -> []
                | Vide -> h::(visible t) 
  in (List.rev (visible (Case.haut taille case))) @ (visible (Case.bas taille case));;

(*test
voisines_visibles_vertical  2 grille1 (Case.make 1 1) = [Case.make 1 0];;
voisines_visibles_vertical  3 grille2 (Case.make 0 0) = [Case.make 0 1; Case.make 0 2];;
*)


let voisines_visibles_horizontal taille une_grille case =
  let rec visible = function
    | [] -> []
    | h::t -> match une_grille h with
                | Noir(a) -> []
                | Vide -> h::(visible t) 
  in (List.rev (visible (Case.gauche taille case))) @ (visible (Case.droite taille case));;


(*test
voisines_visibles_horizontal 2 grille1 (Case.make 1 1) = [Case.make 0 1];;
voisines_visibles_horizontal 3 grille2 (Case.make 0 0) = [Case.make 1 0; Case.make 2 0];;
*)


(* ************************************************************************* *)
(* FONCTIONS PRINCIPALES SUR LES BDD REPRESENTANT LES REGLES DE AKARI        *)
(* ************************************************************************* *)


let correction taille une_grille case = match une_grille case with
  | Noir(None) -> negvariable case
  | Noir(Some(n)) -> conjonction (combinaisons n (adjacentes taille case)) (negvariable case)
  | Vide -> disjonction (List.fold_right (fun x y -> conjonction (negvariable x) y)  (voisines_visibles taille une_grille case) (posvariable case)) (conjonction (negvariable case) (disjonction (combinaisons 1 (voisines_visibles taille une_grille case)) (conjonction (combinaisons 1 (voisines_visibles_vertical taille une_grille case)) (combinaisons 1 (voisines_visibles_horizontal taille une_grille case)))))
  ;;



(* ************************************************************************* *)
(* TYPES + FONCTIONS GENERALES SUR LES CONFIGURATIONS                        *)
(* ************************************************************************* *)


type configuration = bdd*int*(Case.t list);;


let initialisation taille une_grille = 
  let un_bdd = List.fold_right (fun x y -> conjonction y (List.fold_right (fun z t ->conjonction(correction taille une_grille z) t) x top)) (Case.lignes taille) top in
  (un_bdd,taille, [])
;;

let impossible (un_bdd, taille, lampes) =
  let rec aux = function
    | Top -> false
    | Bot -> true
    | Node(b1, c , b2) when List.mem c lampes -> (aux b2)
    | Node(b1, _ , b2) -> (aux b1) && (aux b2)
  in aux un_bdd
;;


let information (un_bdd, taille, lampes)  = 
 match List.flatten (List.map (List.filter (fun x -> (not (List.mem x lampes)) && (positivite un_bdd x lampes) )) (Case.lignes taille)) with
  | [] -> None
  | h::t -> Some(h)
;;

let mise_a_jour case (un_bdd, taille, lampes) = 
  let new_lampes = 
  if List.mem case lampes then
    (let rec aux = function
      | [] -> []
      | h::t when h = case -> t
      | h::t -> h::(aux t)
    in aux lampes)
  else
    case::lampes
  in (un_bdd, taille, new_lampes)
;;

let grille1 case = match Case.get_x case, Case.get_y case with
  | 0,0 -> Noir(Some 0)
  | _,_ -> Vide;;

let grille2 case = match Case.get_x case, Case.get_y case with
  | 1,1 -> Noir(Some 4)
  | _,_ -> Vide;;

let grille3 case = match Case.get_x case, Case.get_y case with
  | 1,1 -> Noir(Some 4)
  | 0,3 -> Noir(Some 0)
  | 1,3 -> Noir(None)
  | 2,3 -> Noir(Some 2)
  | 3,2 -> Noir(None)
  | _ -> Vide;;
