function l = padCmdLength( s, g, r )

persistent DIRPAD CACHE;
if isempty( DIRPAD )

  % ^ 1     ^A
  % < 2    <V>
  % > 3
  % V 4
  % A 5

  DIRPAD = { ...
    [], [ 4 2 ], [ 4 3 ], 4, 3 ; ...
    [ 3 1 ], [], [ 3 3 ], 3, [ 3 3 1 ] ; ...
    [ 2 1 ], [ 2 2 ], [], 2, 1 ; ...
    1, 2, 3, [], [ 1 3 ] ; ...
    2, [ 4 2 2 ], 4, [ 2 4 ], [] };

  CACHE = -ones( 25, 25 );

end

if r == 0
  l = 1;
  return
end

c = s + (g-1)*5;
if CACHE( c, r ) ~= -1
  l = CACHE( c, r );
  return
end

P = [ 5 DIRPAD{ s, g } 5 ];

l = 0;
for n = 1:size(P,2)-1
  l = l + padCmdLength( P(n), P(n+1), r-1 );
end

CACHE( c, r ) = l;
