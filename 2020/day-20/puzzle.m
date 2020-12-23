function P = puzzle( T )
  
  n = length( T );
  c = sqrt( n );
  
  l = size( T(1).tile, 1 );
  
  sym = @(M) M(end:-1:1,:); rot = @(M)sym(M');
  W = 2.^(0:l-1)';
  borders = @(M) struct( 'tile', M, 'borders', [ M(1,:)*W M(:,1)'*W M(end,:)*W M(:,end)'*W ]' );
  function S = poss( m )
    S = [ ...
      borders(m) borders(rot(m)) borders(rot(rot(m))) borders(rot(rot(rot(m)))) ...
      borders(sym(m)) borders(rot(sym(m))) borders(rot(rot(sym(m)))) borders(rot(rot(rot(sym(m))))) ];
  end
  
  ALL_POSS = arrayfun( @(t)poss(t.tile), T, 'UniformOutput', false );
  [ T.poss ] = ALL_POSS{:};

  next = @(ij) [ (ij(1)<c)*ij(1) + 1, ij(2) + (ij(1)==c) ];
  
  for k = 1:n
    
    P = repmat( struct( ...
      'id', 0, ...
      'tile', [], ...
      'borders', [] ), c, c );
    P(1,1) = struct( ...
      'id', T(k).id, ...
      'tile', T(k).poss(1).tile, ...
      'borders', T(k).poss(1).borders );
    
    U = true( 1, n );
    U(k) = false;
    
    if findTiles( [ 2 1 ], U )
      return
    end
    
  end
  
  function ok = findTiles( ij, B )
    
    ok = ~any(B);
    if ok
      return
    end
    
    for kk = find( B )
      
      B(kk) = false;
      
      for ll = 1:8
        
        if test( P, ij, T(kk).poss(ll).borders )
          P(ij(1),ij(2)) = struct( ...
            'id', T(kk).id, ...
            'tile', T(kk).poss(ll).tile, ...
            'borders', T(kk).poss(ll).borders );
          ok = findTiles( next(ij), B );
          if ok
            return
          end
        end
        
      end
      
      B(kk) = true;
      
    end
    
  end
  
  function ok = test( P, ij, b )
    ok = ...
      ( ij(1)==1 || P(ij(1)-1,ij(2)).borders(3) == b(1) ) && ...
      ( ij(2)==1 || P(ij(1),ij(2)-1).borders(4) == b(2) );
  end
  
end