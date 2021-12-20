
lines = readlines( 'input.txt', 'EmptyLineRule', 'skip' );

E = char( lines(1) ) == '#';
M = char( lines(2:end) ) == '#';

F = 2.^reshape( 0:8, 3, [] )';
enh2 = @(M) E( 512 - conv2( ~E( conv2( M, F ) + 1 ), F ) );

M = enh2( M );

sum( M(:) )

%%

for i = 1:24
  M = enh2( M );
end

sum( M(:) )
