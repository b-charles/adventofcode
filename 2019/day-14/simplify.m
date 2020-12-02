function V = simplify( data, fuel )

M = data.M;
N = size( M, 2 );

j = data.elts.ORE;
i = data.elts.FUEL;

% 1 ORE => 1 ORE
M([ 1 j+1 ],j) = [ 1 1 ];

RESERVE = zeros( N, 1 );
  function V = getOf( E )
    
    V = zeros( N, 1 );
    
    IDX = RESERVE >= E;
    RESERVE(IDX) = RESERVE(IDX) - E(IDX);
    
    IDX = ~IDX;
    E(IDX) = E(IDX) - RESERVE(IDX);
    Q = M(1,IDX)';
    D = ceil( E(IDX) ./ Q );
    V(IDX) = D .* Q;
    RESERVE(IDX) = V(IDX) - E(IDX);
        
  end

T = M(2:end,:) ./ repmat( M(1,:), N, 1 );
  function E = simp( E )
    E = getOf( T * E );
  end

current = getOf( fuel * M(2:end,i) );

filter = double( 1:N ~= j );
while filter * current > 0
  current = simp( current );
end

V = current(j);

end