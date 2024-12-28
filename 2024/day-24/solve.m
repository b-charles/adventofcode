
[ N, V, OP ] = readin( 'input.txt' );

E = isnan(V);
while any( E )

  I = ~E(OP(:,1)) & ~E(OP(:,2)) & E(OP(:,3)) & OP(:,4) == 1;
  V(OP(I,3)) = bitand( V(OP(I,1)), V(OP(I,2)) );

  I = ~E(OP(:,1)) & ~E(OP(:,2)) & E(OP(:,3)) & OP(:,4) == 2;
  V(OP(I,3)) = bitor( V(OP(I,1)), V(OP(I,2)) );

  I = ~E(OP(:,1)) & ~E(OP(:,2)) & E(OP(:,3)) & OP(:,4) == 3;
  V(OP(I,3)) = bitxor( V(OP(I,1)), V(OP(I,2)) );

  E = isnan(V);

end

[ ~, S ] = sortrows( N, 'descend' );
T = V(S);
uint64( bin2dec( char( T(N(S,1) == 'z')' + '0' ) ) )

%%

% done by hand
% see notes.md

fid = fopen( 'graph.dot', 'w' );

fprintf( fid, 'digraph DAY24 {\n' );

A = { 'normal', 'tee', 'diamond' };
for v = OP'
  fprintf( fid, '"%s" -> "%s" [arrowhead = %s];\n', N(v(1),:), N(v(3),:), A{v(4)} );
  fprintf( fid, '"%s" -> "%s" [arrowhead = %s];\n', N(v(2),:), N(v(3),:), A{v(4)} );
end

fprintf( fid, '}' );
fclose( fid );

% dot -Tsvg graph.dot > graph.svg
