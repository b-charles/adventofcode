
clear all
clc

% C = readin( 'demo1.in' );
% C = readin( 'demo2.in' );
% C = readin( 'demo3.in' );
% C = readin( 'demo4.in' );
% C = readin( 'demo5.in' );
C = readin( 'data.in' );

simplify( C, 1 )


%%

f = @(fuel)simplify(C,fuel)-1000000000000;

m = 1;
while( f(m) < 0 )
  m = 10 * m;
end

M = [ 1 m ];

while diff( M ) > 1
  m = floor( ( M(1) + M(2) ) /2 );
  M( 1 + ( f(m) >= 0 ) ) = m;
end

M(1)
