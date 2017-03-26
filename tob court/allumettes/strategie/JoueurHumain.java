package allumettes.strategie;

import java.util.Scanner;

import allumettes.Jeu;
import allumettes.Joueur;

public class JoueurHumain extends Joueur {

	public JoueurHumain(String nom) {
		super(nom);
	}

	@Override
	public int getPrise(Jeu jeu) {
		int prise = 0;
		System.out.println("Combien prenez-vous d'allumettes ? ");
		Scanner sc = new Scanner(System.in);
	    prise = sc.nextInt();
	    sc.close();
		return prise;
	}

}
