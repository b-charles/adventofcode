
C = char( readlines( 'input.txt', 'EmptyLineRule', 'skip') );
n = size( C, 1 );

a = find( C == 'S' );

dn = ( C(a-1) == '|' || C(a-1) == '7' || C(a-1) == 'F' );
ds = ( C(a+1) == '|' || C(a+1) == 'L' || C(a+1) == 'J' );
de = ( C(a+n) == '-' || C(a+n) == 'J' || C(a+n) == '7' );
dw = ( C(a-n) == '-' || C(a-n) == 'L' || C(a-n) == 'F' );
R( [ 5 10 3 9 12 6 ] ) = '|-LJ7F';
C( a ) = R( [ dn de ds dw ]*[1 2 4 8]' );

M = zeros( n^2, 2 );

I = find( C == '|' );
M(I,:) = [ I-1 I+1 ];
I = find( C == '-' );
M(I,:) = [ I-n I+n ];
I = find( C == 'L' );
M(I,:) = [ I-1 I+n ];
I = find( C == 'J' );
M(I,:) = [ I-1 I-n ];
I = find( C == '7' );
M(I,:) = [ I-n I+1 ];
I = find( C == 'F' );
M(I,:) = [ I+n I+1 ];

c = [ a find( M(:,1) == a | M(:,2) == a, 1 ) ];

P = false( size(C) );
P( c ) = true;

next = @(c) [ c(2), M( c(2), M(c(2),:) ~= c(1) ) ];

while c(2) ~= a
  c = next( c );
  P( c(2) ) = true;
end

sum( P(:) ) / 2 %#ok<NOPTS>

%%

T = C; T( ~P ) = '.';
H = mod( cumsum( cell2mat( replace( mat2cell( T, ones(size(T,1),1), size(T,2) ), "|" ...
  | lookBehindBoundary("F" + asManyOfPattern("-")) + "J" ...
  | lookBehindBoundary("L" + asManyOfPattern("-")) + "7", "#" ) ) == '#', 2 ), 2 ) == 1;
V = mod( cumsum( cell2mat( replace( mat2cell( T', ones(size(T,2),1), size(T,1) ), "-" ...
  | lookBehindBoundary("F" + asManyOfPattern("|")) + "J" ...
  | lookBehindBoundary("7" + asManyOfPattern("|")) + "L", "#" ) )' == '#', 1 ), 2 ) == 1;

sum( ~P(:) & H(:) & V(:) )
