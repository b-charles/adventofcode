function [ A, M ] = readin( filename )

L = readlines( filename, 'EmptyLineRule', 'skip' );
n = length( L );

N = cell( 1, n );
T = zeros( 1, n ); % 0: broadcaster, 1: flip-flop, 2: conjunction
O = cell( 1, n );

for i = 1:n

  R = regexp( char(L(i)), '(?<type>[%&]?)(?<name>\w+) -> (?<out>.*)', 'names' );
  N{i} = R.name;
  T(i) = strcmp( R.type, '%' ) + 2*strcmp( R.type, '&' );
  O{i} = regexp( R.out, '\w+', 'match' );

end

A = unique( horzcat( N, O{:} ) );
M = cell( 1, length( A ) );

  function [ S, state ] = broadcaster( sig, state, lowhigh )
    S = lowhigh{ 1 + sig(3) };
  end

  function [ S, state ] = flipflop( sig, state, lowhigh )
    if isempty( state )
      state = false;
    end
    if sig(3) == 1
      state = ~state;
      S = lowhigh{ 2 + state };
    else
      S = lowhigh{ 1 };
    end
  end

  function [ S, state ] = conjunction( sig, state, in, lowhigh )
    if isempty( state )
      state = false( 1, length( in ) );
    end
    state( find( sig(1) == in, 1 ) ) = sig(3) == 2;
    S = lowhigh{ 3 - all( state ) };
  end

  function [ S, state ] = noop( ~, state )
    S = zeros( 0, 3 );
  end

for i = 1:n

  self = find( strcmp( N{i}, A ) );

  out = cellfun( @(o) find( strcmp( A, o ), 1 ), O{i} );
  nbOut = length( out );

  low = zeros( nbOut, 3 );
  low( :, 1 ) = self;
  low( :, 2 ) = out(:);
  low( :, 3 ) = 1;

  high = zeros( nbOut, 3 );
  high( :, 1 ) = self;
  high( :, 2 ) = out(:);
  high( :, 3 ) = 2;

  lh = { zeros( 0, 3 ), low, high };

  if T(i) == 0
    M{self} = @(sig, state) broadcaster( sig, state, lh );
  elseif T(i) == 1
    M{self} = @(sig, state) flipflop( sig, state, lh );
  else % T(i) == 2
    allin =  cellfun( @(o) ismember( N{i}, o ), O );
    [ ~ , allin ] = ismember( N(allin), A );
    M{self} = @(sig, state) conjunction( sig, state, allin, lh );
  end

end

for k = find( cellfun( @isempty, M ) )
  M{k} = @noop;
end

end
