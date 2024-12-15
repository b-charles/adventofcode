
% 1430536 - 1452348

[ M, D ] = readin( 'input.txt' );

M1 = move( M, D );
[ Oi, Oj ] = ind2sub( size(M), find( M1 > 0 ) );
sum( 100*Oi + Oj - 101 )

%%

M2 = zeros( size(M,1), 2*size(M,2) );
M2( :, 1:2:end ) = M;
[ i, j ] = find( M == -1 );
M2( sub2ind( size(M2), i, 2*j ) ) = -1;

[ Oi, Oj ] = find( M > 0 );
M2( sub2ind( size(M2), Oi, 2*Oj-1 ) ) = sub2ind( size(M2), Oi, 2*Oj );
M2( sub2ind( size(M2), Oi, 2*Oj ) ) = sub2ind( size(M2), Oi, 2*Oj-1 );

M2 = move( M2, D );
[ Oi, Oj ] = ind2sub( size(M2), find( ( M2 > 0 ) & [ false( size(M,1), 1 ) ( M2(:,2:end) > M2(:,1:end-1) ) ] ) );
sum( 100*Oi + Oj - 101 )
