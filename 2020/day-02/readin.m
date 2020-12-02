function P = readin( file )

  P = repmat( struct('min', 0, 'max', 0, 'c', '', 'password', ''), 0, 1 );

  fid = fopen( file );

  t = fgetl( fid );
  while t ~= -1

    T = regexp( t, '(\d+)-(\d+) (\w): (\w+)', 'tokens' );

    P(end+1) = struct( ...
      'min', str2double( T{1}{1} ), ...
      'max', str2double( T{1}{2} ), ...
      'c', T{1}{3}, ...
      'password', T{1}{4} );

  t = fgetl( fid );

  end

  fclose( fid );

end