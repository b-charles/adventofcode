
[ R , P ] = readin( 'input.txt' );

out = @(A) mod( bitxor( mod(A,8), bitxor( 6, bitshift( A, -bitxor( mod(A,8), 3 ) ) ) ), 8 );

A = R{2};

O = [];
while A > 0
  O = [ O out(A) ]; %#ok<AGROW>
  A = floor( A / 8 );
end
[ sprintf('%d', O(1)) sprintf( ',%d', O(2:end) ) ] %#ok<NOPTS>

%%

A = 0;
for p = flip(P)
  T = unique( A(:)*8 + repmat( 0:7, length(A), 1 ) );
  A = T( out(T) == p );
end

uint64( min(A) )
