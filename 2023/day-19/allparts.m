function T = allparts( E, V, J, S, P )

T = 0;

if S == 1
  T = prod( P(:,2) - P(:,1) );
  return
end

if S == 2
  return
end

Pt = P;
Pt( E(S), 2 ) = min( Pt( E(S), 2 ), V( S ) );
T = T + allparts( E, V, J, J(S,2), Pt );

Pt = P;
Pt( E(S), 1 ) = max( Pt( E(S), 1 ), V( S ) );
T = T + allparts( E, V, J, J(S,1), Pt );
