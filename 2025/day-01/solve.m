
lines = readlines( 'input.txt', 'EmptyLineRule', 'skip' );

D = ( extract( lines, 1 ) == "R" ) * 2 - 1;
V = double( extract( lines, digitsPattern ) );

P = cumsum( [ 50 ; D .* V ] );
Z = mod( P, 100 ) == 0;

sum( Z )

%%

sum( abs( diff( floor( P / 100 ) ) ) ) + sum( ( D < 0 ) .* diff( Z ) )
