
M = char( readlines( 'input.txt', 'EmptyLineRule', 'skip' ) ) - '0';

[ TI, TJ ] = find( M == 0 );
TW = ones( length(TI), 1 );
for s = 1:length(TW)

  P = false( size(M) );
  P( TI(s), TJ(s) ) = true;

  for w = 1:9
    P = conv2( P, [ 0 1 0 ; 1 0 1 ; 0 1 0 ], 'same' ) > 0 & ( M == w );
  end

  TW(s) = sum( P(:) );

end

sum( TW )

%%

[ TI, TJ ] = find( M == 0 );
TW = ones( length(TI), 1 );
for w = 1:9

  [ NI, NJ ] = find( M == w );
  TW = arrayfun( @(i,j) TW'*( ( TI == i-1 & TJ == j ) | ...
    ( TI == i+1 & TJ == j ) | ...
    ( TI == i & TJ == j-1 ) | ...
    ( TI == i & TJ == j+1 ) ), NI, NJ );

  TI = NI; TJ = NJ;

end

sum( TW )
