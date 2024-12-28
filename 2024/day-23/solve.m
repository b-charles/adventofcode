
[ N, A ] = readin(  'input.txt' );

S = nchoosek( 1:size(N,1), 3 );

S = S( A( sub2ind( size(A), S(:,1), S(:,2) ) ), : );
S = S( A( sub2ind( size(A), S(:,1), S(:,3) ) ), : );
S = S( A( sub2ind( size(A), S(:,2), S(:,3) ) ), : );

P = S( N(S(:,1),1) == 't' | N(S(:,2),1) == 't' | N(S(:,3),1) == 't', : );
size( P, 1 )

%%

I = 1:size(N,1);
while ~isempty( S )

  P = zeros( 0, size(S,2)+1 );
  for i = 1:size(S,1)

    M = ismember( I, S(i,:) );
    O = find( all( A(M,:), 1 ) & ~M );

    if ~isempty( O )
      P = [ P ; [ repmat( S(i,:), size(O,2), 1 ) O' ] ]; %#ok<AGROW>
    end

  end

  P = unique( sort( P, 2 ), 'rows' );

  if isempty( P )
    break
  end

  S = P;
  fprintf( '%d - %d\n', size(S,2), size(S,1) );

end

join( string( N(S,:) ), ',' )
