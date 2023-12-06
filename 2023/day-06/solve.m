
L = char( readlines( 'input.txt', 'EmptyLineRule', 'skip' ) );

sol = @(T,M) ceil( ( T + sqrt(T.^2 - 4*M) )/2 ) - ceil( ( T - sqrt(T.^2 - 4*M) )/2 );

prod( sol( str2num(L(1,10:end)), str2num(L(2,10:end)) ) ) %#ok<ST2NM>

%%

sol( str2num(replace(L(1,10:end), ' ', '')), str2num(replace(L(2,10:end), ' ', '')) ) %#ok<ST2NM>
