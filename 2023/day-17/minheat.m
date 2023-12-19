function M = minheat( L, mmin, mmax )

[ S1, S2 ] = size( L );

mdelta = mmax - mmin + 1;

% 1:N 2:E 3:S 4:W
M = inf( S1, S2, 4, mdelta );

M(1,1+mmin,2,1) = sum( L( 1, 2:1+mmin ) );
M(1+mmin,1,3,1) = sum( L( 2:1+mmin, 1 ) );

  function V = getval( M, I, v )
    T = [ v ; M(:) ];
    V = reshape( T(I+1), [ S1, S2 ] );
  end

  function update( I, d, T )

    Mt = min( M(:,:,T,:), [], [ 3 4 ] );
    for l = 1:mmin
      Mt = L + getval( Mt, I, inf );
    end
    M(:,:,d,1) = min( M(:,:,d,1), Mt );

    for l = 1:mdelta-1
      Mt = L + getval( M(:,:,d,l), I, inf );
      M(:,:,d,l+1) = min( M(:,:,d,l+1), Mt );
    end

  end

I = reshape( 1:numel( L ), [ S1, S2 ] );

IN = [ I(2:end,:) ; zeros(1,S2) ];
IE = [ zeros(S1,1) I(:,1:end-1) ];
IS = [ zeros(1,S2) ; I(1:end-1,:) ];
IW = [ I(:,2:end) zeros(S1,1) ];

P = zeros( size(M) );

while any( P(:) ~= M(:) )
  P = M;

  update( IN, 1, [ 2 4 ] );
  update( IE, 2, [ 1 3 ] );
  update( IS, 3, [ 2 4 ] );
  update( IW, 4, [ 1 3 ] );

end

end