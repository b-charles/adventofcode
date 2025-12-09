
P = str2double( extract( readlines( 'input.txt', 'EmptyLineRule', 'skip' ), digitsPattern ) );

n = size(P,1);

x = P(:,1);

y = P(:,2);
[ ~, E ] = maxk( abs( diff( [ x ; x(1) ] ) ), 2 );
y = y - mean( y(E) );

X = repmat( x, 1, n );
Y = repmat( y, 1, n );

D = ( abs( X - X' ) + 1 ) .* ( abs( Y - Y' ) + 1 );
uint64( max( D, [], 'all' ) )

%%

D = zeros( n, n );
for i = 1:n-1
  for j = i+1:n

    if ( Y(i) > 0 ) ~= ( Y(j) > 0 )
      continue
    end

    x = [ X(i) X(j) ];
    if x(1) > x(2)
      x = x( [ 2 1 ] );
    end

    y = [ Y(i) Y(j) ];
    if y(1) > y(2)
      y = y( [ 2 1 ] );
    end

    I = true( 1, n ); I(i) = false; I(j) = false;
    RX = X( I ); RY = Y( I );
    if any( ( x(1) < RX & RX < x(2) ) & ( y(1) < RY & RY < y(2) ) )
      continue
    end

    D(i,j) = ( x(2) - x(1) + 1 ) * ( y(2) - y(1) + 1 );

  end
end

uint64( max( D, [], 'all' ) )
