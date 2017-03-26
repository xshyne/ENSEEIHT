import java.awt.Color;

/** Un cercle est une courbe plane fermée constituée des points situés à égale distance d’un point
* nommé centre. La valeur de cette distance est appelée rayon du cercle. On appelle diamètre la
* distance entre deux points diamétralement opposés. La valeur du diamètre est donc le double de
* la valeur du rayon
*
* @author Clément Guillaumin
*/
public class Cercle {
        public final static double PI = Math.PI;        // constante PI
        private Point centre;                           // centre du cercle
        private double rayon;                           // rayon du cercle
        private Color couleur;                          // couleur du cercle

        /** Construire un cercle a partir de son centre et de son rayon
        * @param centre centre du cercle
        * @param rayon rayon du cercle
        */
        public Cercle(Point centre, double rayon){
		assert centre != null;
		assert rayon > 0;
                this.centre = new Point(centre.getX(), centre.getY());
                this.rayon = rayon;
                this.couleur = Color.blue;
        }
        
        /** Construire un cercle a partir de 2 points diametralement opposé
        * @param pt1 premier point
        * @param pt2 second point
        */
        public Cercle(Point pt1, Point pt2){
		assert pt1 != null;
		assert pt2 != null;
		assert pt1.getX() != pt2.getX() || pt1.getY() != pt2.getY();
                this.centre = new Point((pt1.getX()+pt2.getX())/2, (pt1.getY()+pt2.getY())/2);
                this.rayon = pt1.distance(pt2)/2;
                this.couleur = Color.blue;
        }
        /** Construire un cercle a partir de 2 points diametralement opposé et de la couleur
        * @param pt1 premier point
        * @param pt2 second point
        * @param couleur couleur du cercle
        */
        public Cercle(Point pt1, Point pt2, Color couleur){
		assert pt1 != null;
		assert pt2 != null;
		assert couleur != null;
		assert pt1.getX() != pt2.getX() || pt1.getY() != pt2.getY();
                this.centre = new Point((pt1.getX()+pt2.getX())/2, (pt1.getY()+pt2.getY())/2);
                this.rayon = pt1.distance(pt2)/2;
                this.couleur = couleur;
        }

        public String toString(){
                return "C"+this.rayon+"@"+this.centre;
        }
        
        /** Translater le cercle
	* @param dx déplacement suivant l'axe des X
	* @param dy déplacement suivant l'axe des Y
	*/
        public void translater(double dx, double dy){
                this.centre.translater(dx, dy);
        }
        
        /** Obtenir le centre du cercle
	* @return point representant le centre du cercle
	*/
        public Point getCentre(){
                return new Point(centre.getX(), centre.getY());
        }

        /** Obtenir le rayon du cercle
	* @return rayon du cercle
	*/
        public double getRayon(){
                return rayon;
        }

        /** Obtenir le diametre du cercle
	* @return diametre du cercle
	*/
        public double getDiametre(){
                return rayon*2;
        }
        /** Test si un point est dans le cercle ou non
        * @param pt point a tester
        * @return vrai si le point est dans le cercle
        */
        public boolean contient(Point pt){
		assert pt != null;
	       return this.centre.distance(pt) <= this.rayon;
        }
        
        /** Obtenir le perimetre du cercle
	* @return perimetre du cercle
	*/
        public double perimetre(){
                return 2*PI*rayon;
        }
        
        /** Obtenir l'aire du cercle
	* @return aire du cercle
	*/
        public double aire(){
                return PI*rayon*rayon;
        }
        
        /** Obtenir la couleur du cercle
	* @return couleur du cercle
	*/
        public Color getCouleur(){
                return this.couleur;
        }

        /** Changer la couleur du cercle
	* @param couleur la nouvelle couleur du cercle
	*/
        public void setCouleur(Color couleur){
		assert couleur != null;
                this.couleur = couleur;
        }

        /** Changer la couleur du cercle
	* @param rayon le nouvelle rayon du cercle
	*/
        public void setRayon(double rayon){
		assert rayon > 0;
                this.rayon = rayon;
        }

        /** Changer le diametre du cercle
	* @param diametre le nouveau diametre du cercle
	*/
        public void setDiametre(double diametre){
		assert diametre > 0;
                this.rayon = diametre/2;
        }

        /** Construit un cercle a partir de son centre et d'un point du cercle
	* @param pt1 centre du cercle
        * @param pt2 un point du cercle
        * @return cercle correspondant
	*/
        public static Cercle creerCercle(Point pt1, Point pt2){
		assert pt1 != null;
		assert pt2 != null;
                return new Cercle(pt1, pt1.distance(pt2));
        }
        
}
