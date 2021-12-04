
[T, C] = readin( 'input.txt' );

R = cellfun( @(C)sim(C,T), C );

[ ~, i ] = min( [ R.order ] );
R(i).score

%%

[ ~, i ] = max( [ R.order ] );
R(i).score

%%

function R = sim( C, T )

M = false(5);
for j = 1:length(T)
    M = M | C == T(j);
    if any( all( M, 1 ) ) || any( all( M, 2 ) )
        break
    end
end

R = struct( ...
    'order', j, ...
    'score', sum( C( ~M ) ) * T(j) );

end

