
[ N, M ] = readin( 'input.txt' );

M1 = solveAll( M );
r = strcmp( N, 'root' );
uint64( M1(r).value )

%%

M( strcmp( N, 'humn' ) ).value = [ 1 0 ];
M2 = solveAll( M );

A = M2( M2(r).i1 ).value; B = M2( M2(r).i2 ).value;
lA = length(A); lB = length(B);
uint64( roots( [ zeros(lB-lA) A ] - [ zeros(lA-lB) B ] ) )

%%

function M = solveAll( M )

I1 = [ M.i1 ];
I2 = [ M.i2 ];

R = cellfun( @isempty, { M.value } );
while any( R )
  for k = find( R & ~R(I1) & ~R(I2) )
    M(k).value = M(k).op( M(M(k).i1).value, M(M(k).i2).value );
  end
  R = cellfun( @isempty, { M.value } );
end

end