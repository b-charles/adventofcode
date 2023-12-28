
[ N, M ] = readin( 'input.txt' );
% [ N, M ] = readin( 'test2.txt' );

broadcaster = find( strcmp( N, 'broadcaster' ) );

states = cell( 1, length( M ) );
low = 0;
high = 0;

for k = 1:1000

  B = [ 0 0 broadcaster ];
  low = low + 1;

  while ~isempty( B )

    b = B(1,:);
    [ b, states{b(3)} ] = M{b(3)}( b(1), b(2), states{b(3)} );
    low = low + sum( ~b(:,2) );
    high = high + sum( b(:,2) );

    B = [ B(2:end,:) ; b ];

  end

end

high * low %#ok<*NOPTS>

%% 787056720 /

rx = find( strcmp( N, 'rx' ) );
states = cell( 1, length( M ) );

count = 0;
stop = false;

while ~stop

  B = [ 0 0 broadcaster ];
  count = count + 1;

  while ~isempty( B ) && ~stop

    b = B(1,:);
    [ b, states{b(3)} ] = M{b(3)}( b(1), b(2), states{b(3)} );
    B = [ B(2:end,:) ; b ];

    stop = any( B(:,2) == 0 & B(:,3) == rx );

  end

end

count
