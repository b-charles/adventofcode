
[ L, K ] = readin( 'input.txt' );

n = 0;
for k = 1:size(K,1)
  n = n + sum( all( L + repmat( K(k,:), size(L,1), 1 ) <= 5, 2 ) );
end
n
