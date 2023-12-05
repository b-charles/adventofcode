
[ S, CM ] = readin( 'input.txt' );

S1 = [ S' ones(length(S), 1) ];
for M = CM
  S1 = gardenmap( M{1}, S1 );
end
min(S1(:,1))

%%

S2 = reshape( S, 2, [] )';
for M = CM
  S2 = gardenmap( M{1}, S2 );
end
min(S2(:,1))
