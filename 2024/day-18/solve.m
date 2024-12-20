
P = cell2mat( arrayfun( @str2num, readlines( 'input.txt', 'EmptyLineRule', 'skip' ) , 'UniformOutput', false) );
S = 71;

PI = sub2ind( [ S S ], P(:,2)+1, P(:,1)+1 );

PI1 = PI( 1:1024 );
M = Inf( [ S S ] );
Mn = M;
M( 1 ) = 0;

while any( M ~= Mn, 'all' )

  Mn = M;
  M = min( cat( 3, M, ...
    [ Inf(S,1) M(:,1:end-1) ]+1, ...
    [ M(:,2:end) Inf(S,1) ]+1, ...
    [ Inf(1,S) ; M(1:end-1,:) ]+1, ...
    [ M(2:end,:) ; Inf(1,S) ]+1 ), [], 3 );
  M( PI1 ) = Inf;

end

M( S*S )

%%

b = [ 1 length(PI) ];

while b(1)+1 < b(2)

  t = floor( ( b(1)+b(2) )/2 );
  PI2 = PI( 1:t );

  M = false( [ S S ] );
  Mn = M;
  M( 1 ) = true;

  while any( M ~= Mn, 'all' )
    Mn = M;
    M = conv2( M, [ 0 1 0 ; 1 1 1 ; 0 1 0 ], 'same' ) > 0;
    M( PI2 ) = false;
  end

  b( 2 - M(S*S) ) = t;

end

sprintf( '%d,%d', P(b(2),1), P(b(2),2) )