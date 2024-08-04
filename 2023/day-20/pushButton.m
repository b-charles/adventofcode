function [ signals, states ] = pushButton( A, M, states )

BUFFER_SIZE = 100;

if isempty( states )
  states = cell( 1, length( M ) );
end

broadcaster = find( strcmp( A, 'broadcaster' ) );

signals = zeros( BUFFER_SIZE, 3 );
signals( 1, : ) = [ 0, broadcaster, 1 ];
head = 1;
tail = 1;

while head <= tail

  s = signals( head, : );
  head = head + 1;

  [ S, states{s(2)} ] = M{s(2)}( s, states{s(2)} );

  last = tail + size( S, 1 );
  if last > size( signals, 1 )
    signals = [ signals ; zeros( BUFFER_SIZE, 3 ) ]; %#ok<AGROW>
  end

  signals( ( tail + 1 ):last, : ) = S;
  tail = last;

end

signals = signals( 1:tail, : );
