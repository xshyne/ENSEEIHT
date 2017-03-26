package allumettes;

public abstract class Joueur {
	
	String nom;
	
	public Joueur(String nom){
		this.nom = nom;
	}
	
	String getNom(){
		return this.nom;
	}
	
	public abstract int getPrise(Jeu jeu);
}
