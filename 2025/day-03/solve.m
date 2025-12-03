
B = char( readlines( 'input.txt', 'EmptyLineRule', 'skip' ) ) - '0';

crack( B, 2 )

%%

uint64( crack( B, 12 ) )

function R = crack( B, p )

[ s1, s2 ] = size( B );
A = repmat( 1:s2, s1, 1 );

D = zeros( s1, p );
I = zeros( s1, 1 );

for k = 1:p
  [ D(:,k), I ] = max( B .* ( repmat( I, 1, s2 ) < A & A <= s2 - p + k ), [], 2 );
end

R = sum( D * 10.^(p-1:-1:0)' );

end