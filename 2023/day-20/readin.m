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

  function [B, state] = broadcaster( ~, in, state, self, O )
    B = [ repmat( [ self in ], length(O), 1 ) O' ];
  end

  function [B, state] = flipflop( ~, in, state, self, O )
    if isempty( state )
      state = false;
    end
    if in == 1
      B = zeros( 0, 3 );
      return
    end
    state = ~state;
    B = [ repmat( [ self state ], length(O), 1 ) O' ];
  end

  function [B, state] = conjunction( src, in, state, self, I, O )
    if isempty( state )
      state = false( 1, length( I ) );
    end
    state( I == src ) = in;
    B = [ repmat( [ self ~all(state) ], length(O), 1 ) O' ];
  end

  function [B, state] = noop( ~, ~, state )
    B = zeros( 0, 3 );
  end

for i = 1:n

  self = find( strcmp( N{i}, A ) );
  out = cellfun( @(o) find( strcmp( A, o ), 1 ), O{i} );

  if T(i) == 0
    M{self} = @(src, in, state) broadcaster( src, in, state, self, out );
  elseif T(i) == 1
    M{self} = @(src, in, state) flipflop( src, in, state, self, out );
  else % T(i ) == 2
    allin =  cellfun( @(o) ismember( N{i}, o ), O ) ;
    [ ~ , allin ] = ismember( N(allin), A );
    M{self} = @(src, in, state) conjunction( src, in, state, self, allin, out );
  end

end

for k = find( cellfun( @isempty, M ) )
  M{k} = @noop;
end

end
