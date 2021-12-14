
lines = readlines( 'input.txt', 'EmptyLineRule', 'skip' );

S = char( lines(1) ) - 'A' + 1;

M = char( lines(2:end) );
R = [ M(:,1) M(:,2) M(:,7 ) ] - 'A' + 1;

C = repmat( eye(26), 26, 1 );

idx = @(ab) 26*(ab(:,1)-1) + ab(:,2);
Q = [ idx( R(:,[1 2]) ), idx( R(:,[1 3]) ), idx( R(:,[3 2]) ) ];

for i = 1:10
  C( Q(:,1), : ) = C( Q(:,2), : ) + C( Q(:,3), : );
end

T = ( 1:26 == S(1) ) + sum( C( idx( [ S(1:end-1)' S(2:end)' ] ), : ), 1 );
max( T(T~=0) ) - min( T(T~=0) )

%%

for i = 1:30
  C( Q(:,1), : ) = C( Q(:,2), : ) + C( Q(:,3), : );
end

T = ( 1:26 == S(1) ) + sum( C( idx( [ S(1:end-1)' S(2:end)' ] ), : ), 1 );
uint64( max( T(T~=0) ) - min( T(T~=0) ) )
