
[ N, M ] = readin( 'input.txt' );

states = {};

low = 0;
high = 0;

for k = 1:1000

  [ signals, states ] = pushButton( N, M, states );

  low = low + sum( signals(:,3) == 1 );
  high = high + sum( signals(:,3) == 2 );

end

high * low %#ok<*NOPTS>

%%

% Use graphviz to analyze end of module chain.
% Here: rx <- ql <- { fz, ss, fh, mh }

ql = find( strcmp( N, 'ql' ) );

fz = find( strcmp( N, 'fz' ) );
ss = find( strcmp( N, 'ss' ) );
fh = find( strcmp( N, 'fh' ) );
mf = find( strcmp( N, 'mf' ) );

fzSig = [ fz ql 2 ];
ssSig = [ ss ql 2 ];
fhSig = [ fh ql 2 ];
mfSig = [ mf ql 2 ];

I = [ 0, 0, 0, 0 ];

states = {};

count = 0;

while any( I ==  0 )

  count = count + 1;
  [ signals, states ] = pushButton( N, M, states );

  if I(1) == 0 && ismember( fzSig, signals, 'rows' )
    I(1) = count;
  end
  if I(2) == 0 && ismember( ssSig, signals, 'rows' )
    I(2) = count;
  end
  if I(3) == 0 && ismember( fhSig, signals, 'rows' )
    I(3) = count;
  end
  if I(4) == 0 && ismember( mfSig, signals, 'rows' )
    I(4) = count;
  end

end

uint64( lcm( I(1), lcm( I(2), lcm( I(3), I(4) ) ) ) )
