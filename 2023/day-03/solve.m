
D = readlines('input.txt', 'EmptyLineRule', 'skip');
n = size( D, 1 );

T = {};
for l = 1:n
  [M, S, E] = regexp( char(D(l)), '\d+', 'match', 'start', 'end' );
  T = [ T arrayfun( @(m,s,e) str2double(m)*( conv2( ismember( reshape(1:n^2,n,[]), sub2ind([n n], l*ones(1,e-s+1), s:e) ), ones(3), 'same' ) > 0 ), M, S, E, 'UniformOutput', false ) ]; %#ok<AGROW> 
end
Z = cat( 3, T{:} );

R = sum( Z, 3 );
sum( R( ~ismember(char(D), '.0123456789') ) )

%%

R = prod( max( Z, 1 ), 3 );
round( sum( R( ismember(char(D), '*') & sum( Z > 0, 3 ) == 2 ) ) )
