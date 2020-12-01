
clear all;
clc;

% P = [ -1, 0, 2; 2, -10, -7; 4, -8, 8; 3, 5, -1 ]';
P = [ 1, -4, 3; -14, 9, -4; -4, -6, 7; 6, -9, -11 ]';
V = zeros( 3, 4 );

P2 = P;
V2 = P;
for i = 1: 1000
  [P2, V2] = step( P2, V2 );
end

E = sum(abs(P2), 1) * sum(abs(V2),1)'

%%

X = P(1,:);
VX = V(1,:);

x = 1;
[ X2, VX2 ] = step( X, VX );
while any( [ X2 VX2 ] ~= [ X VX ] )
  [ X2, VX2 ] = step( X2, VX2 );
  x = x + 1;
end

Y = P(2,:);
VY = V(2,:);

y = 1;
[ Y2, VY2 ] = step( Y, VY );
while any( [ Y2 VY2 ] ~= [ Y VY ] )
  [ Y2, VY2 ] = step( Y2, VY2 );
  y = y + 1;
end

Z = P(3,:);
VZ = V(3,:);

z = 1;
[ Z2, VZ2 ] = step( Z, VZ );
while any( [ Z2 VZ2 ] ~= [ Z VZ ] )
  [ Z2, VZ2 ] = step( Z2, VZ2 );
  z = z + 1;
end

lcm( lcm(x,y), z )

