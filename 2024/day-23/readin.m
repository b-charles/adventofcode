function [ N, A ] = readin( filename )

L = char( readlines( filename, 'EmptyLineRule', 'skip' ) );
N = unique( [ L(:,1) L(:,2) ; L(:,4) L(:,5) ], 'rows' );

A = false( size(N,1), size(N,1) );

for l = L'

  [ ~, i ] = ismember( [ l(1) l(2) ], N, 'rows' );
  [ ~, j ] = ismember( [ l(4) l(5) ], N, 'rows' );
  A( i, j ) = true;
  A( j, i ) = true;

end
