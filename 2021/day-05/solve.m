
fid = fopen( 'input.txt' );
M = reshape( fscanf( fid, '%f,%f -> %f,%f'), 4, [] )';
fclose(fid );

sz = max( M(:) );
G = zeros( sz );
HV = ( M(:,1) == M(:,3) | M(:,2) == M(:,4) )';

for i = find( HV )
    P = indexes( sz, M(i,1), M(i,2), M(i,3), M(i,4) );
    G(P) = G(P) + 1;
end

sum( G(:) > 1 )

%%

for i = find( ~HV )
    P = indexes( sz, M(i,1), M(i,2), M(i,3), M(i,4) );
    G(P) = G(P) + 1;
end

sum( G(:) > 1 )

%%

function P = indexes( sz, x1, y1, x2, y2 )
X = x1:2*(x1<x2)-1:x2;
Y = y1:2*(y1<y2)-1:y2;
P = Y + sz*( X - 1 ) + 1;
end
