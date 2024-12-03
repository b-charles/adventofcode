
M = strjoin( readlines( 'input.txt', 'EmptyLineRule', 'skip' ) );

result = @(M) sum( cellfun( @(v)prod(str2double(v)), regexp( M, '(?<=mul\()(\d{1,3})(?:,)(\d{1,3})(?=\))', 'tokens' )' ) );

result( M )

%%

result( regexprep( M, 'don''t\(\).*?do\(\)', '', 'all' ) )
