
H = readmatrix( 'input.txt' );

sum( abs( H - median(H) ) )

%%

t = round( mean(H) + mean( H > mean(H) ) - 0.5 );
uint64( sum( abs(H-t) .* ( abs(H-t)+1 ) /2 ) )
