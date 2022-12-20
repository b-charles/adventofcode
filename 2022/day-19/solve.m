
BP = readin( 'input.txt' );

arrayfun( @(k) opti( BP(k,:), 24, [0 0 0 0], [1 0 0 0] )*[0 0 0 1]', 1:size(BP,1) )*(1:size(BP,1))' %#ok<NOPTS>

%%

prod( arrayfun( @(k) opti( BP(k,:), 32, [0 0 0 0], [1 0 0 0] )*[0 0 0 1]', 1:3 ) )

%%

function RES = opti( BP, t, RES, ROB )

C = zeros( 5, 4 );
C(1,:) = RES + t*ROB;

if C(1,1) < t*max( BP([1 2 3 5]) )
  w = ceil( max( BP(1) - RES(1), 0 ) / ROB(1) );
  if w < t
    C(2,:) = opti( BP, t-w-1, RES - [ BP(1) 0 0 0 ] + (w+1)*ROB, ROB + [ 1 0 0 0 ] );
  end
end

if C(1,2) < t* BP(4)
  w = ceil( max( BP(2) - RES(1), 0 ) / ROB(1) );
  if w < t
    C(3,:) = opti( BP, t-w-1, RES - [ BP(2) 0 0 0 ] + (w+1)*ROB, ROB + [ 0 1 0 0 ] );
  end
end

if C(1,3) < t*BP(6)
  w = max( ceil( max( BP(3) - RES(1), 0 ) / ROB(1) ), ceil( max( BP(4) - RES(2), 0 ) / ROB(2) ) );
  if w < t
    C(4,:) = opti( BP, t-w-1, RES - [ BP(3) BP(4) 0 0 ] + (w+1)*ROB, ROB + [ 0 0 1 0 ] );
  end
end

w = max( ceil( max( BP(5) - RES(1), 0 ) / ROB(1) ), ceil( max( BP(6) - RES(3), 0 ) / ROB(3) ) );
if w < t
  C(5,:) = opti( BP, t-w-1, RES - [ BP(5) 0 BP(6) 0 ] + (w+1)*ROB, ROB + [ 0 0 0 1 ] );
end

[ ~, i ] = max( C(:,4) );
RES = C(i,:);

end