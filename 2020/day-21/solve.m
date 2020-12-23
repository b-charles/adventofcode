
[ I, A, Ri, Ra ] = readin( 'data.in' );

[ nr, ni ] = size( Ri );
na = size( Ra, 2 );

M = true( ni, na );
for r = 1:nr
  M( ~Ri(r,:), Ra(r,:) ) = false;
end
a = zeros( 1, na );
while any( a == 0 )
  i = find( sum( M, 1 ) == 1 );
  j = find( M(:,i) );
  a(i) = j;
  M(j,:) = false;
end

disp( sum( sum( Ri( :, setdiff(1:ni,a) ) ) ) );

%%

ing = fields( I );
R = join( cellfun( @(n) ing{a(A.(n))}, sort( fields( A ) ), 'UniformOutput', false ), ',' );
disp( R{1} );
