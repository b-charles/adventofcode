function R = readin( in )

  fid = fopen( in );

  R = struct();
  t = fgetl( in );
  while t ~= -1

    T = regexp( '7 A, 1 B => 1 C', '=> (\d+) (\w+)', 'tokens' )
    produced = str2double( T{1} );
    name = T{2};

    t = fgetl( in );

  end

  fclose( fid );

end
