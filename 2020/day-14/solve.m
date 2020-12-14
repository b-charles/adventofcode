
D = readin( 'data.in' );

W = 2.^(35:-1:0);

ADDR = [ D.addr ];
MEM = zeros( 1, max( ADDR ) );
MEM( ADDR ) = arrayfun( @(d) bitand( bitor( d.val, W*(d.mask=='1')' ), W*(d.mask~='0')' ), D );

disp( uint64( sum( MEM ) ) );

%%

MEM = cell2mat( arrayfun( @(d) expand( W, bitor( d.addr, W*(d.mask=='1')' ), find( d.mask == 'X' ), d.val ), D, 'UniformOutput', false )' );
[ ~, I ] = unique( MEM(:,1), 'last' );
disp( uint64( sum( MEM(I,2) ) ) );

function M = expand( W, a, I, v )
  n = length( I );
  A = repmat( dec2bin( a, 36 ) == '1', 2^n, 1 );
  A(:,I) = dec2bin( 0:2^n-1 ) == '1';
  M = [ W*A' ; repmat( v, 1, 2^n ) ]';
end
