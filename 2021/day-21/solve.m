
p1 = 1;
p2 = 10;

maxT = 200;
D = reshape( sum( reshape( mod( 0:6*maxT-1, 100 )+1, 3, [] ), 1 ), 2, [] );

P = mod( cumsum( [ p1 p2 ; zeros( maxT-1, 2 ) ]' + D, 2 )-1, 10 )+1;
S = cumsum( P, 2 );

t = find( S>=1000, 1 );
disp( S(t-1) * 3*t )

%%

R = part2( [ 1 0 0 p1 p2 ], 1 );
uint64( max( R ) )

%%

function R = part2( S, p )
% S = [ w s1 s2 p1 p2 ]

n = size( S, 1 );
S = repmat( S, 7, 1 );

W = repmat( [ 1 3 6 7 6 3 1 ], n, 1 );
S(:,1) = S(:,1) .* W(:);

D = repmat( 2:8, n, 1 );
S(:,p+3) = mod( S(:,p+3) + D(:), 10 ) + 1;
S(:,p+1) = S(:,p+1) + S(:,p+3);

I = S(:,p+1) >= 21;

R = [ 0 0 ];
R(p) = sum( S(I,1) );

S(I,:) = [];
if isempty( S )
  return
end

R = R + part2( S, 3-p );

end