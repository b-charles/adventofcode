
[ N, E, V, J, P ] = readin( 'input.txt' );

in = find( strcmp( N, 'in' ), 1 );

I = eye( 4 );

S = repmat( in, size(P,1), 1 );
while any( S > 2 )
  T = sum( P .* I(E(S), :), 2 ) < V(S);
  S = J( sub2ind( size(J), S, T+1 ) );
end
sum( P( S==1, : ), 'all' )

%%

uint64( allparts( E, V, J, in, repmat( [ 1 4001 ], 4, 1 ) ) )
