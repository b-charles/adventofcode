
L = double( reshape( extract( readlines( 'input.txt', 'EmptyLineRule', 'skip' ), digitsPattern ), 2, [] )' );

S = string( cell2mat(  arrayfun( @(l,u) l:u, L(:,1), L(:,2) , 'UniformOutput', false )' )' );

pattern = java.util.regex.Pattern.compile( '(\d+)\1' );
sum( double( S( arrayfun( @(s) pattern.matcher( java.lang.String( s ) ).matches(), S ) ) ) )

%%

pattern = java.util.regex.Pattern.compile( '(\d+)\1+' );
sum( double( S( arrayfun( @(s) pattern.matcher( java.lang.String( s ) ).matches(), S ) ) ) )
