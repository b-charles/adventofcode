
P = readin( 'data.in' );

ok = arrayfun( @(p,n) p.min <= n & n <= p.max, P, arrayfun( @(p) sum( p.password == p.c ), P ) );

disp( sum( ok ) );

%%

ok = arrayfun( @(p) xor( p.password( p.min ) == p.c, p.password( p.max ) == p.c ), P );

disp( sum( ok ) );
