
% I = [ '.#.' ;
%       '..#' ;
%       '###' ] == '#';
I = [ '#.#..###' ;
      '.#....##' ;
      '.###...#' ;
      '..####..' ;
      '....###.' ;
      '##.#.#.#' ;
      '..#..##.' ;
      '#.....##' ] == '#';

disp( engine( 6, 3, I ) );

%%

disp( engine( 6, 4, I ) );

%%

function r = engine( nstep, dim, I )

  S = [ size(I) ones( 1, dim-2 ) ] + 2*nstep;

  N = neighbours( S ) + 1;

  A = false( 1 + prod( S ), 1 );
  [ r, c ] = find( I );
  A( 2 + ( [ r c ones( length(r), dim-2 ) ] + nstep - 1 ) * cumprod( [ 1 S(1:end-1) ] )' ) = true;

  for k = 1:nstep
    s = [ 0 ; sum( A(N), 2 ) ];
    A = ( A & ( s==2 | s==3 ) ) | ( ~A & s==3 );
  end

  r = sum( A );

end

function N = neighbours( S )

  up = @(M,n) [ M(1+n:end,:) ; zeros( n, size(M,2) ) ];
  down = @(M,n) [ zeros( n, size(M,2) ) ; M(1:end-n,:) ];

  prodS = cumprod( [ 1 S(1:end-1) ] )';

  N = 1; V = 1;
  for d = 1:length( S )
    
    [n, m] = size(N);
    
    Z = repmat( 1:S(d), n, 1 );    
    M = repmat( N, S(d), 1 ) + repmat( (Z(:)-1)*prodS(d), 1, m );
    N = [ M up(M,n) down(M,n) ];
    
    W = repmat( V, S(d), 1 );
    V = [ W up(W,n) down(W,n) ];
        
  end
  
  N = N(:,2:end) .* V(:,2:end);

end
