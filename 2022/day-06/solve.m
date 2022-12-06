
s = fileread( 'input.txt' );

p = @(l)"(.)"+join( arrayfun( @(e)"(?!"+join("\"+(1:e),"|")+")(.)", 1:l-1 ), "" );

regexp( s, p(4), 'end', 'once' ) % p(4) = "(.)(?!\1)(.)(?!\1|\2)(.)(?!\1|\2|\3)(.)"

%%

regexp( s, p(14), 'end', 'once' )
