
C = readin( 'data.in' );

disp( sum( cellfun( @(g) sum( any( g, 1 ) ), C ) ) );

%%

disp( sum( cellfun( @(g) sum( all( g, 1 ) ), C ) ) );
