
L = char( readlines( 'input.txt', 'EmptyLineRule', 'skip' ) );
S = split( L, ',' );

hash = @(s) mod( s * ( 17.^(length(s):-1:1)' ), 256 );

sum( cellfun( hash, S ) )

%%

B = arrayfun( @(i) repmat( struct( 'n', [], 'v', [] ), 0, 1 ), 1:256, 'UniformOutput', false );

for i = 1:length(S)
  if any( S{i} == '=' )

    d = regexp( S{i}, '(?<n>[^=]+)=(?<v>\d+)', 'names' );
    d.v = str2double( d.v );

    h = hash( d.n ) + 1;
    f = find( strcmp( d.n, { B{h}.n } ) );
    if isempty( f )
      B{h} = [ B{h} d ];
    else
      B{h}(f).v = d.v;
    end

  else % n-

    n = S{i}(1:end-1);
    h = hash( n ) + 1;
    B{ h }( strcmp( n, { B{h}.n } ) ) = [];

  end

end

cellfun( @(b) sum( (1:length(b)) .* [ b.v ] ), B ) * (1:256)' %#ok<NOPTS> 
