function [R, C] = readin( filename )

L = readlines( filename, 'EmptyLineRule', 'skip');
n = length( L );

R = cell( n, 1 );
C = cell( n, 1 );

for i = 1:n
  n = regexp( L(i), '(?<r>[.#?]+) (?<c>[0-9,]+)', 'names' );
  R{i} = char( n.r );
  C{i} = str2num( n.c ); %#ok<ST2NM> 
end

