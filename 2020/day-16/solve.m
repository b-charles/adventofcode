
clear variables

[ f, F, T, N ] = readin( 'data.in' );
[ nt, nf ] = size(N);

[ Y, X, Z ] = meshgrid( 1:nf, 1:nt, 1:nf );
V  = arrayfun( @(x,y,z) F(z,1) <= N(x,y) & N(x,y) <= F(z,2) | F(z,3) <= N(x,y) & N(x,y) <= F(z,4), X, Y, Z ); 

disp( sum( N( all( ~V, 3 ) ) ) );

%%

[ K, S ] = sort( (1:nf) * permute( all( V(all(any(V,3),2),:,:), 1 ), [3,2,1] ) );
O( diff( [ 0 K ] ) ) = S;

disp( uint64( prod( T( O( startsWith( fieldnames(f), 'departure' ) ) ) ) ) );
