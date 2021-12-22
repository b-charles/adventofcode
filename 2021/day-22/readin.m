function [ S, C ] = readin( file )

lines = readlines( file, 'EmptyLineRule', 'skip' );

s = length( lines );
S = false( s, 1 );
C = zeros( s, 6 );

for l = 1:s
  T = regexp( lines(l), '(on|off) x=(-?\d+)..(-?\d+),y=(-?\d+)..(-?\d+),z=(-?\d+)..(-?\d+)', 'tokens' );
  S(l) = T{1}(1) == 'on';
  C(l,:) = str2double( T{1}(2:end) );
end
