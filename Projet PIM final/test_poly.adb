with text_io; use text_io;
with ada.integer_text_io; use ada.integer_text_io;
with p_polynome; use p_polynome;

procedure test_poly is

poly1 : T_poly;
poly2 : T_poly;

begin
poly1 := encoder("+1X0Y1+2X1Y1", 12);
afficher(poly1);
poly2 := encoder("+2X1Y2Z3+4X0Y1Z2", 16);
afficher(poly2);
end;
