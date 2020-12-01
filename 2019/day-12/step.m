function [P, V] = step( P, V )

  function G = gravity( P )
    G = sum( sign( permute( repmat( P, 1, 1, 4 ), [ 1, 3, 2 ] ) - repmat( P, 1, 1, 4 ) ), 3 );
  end

  V = V + gravity( P );
  P = P + V;

end
