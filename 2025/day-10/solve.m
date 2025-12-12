
M = readin( 'input.txt' );
n = length( M );

P = zeros( 1, n );
for k = 1:n

  W = M(k).wiring;
  L = M(k).lights;

  nb = size( W, 1 );
  h = 1:nb;
  h2 = 2^nb-1 + 1;
  Q = inf( 1, h2 );

  for g = 1:h2
    B = bitget( g, h ) == 1;
    if all( mod( sum( W(B,:), 1 ), 2 ) == L )
      Q(g) = sum( B );
    end
  end

  P( k ) = min( Q );

end
sum( P )

% 514

%%

tic
h = waitbar(0,'Please wait...');

P = zeros( 1, n );
for k = 1:n

  waitbar( k/n, h, sprintf( '%d/%d', k, n ) );

  P( k ) = solvemachine( M(k).wiring, M(k).joltage );

end

close( h );
toc

sum( P )
