
data = char( readlines( 'input.txt', 'EmptyLineRule', 'skip' ) );

B = data == '#';
[ PI, PJ ] = find( data == '^' );
I = [ PI PJ 1 ];

P = path( B, I );
X = unique( P( :, [ 1, 2 ] ), 'rows' );

size( X, 1 )

%%

L = zeros( 0, size(X,1) );

for i = 2:size(X,1)
  Bv = B;
  Bv( X(i,1), X(i,2) ) = true;
  Pv = path( Bv, I );
  L(i) = Pv(end,3) ~= 0;
end

sum( L )