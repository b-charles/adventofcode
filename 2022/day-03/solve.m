
L = convertStringsToChars( readlines('input.txt', 'EmptyLineRule', 'skip') );

P([ 'a':'z' 'A':'Z' ]) = 1:52;

sum( P( cellfun( @(l) intersect( l(1:end/2), l(end/2+1:end) ), L ) ) )

%%

sum( P( cellfun( @(a,b,c) intersect(intersect(a,b),c), L(1:3:end), L(2:3:end), L(3:3:end) ) ) )
