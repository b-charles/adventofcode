
M = cell2mat( convertStringsToChars( readlines( 'input.txt', 'EmptyLineRule', 'skip' ) ) ) == '#';

[ I, J ] = ind2sub( size(M), find( M ) );
E = I+J*1i;

Q = jump( E, 0 );
for r = 1:9
  Q = jump( Q, r );
end

X = real( Q ); Y = imag( Q );
( max(X)-min(X)+1 ) * ( max(Y)-min(Y)+1 ) - length(Q) %#ok<NOPTS>

%%

[ Q, r, s ] = jump( E, 0 );
while ~s
  [ Q, r, s ] = jump( Q, r );
end

r

%%

function [ Q, r, s ] = jump( P, r )

n = length( P );

NW = P-1-1i;
N = P-1;
NE = P-1+1i;
W = P-1i;
E = P+1i;
SW = P+1-1i;
S = P+1;
SE = P+1+1i;

VNW = ~ismember( NW, P );
VN = ~ismember( N, P );
VNE = ~ismember( NE, P );
VW = ~ismember( W, P );
VE = ~ismember( E, P );
VSW = ~ismember( SW, P );
VS = ~ismember( S, P );
VSE = ~ismember( SE, P );

O = [ P circshift( [ N S W E ], -r , 2 ) ];
T = [ VN&VNE&VE&VSE&VS&VSW&VW&VNW circshift( [ VNW&VN&VNE VSW&VS&VSE VNW&VW&VSW VNE&VE&VSE ], -r, 2 ) ];

[ ~, I ] = max( T, [], 2 );
Q = O( sub2ind( [n 5], (1:n)', I ) );

D = arrayfun( @(p)nnz(Q==p)>1, Q );
while any( D )
  Q(D) = P(D);
  D = arrayfun( @(p)nnz(Q==p)>1, Q );
end

r = r + 1;
s = all( T(:,1) );

end