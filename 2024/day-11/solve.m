
S = str2num( readlines( 'input.txt', 'EmptyLineRule', 'skip' ) ); %#ok<ST2NM>
P = -ones( 1000, 50 );

w = 0;
for s = S
  [ b, P ] = blink( s, 25, P );
  w = w + b;
end

w

%%

w = 0;
for s = S
  [ b, P ] = blink( s, 75, P );
  w = w + b;
end

uint64( w )
