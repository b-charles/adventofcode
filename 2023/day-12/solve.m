
[ R, C ] = readin( 'input.txt' );

sum( cellfun( @poss, R, C ) )

%%

R5 = cellfun( @(r) char( join( repmat( string(r), 1, 5 ), '?' ) ), R, 'UniformOutput', false );
C5 = cellfun( @(c) repmat( c, 1, 5 ), C, 'UniformOutput', false );

l = length( R5 );
T = zeros( 1, l );
h = waitbar( 0, '0' );
for i = 1:l
  T(i) = poss( R5{i}, C5{i} );
  waitbar( i/l, h, sprintf( '%d', i ) );
end
close(h);

uint64( sum( T ) )
