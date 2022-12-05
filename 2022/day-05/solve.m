
[ S, C ] = readin( 'input.txt' );

process( S, C, @(s)s(end:-1:1) )

%%

process( S, C, @(s)s )

%%

function R = process( S, C, t )

for i = 1:size(C,1)
  [ S{C(i,1)}, S{C(i,2)} ] = deal( S{C(i,1)}(1:end-C(i,3)), [ S{C(i,2)} t(S{C(i,1)}(end-C(i,3)+1:end)) ] );
end

R = cellfun( @(s)s(end), S );

end