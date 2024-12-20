
[ P, L ] = readin( 'input.txt' );

C = struct();

nb = zeros( size(L) );
for i = 1:length(L)
  [ nb(i), C ] = searchdesign( P, L{i}, C );
end

sum( nb > 0 )

%%

uint64( sum( nb ) )
