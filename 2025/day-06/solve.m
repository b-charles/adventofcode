
S = char( readlines( 'input.txt', 'EmptyLineRule', 'skip' ) );

V = str2double( extract( string( S(1:end-1,:) ), digitsPattern ) );
O = ( extract( S(end,:), "+" | "*" ) == "*" )';

P = sum( V, 1 );
M = prod( V, 1 );

uint64( sum( [ P(~O) M(O) ] ) )

%%

X = str2double( string( S(1:end-1,:)' ) )';

I = find( isnan( X ) );
C = arrayfun( @(l,u) X(l:u), [ 1 I+1 ], [ I-1 size(X,2) ], 'UniformOutput', false );

P = cellfun( @sum, C );
M = cellfun( @prod, C );

uint64( sum( [ P(~O) M(O) ] ) )
