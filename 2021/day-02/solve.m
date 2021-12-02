
P = readin( 'input.txt' );

prod( sum( P, 2 ), 1 )

%%

uint64( sum( P(1,:) ) * sum( P(1,:) .* cumsum( P(2,:) ) ) )
