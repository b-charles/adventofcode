
lines = readlines( 'input.txt', 'EmptyLineRule', 'skip' );

sum( cellfun( @length, regexp( lines, '(?<=\|.*)\<(\w{2}|\w{4}|\w{3}|\w{7})\>' ) ) )

%%

fp = @(n) sum( 7.^(char(n)-'a') );
M = cellfun( fp, { 'abcefg', 'cf', 'acdeg', 'acdfg', 'bcdf', 'abdfg', 'abdefg', 'acf', 'abcdefg', 'abcdfg' } );

P = perms(0:6);
np = size(P,1);

n = length( lines );
R = zeros( 4, n );

wb = waitbar( 0, 'Computing...' );

for l = 1:n
    waitbar(l/n,wb);
    W = regexp( lines(l), '\<\w+\>', 'match' );
    for i = 1:np
        p = P(i,:);
        v = arrayfun( @(w) sum( 7 .^ p( char(w) - 'a' + 1 ) ), W );
        [ok,loc] = ismember( v, M );
        if all(ok)
            R(:,l) = loc(end-3:end) - 1;
            break
        end
    end
end

delete(wb);

sum( [1000 100 10 1] * R )
