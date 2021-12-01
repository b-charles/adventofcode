
D = readmatrix( 'input.txt' );

sum( diff(D) > 0 )

%%

sum( D(4:end) > D(1:end-3) )
