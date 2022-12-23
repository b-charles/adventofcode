
D = readmatrix( 'input.txt' )';

result( D, mix( D, 1:length(D) ) )

%%

M = D * 811589153;
P = 1:length(D);
for k = 1:10
  P = mix( M, P );
end
uint64( result( M, P ) )

%%

function P = mix( D, P )
l = length(D);
for k = 1:l
  p = P(k);
  n = mod( p+D(k)-1, l-1 ) + 1;
  A = min(p,n) <= P & P <= max(p,n);
  P(A) = mod( P(A) - 1 + sign(p-n), l )+1;
  P(k) = n;
end
end

function r = result( D, P )
l = length(D);
z = find( D == 0, 1 );
r = D( find( P == mod(P(z)+1000-1,l)+1, 1 ) ) + ...
  D( find( P == mod(P(z)+2000-1,l)+1, 1 ) ) + ...
  D( find( P == mod(P(z)+3000-1,l)+1, 1 ) );
end