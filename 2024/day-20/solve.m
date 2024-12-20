
M = char( readlines( 'input.txt', 'EmptyLineRule', 'skip' ) );
s = find( M == 'S', 1, 'first' );
e = find( M == 'E', 1, 'first' );
W = find( M == '#' );

P = Inf( size(M) );
P( s ) = 0;
while ~isfinite( P(e) )
  P = min( cat( 3, P, ...
    [ Inf(size(M,1),1) P(:,1:end-1)+1 ], ...
    [ P(:,2:end)+1 Inf(size(M,1),1) ], ...
    [ Inf(1,size(M,2)) ; P(1:end-1,:)+1 ], ...
    [ P(2:end,:)+1 ; Inf(1,size(M,2)) ] ), [], 3 );
  P( W ) = nan;
end

cheat( P, 2 )

%%

cheat( P, 20 )

%%

function s = cheat( P, n )

[ J, I ] = meshgrid( 1:size(P,1), 1:size(P,2) );

s = 0;
for p = 0:max( P, [], 'all' )
  [ qi, qj ] = find( P == p, 1, 'first' );
  D = abs(I-qi) + abs(J-qj);
  D( D > n ) = nan;
  s = s + sum( P - p - D >= 100, 'all' );
end

end