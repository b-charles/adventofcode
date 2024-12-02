
L = cellfun( @(l)str2double(extract(l,digitsPattern))', num2cell( readlines( 'input.txt', 'EmptyLineRule', 'skip' ) ), 'UniformOutput', false );

save = @(L) sum( cellfun( @(d) any( ( all(d<0,2) | all(d>0,2) ) & all(d~=0,2) & all(abs(d)<=3,2) ), cellfun( @(l) diff(l, 1, 2), L, 'UniformOutput', false ) ) );

save( L )

%%

save( cellfun( @(l) nchoosek(l, length(l)-1), L, 'UniformOutput', false ) )
