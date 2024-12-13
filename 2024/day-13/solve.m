
[ Ax, Ay, Bx, By, Px, Py ] = readin( 'input.txt' );

K = [ Px.*By - Py.*Bx ; Py.*Ax - Px.*Ay ] ./ repmat( Ax.*By - Ay.*Bx, 2, 1 );
sum( [ 3 1 ] * K( :, all( 0 < K & K <= 100 & floor(K) == K, 1 ) ) )

%%

Px = Px + 10000000000000; Py = Py + 10000000000000;

K = [ Px.*By - Py.*Bx ; Py.*Ax - Px.*Ay ] ./ repmat( Ax.*By - Ay.*Bx, 2, 1 );
uint64( sum( [ 3 1 ] * K( :, all( 0 < K & floor(K) == K, 1 ) ) ) )
