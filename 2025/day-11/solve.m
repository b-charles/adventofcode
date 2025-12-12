
[ N, M ] = readin( 'input.txt' );

T = polyvalm( [ ones( 1, size( M, 1 ) ) 0 ], M );

T( N.you, N.out )

%%

uint64( ...
  T( N.svr, N.dac ) * T( N.dac, N.fft ) * T( N.fft, N.out ) + ...
  T( N.svr, N.fft ) * T( N.fft, N.dac ) * T( N.dac, N.out ) )
