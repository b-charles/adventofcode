function  M = move( M, D )

  function M = move_down( M )
    r = find( M == -2, 1, 'first' );
    if M(r+1) == 0
      M(r) = 0;
      M(r+1) = -2;
    elseif M(r+1) > 0
      X = test_down( M, r );
      if ~isempty( X )
        V = M( X );
        M( X ) = 0;
        M( X+1 ) = V+1;
        M( r ) = 0;
        M( r + 1 ) = -2;
      end
    end
  end

  function Z = test_down( M, Z )
    S = setdiff( Z+1, Z );
    if all( M(S) == 0 )
      return;
    elseif any( M(S) == -1 )
      Z = [];
      return
    else
      W = M(S);
      Z = test_down( M, unique( [ Z S(M(S)>0) W(W>0) ] ) );
    end
  end

  function Mt = rot( M, k )
    O = M > 0;
    [ ~, L ] = ismember( M(O), rot90( reshape( 1:numel(M), size(M) ), k ) );
    Mt = M;
    Mt( O ) = L;
    Mt = rot90( Mt, k );
  end

for d = D

  if d == 1 % v
    M = move_down( M );
  elseif d == 2 % >
    M = rot( move_down( rot( M, 3 ) ), 1 );
  elseif d == 3 % ^
    M = rot( move_down( rot( M, 2 ) ), 2 );
  else % d == 4 % <
    M = rot( move_down( rot( M, 1 ) ), 3 );
  end

end

end
