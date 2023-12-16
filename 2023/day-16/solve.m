
M = char( readlines( 'input.txt', 'EmptyLineRule', 'skip' ) );

S = size(M);
E = false( S(1), S(2), 4 );

e = @(h) sum( sum( any( beaming( h, M, E ), 3 ) ) );

e( [ 1 1 2 ] )

%%

T = arrayfun( @(i,j,d) e([i j d]), ...
  [ S(1)*ones(1,S(2)), 1:S(1), ones(1,S(2)), 1:S(1) ], ...
  [ 1:S(2), ones(1,S(1)), 1:S(2), S(2)*ones(1,S(1)) ], ...
  [ 1*ones(1,S(2)), 2*ones(1,S(1)), 3*ones(1,S(2)), 4*ones(1,S(1)) ]);

max( T )
