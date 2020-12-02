function data = readin( in )

  elts = struct( 'ORE', 1, 'FUEL', 2 );
  N = 2;
  
  function idx = getIdx( name )
    if ~isfield( elts, name )
      N = N + 1;
      elts.(name) = N;
      M = [ M zeros( N, 1 ); zeros( 1, N ) ];
    end
    idx = elts.(name);
  end

  M = zeros( N+1, N );

  fid = fopen( in );

  t = fgetl( fid );
  while t ~= -1

    T = regexp( t, '(\d+) (\w+)', 'tokens' );
    
    res = getIdx( T{end}{2} );
    M( 1, res ) = str2double( T{end}{1} );
    
    for i = 1:length(T)-1
      M( getIdx( T{i}{2} ) + 1, res ) = str2double( T{i}{1} );
    end

    t = fgetl( fid );

  end

  fclose( fid );
  
  data = struct( ...
    'elts', elts, ...
    'M', M );

end
