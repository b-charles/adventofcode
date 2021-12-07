
H = readmatrix( 'input.txt' );

sum( abs( H - median(H) ) )

%%

s = @(m) m .* (m+1) / 2;
fuel = @(f) sum( s( abs( H - f ) ) );
t = round( fminsearch( fuel, mean(H) ) );

fuel( t )
