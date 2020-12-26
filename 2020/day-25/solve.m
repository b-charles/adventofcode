
% Pub = [ 5764801 17807724 ];
Pub = [ 14788856 19316454 ];

k = 0; f = modExp(7,k);
while all( Pub ~= f )
  k = k + 1; f = modExp(7,k);
end

disp( modExp( Pub( Pub ~= f ), k ) );

%%

function y = modExp( b, e )
  y = uint64(1);
  while e > 0
    if mod(e,2) == 1
      y = mod( y*b, 20201227 );
    end
    e = bitshift(e,-1);
    b = mod( b*b, 20201227 );
  end
end
