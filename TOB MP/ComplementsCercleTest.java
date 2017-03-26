import java.awt.Color;
import org.junit.*;
import static org.junit.Assert.*;

/**
  * Classe de test<(FOURNIS)> (incomplète)<(FOURNIS)> de la classe Cercle.
  * @author	Xavier Crégut
  * @version	$Revision$
  */
public class ComplementsCercleTest {

	// précision pour les comparaisons réelle
	public final static double EPSILON = 0.001;

	// Les points du sujet
	private Point A, B, C, D, E;

	// Les cercles du sujet
	private Cercle C1, C2;

	@Before public void setUp() {
		// Construire les points
		A = new Point(-1, -2); //test avec des coordonnées négatives
		B = new Point(-1, -2);
		C = new Point(4, 1);
		D = new Point(8, 1);
		E = new Point(8, 4);

		// Construire les cercles
		C1 = new Cercle(A, 2.5);
		C2 = new Cercle(C, D, Color.yellow);
	}

	/** Vérifier si deux points ont mêmes coordonnées.
	  * @param p1 le premier point
	  * @param p2 le deuxième point
	  */
	static void memesCoordonnees(String message, Point p1, Point p2) {
		assertEquals(message + " (x)", p1.getX(), p2.getX(), EPSILON);
		assertEquals(message + " (y)", p1.getY(), p2.getY(), EPSILON);
	}

	@Test public void testComplementaire1() {
		memesCoordonnees("TC1 : Centre de C1 incorrect", A, C1.getCentre());
		assertEquals("TC1 : Rayon de C1 incorrect",
				2.5, C1.getRayon(), EPSILON);
		assertEquals(Color.blue, C1.getCouleur());
	}

	@Test public void testComplementaire2() {
		assertTrue("TC2", C1.contient(A));
		assertTrue("TC2", C1.contient(B));
	}

	@Test public void testComplementaire3() {
		memesCoordonnees("TC3 sur C1", A, C1.getCentre());
	}

	@Test public void testComplementaire4() { //test complementaire sur E18
		A.translater(1,1);
		memesCoordonnees("TC4 sur C1", B, C1.getCentre());
	}


	public static void main(String[] args) {
		org.junit.runner.JUnitCore.main(ComplementsCercleTest.class.getName());
	}

}
