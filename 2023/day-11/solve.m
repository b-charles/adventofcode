
G = char( readlines( 'input.txt', 'EmptyLineRule', 'skip') ) == '#';
S = size( G );

IC = nchoosek( find( G ), 2 );

[ Ra, Ca ] = ind2sub( S, IC(:,1) );
[ Rb, Cb ] = ind2sub( S, IC(:,2) );
ER = find( ~any( G, 2 ) );
EC = find( ~any( G, 1 ) );
D = [ ...
  abs( Ra - Rb ) ...
  abs( Ca - Cb ) ...
  arrayfun( @(l, u) sum( l < ER & ER < u ), min(Ra, Rb), max(Ra, Rb) ) ...
  arrayfun( @(l, u) sum( l < EC & EC < u ), min(Ca, Cb), max(Ca, Cb) ) ];

sum( D * [ 1 1 1 1 ]' )

%%

uint64( sum( D * [ 1 1 999999 999999 ]' ) )
