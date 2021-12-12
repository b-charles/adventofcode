function [ N, M ] = readin( file )

if isfile( file )
  lines = readlines( file, 'EmptyLineRule', 'skip' );
else
  lines = file;
end

N = unique( regexp( strjoin( lines, ' ' ), '\w+', 'match' ) );

n = length( N );

M = zeros( n );
for l = lines'
  names = regexp( l, '(\w+)', 'match' );
  [ ~, i ] = ismember( names(1), N );
  [ ~, j ] = ismember( names(2), N );
  M(i,j) = 1;
  M(j,i) = 1;
end

end