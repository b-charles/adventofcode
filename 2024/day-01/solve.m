
L = str2double( extract( readlines( 'input.txt', 'EmptyLineRule', 'skip' ), digitsPattern ) );

sum( abs( diff( sort(L), 1, 2 ) ) )

%%

arrayfun( @(l) sum(L(:,2)==l), L(:,1)' ) * L(:,1)
