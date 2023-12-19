
L = char( readlines( 'input.txt', 'EmptyLineRule', 'skip' ) ) - '0';

sol = @(M) min( M(end,end,:,:), [], [3 4] );

sol( minheat( L, 1, 3 ) )

%%

sol( minheat( L, 4, 10 ) )
