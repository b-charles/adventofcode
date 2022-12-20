
H = cell2mat( readmatrix( 'input.txt', 'OutputType', 'char' ) ) - '0';

[ J, I ] = ndgrid( 1:n );

sum( ...
  arrayfun( @(i,j) all( H(i,j)>H(1:i-1,j) ), I, J ) | ...
  arrayfun( @(i,j) all( H(i,j)>H(i+1:end,j) ), I, J ) | ...
  arrayfun( @(i,j) all( H(i,j)>H(i,1:j-1) ), I, J ) | ...
  arrayfun( @(i,j) all( H(i,j)>H(i,j+1:end) ), I, J ), 'all' )

%%

max( ...
  arrayfun( @(i,j) find( H(i,j)<=[H(i-1:-1:2, j);9], 1), I, J ) .* ...
  arrayfun( @(i,j) find( H(i,j)<=[H(i+1:end-1,j);9], 1), I, J ) .* ...
  arrayfun( @(i,j) find( H(i,j)<=[H(i, j-1:-1:2) 9], 1), I, J ) .* ...
  arrayfun( @(i,j) find( H(i,j)<=[H(i,j+1:end-1) 9], 1), I, J ), [], 'all' )