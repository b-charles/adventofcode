
[ D, K, M ] = readin( 'input.txt' );
ld = length(D);

A = 1:size(M,1);
for d = D
  A = M( A, d );
end

searchloop( A, find( ismember( K, 'AAA', 'rows' ) ), find( ismember( K, 'ZZZ', 'rows' ) ) ) * ld %#ok<NOPTS> 

%%

z = find( K(:,3) == 'Z' );

s = 1;
for l = arrayfun( @(k) searchloop( A, k, z ), find( K(:,3) == 'A' ) )'
  s = lcm( s, l );
end

uint64( s * ld )

%%

function s = searchloop( A, k, Z )
s = 0;
while ~ismember( k, Z )
  k = A(k);
  s = s + 1;
end
end