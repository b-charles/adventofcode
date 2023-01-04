
C = cell2mat( convertStringsToChars( readlines( 'input.txt', 'EmptyLineRule', 'skip' ) ) );
s = size( C );

[ WUX, WUY ] = find( C == '^' );
[ WRX, WRY ] = find( C == '>' );
[ WDX, WDY ] = find( C == 'v' );
[ WLX, WLY ] = find( C == '<' );
W = [ ...
  WUX WUY -ones( size(WUX,1), 1 ) zeros( size(WUX,1), 1 ) ; ...
  WRX WRY zeros( size(WRX,1), 1 ) ones( size(WRX,1), 1 ) ; ...
  WDX WDY ones( size(WDX,1), 1 ) zeros( size(WDX,1), 1 ) ; ...
  WLX WLY zeros( size(WLX,1), 1 ) -ones( size(WLX,1), 1 ) ];

t = 0;

T = false( s ); T(1,2) = true;
while ~T(end,end-1)
  [ W, T, t ] = windStep( s, W, T, t );
end

t %#ok<*NOPTS>

%%

T = false( s ); T(end,end-1) = true;
while ~T(1,2)
  [ W, T, t ] = windStep( s, W, T, t );
end

T = false( s ); T(1,2) = true;
while ~T(end,end-1)
  [ W, T, t ] = windStep( s, W, T, t );
end

t

%%

function [ W, T, t ] = windStep( s, W, T, t )

W(:,1) = mod( W(:,1) + W(:,3) - 2, s(1)-2 ) + 2;
W(:,2) = mod( W(:,2) + W(:,4) - 2, s(2)-2 ) + 2;

M = false( s );
M( sub2ind( s, W(:,1), W(:,2) ) ) = true;

T = ( T | ...
  [ false(1,s(2)) ; T(1:end-1,:) ] | ...
  [ T(2:end,:) ; false(1,s(2)) ] | ...
  [ false(s(1),1) T(:,1:end-1) ] | ...
  [ T(:,2:end) false(s(1),1) ] ) & ~M;
T(:,1) = false; T(:,end) = false;
T(1,3:end) = false; T(end,1:end-2) = false;

t = t + 1;

end