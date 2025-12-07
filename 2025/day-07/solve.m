
M = char( readlines( 'input.txt', 'EmptyLineRule', 'skip' ) );

C = M == '^';

B = M(1,:) ==  'S';
s = 0;
for i = 1:size( C, 1 )
  L = ( B > 0 ) & C(i,:);
  s = s + sum( L );
  T = B .* L;
  B = ( B .* ~L ) + [ T(2:end) 0 ] + [ 0 T(1:end-1) ];
end

s

%%

uint64( sum( B ) )
