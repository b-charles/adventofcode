function q = solvemachine( W, J )

nb = size( W, 1 );
O = mod( J, 2 );

h = 1:nb;
h2 = 2^nb-1 + 1;
Q = inf( 1, h2 );

for g = 1:h2

  B = bitget( g - 1, h ) == 1;
  F = sum( W(B,:), 1 );

  if all( F == J )
    Q(g) = sum( B );
  elseif all( mod( F, 2 ) == O ) && all( F <= J )
    Q(g) = solvemachine( W, ( J - F ) / 2 ) * 2 + sum( B );
  end

end

q = min( Q );
