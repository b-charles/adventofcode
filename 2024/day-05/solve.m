
[C, L] = readin( 'input.txt' );

mid = @(l) l((end+1)/2);

ok = cellfun( @(l) all( l == order( C, l ) ), L );

sum( cellfun( mid, L(ok) ) )

%%

sum( cellfun( @(l) mid( order( C, l ) ), L(~ok) ) )
