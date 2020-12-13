
% [ offset, B, I ] = readin( sprintf( '939\n7,13,x,x,59,x,31,19' ) );
% [ offset, B, I ] = readin( sprintf( '0\n17,x,13,19' ) );
% [ offset, B, I ] = readin( sprintf( '0\n67,7,59,61' ) );
% [ offset, B, I ] = readin( sprintf( '0\n67,x,7,59,61' ) );
% [ offset, B, I ] = readin( sprintf( '0\n67,7,x,59,61' ) );
% [ offset, B, I ] = readin( sprintf( '0\n1789,37,47,1889' ) );
[ offset, B, I ] = readin( 'data.in' );

[ m, i ] = min( mod( B - offset, B ) );
disp( B(i) * m );

%%

p = prod( B );
L = p./B;
[ ~, ~, V ] = gcd( B, L );
disp( mod( sum( uint64( mod(-I+1,B) ) .* uint64( mod(V.*L,p) ), 'native' ), uint64(p) ) );
