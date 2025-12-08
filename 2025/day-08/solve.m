
P = str2double( extract( readlines( 'input.txt', 'EmptyLineRule', 'skip' ), digitsPattern ) );

n = size(P,1); N = [ n n ];

X = P(:,1); Y = P(:,2); Z = P(:,3);
D = ( repmat( X, 1, n ) - repmat( X', n, 1 ) ).^2 + ...
  ( repmat( Y, 1, n ) - repmat( Y', n, 1 ) ).^2 + ...
  ( repmat( Z, 1, n ) - repmat( Z', n, 1 ) ).^2;
D( eye( n ) > 0 ) = Inf;

C = eye( n ) == 1;

for t = 1:1000

  [ ~, m ] = min( D, [], 'all' );
  [ i, j ] = ind2sub( [ n n ], m );

  c = C(i,:) | C(j,:);
  C(c,:) = repmat( c, sum(c), 1 );

  D( [ i, j ], [ i, j ] ) = Inf;

end

prod( maxk( sum( unique( C, 'rows' ), 2 ), 3 ) )

%%

while any( ~isinf( D ) )
  [ ~, m ] = min( D, [], 'all' );
  [ i, j ] = ind2sub( N, m );
  c = isinf( D(i,:) ) | isinf( D(j,:) );
  D(c,c) = Inf;
end

uint64( P(i,1) * P(j,1) )
