
clear all
clc

% in = readin( 'demo1.in' );
% in = readin( 'demo2.in' );
% in = readin( 'demo3.in' );
% in = readin( 'demo4.in' );
% in = readin( 'demo5.in' );
% in = readin( 'demo6.in' );
in = readin( 'data.in' );

[ Sy, Sx ] = size( in );
[ Y, X ] = ndgrid( 1:Sy, 1:Sx );

A = [ X(in) Y(in) ]' - 1;
N = size( A, 2 );

R = zeros( 2, N, N-1 );
for i = 1:N
  a = A( :, i );
  r = [ A( :, 1:i-1 ) A( :, i+1:end ) ];
  R(:, i, : ) = r - repmat( a, 1, N-1 );
end

az = atan2( R(2,:,:), R(1,:,:) );

V = zeros( 1, N );
for i = 1:N
  V(i) = length( unique( az( :,i,: ) ) );
end

[ v, i ] = max(V)
O = A(:,i)
A = [ A(:,1:i-1) A(:,i+1:end) ];

R = A - repmat( O, 1, N-1 );
d = R(1,:).^2 + R(2,:).^2;
az = mod( (pi/2) - atan2( -R(2,:), R(1,:) ), 2*pi );

S = zeros( 1, N-1 );
sorted = false( 1, N-1 );
t = -1;
for i = 1:N-1

  rest = find( ~sorted );

  idx = rest( az(rest) > t );
  if isempty( idx )
    t = -1;
    idx = rest( az(rest) > t );
  end

  t = min( az( idx ) );
  idx = idx( az( idx ) == t );

  [ ~, k ] = min( d( idx ) );
  k = idx(k);

  S(i) = k;
  sorted( k ) = true;

end

[ 100 1 ] * ( A(:,S(200)) )


