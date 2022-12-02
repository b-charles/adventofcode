
R = readcell( 'input.txt' );
G = cellfun( @(a,b) (a-'A')*3 + (b-'X') + 1, R(:,1), R(:,2) );

S = [ 4 8 3 1 5 9 7 2 6 ];
sum( S( G ) )

%%

S = [ 3 4 8 1 5 9 2 6 7 ];
sum( S( G ) )
