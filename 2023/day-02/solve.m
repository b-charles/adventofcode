
S = readin( 'input.txt' );

sum( find( cellfun( @(s) all(s(:,1)<=12) & all(s(:,2)<=13) & all(s(:,3)<=14), S ) ) )

%%

sum( cellfun( @(s) prod(max(s, [], 1)), S ) )
