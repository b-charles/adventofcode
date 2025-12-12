
[ S, P ] = readin( 'input.txt' );

N = cellfun( @(s) sum( s, 'all' ), S );
sum( P(:,1) .* P(:,2) >= P(:,3:8) * N' )
