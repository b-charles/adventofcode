
lines = readlines( 'input.txt', 'EmptyLineRule', 'skip' );

sum( cellfun( @length, regexp( lines, '(?<=\|.*)\<(\w{2}|\w{4}|\w{3}|\w{7})\>' ) ) )

%%

f = @(w) accumarray( cell2mat(w)'-'a'+1, cell2mat( cellfun( @(w) length(w) * ones( 1, length(w) ), w, 'UniformOutput', false ) ), [ 7 1 ], @prod )';
g = @(v, P) cellfun( @(v) prod( primes(17)' .^ accumarray( P(v-'a'+1)', 1, [7 1] ) ), v );

W = { 'abcefg' 'cf' 'acdeg' 'acdfg' 'bcdf' 'abdfg' 'abdefg' 'acf' 'abcdefg' 'abcdfg' };
F = f( W );
G = g( W, 1:7 );

n = length( lines );
R = zeros( n, 4 );

for l = 1:n
  L = arrayfun( @char, regexp( lines(l), '\<\w+\>', 'match' ), 'UniformOutput', false );
  [ ~, P ] = ismember( f( L(1:10) ), F );
  [ ~, R(l,:) ] = ismember( g( L(11:14), P ), G );
end

sum( (R-1) * [1000 100 10 1]' )
