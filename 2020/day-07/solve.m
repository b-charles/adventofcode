
% [ b, B ] = readin( 'demo1.in' );
% [ b, B ] = readin( 'demo2.in' );
[ b, B ] = readin( 'data.in' );

S = polyvalm( [ ones( 1, size(B,1) ) 0 ], B );

disp( sum( S( :, b.shiny_gold ) > 0 ) );

%%

disp( sum( S( b.shiny_gold, : ) ) );
