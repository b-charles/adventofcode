
C = char( readlines( 'input.txt', 'EmptyLineRule', 'skip' ) );
[si, sj] = size( C );
[I, J] = meshgrid( 1:si, 1:sj );
I = I(:);
J = J(:);

IND_I = [
  I I I I
  I I+1 I+2 I+3
  I I+1 I+2 I+3
  I I+1 I+2 I+3
  I I I I
  I I-1 I-2 I-3
  I I-1 I-2 I-3
  I I-1 I-2 I-3
  ];

IND_J = [
  J J+1 J+2 J+3
  J J+1 J+2 J+3
  J J J J
  J J-1 J-2 J-3
  J J-1 J-2 J-3
  J J-1 J-2 J-3
  J J J J
  J J+1 J+2 J+3
  ];

V = all( ( 1 <= IND_I & IND_I <= si ) & ( 1 <= IND_J & IND_J <= sj ), 2 );
W = C( sub2ind( [si, sj], IND_I(V, :), IND_J(V,:) ) );

sum( W(:,1) == 'X' & W(:,2) == 'M' & W(:,3) == 'A' & W(:,4) == 'S' )

%%

IND_I = [ I I I+1 I+2 I+2 ];
IND_J = [ J J+2 J+1 J J+2 ];

V = all( ( 1 <= IND_I & IND_I <= si ) & ( 1 <= IND_J & IND_J <= sj ), 2 );
W = C( sub2ind( [si, sj], IND_I(V, :), IND_J(V,:) ) );

sum( W(:,3) == 'A' & all( sort( W(:,[ 1 2 4 5 ]), 2 ) == repmat( 'MMSS', size(W,1), 1 ), 2 ) & W(:,1) ~= W(:,5) )
