function C = readin( file )

  fid = fopen( file );

  C = { false( 0, 26 ) };

  t = fgetl( fid );
  while ischar( t )

    if isempty( strip( t ) )
      C{end+1} = false( 0, 26 );
      t = fgetl( fid );
      continue
    end

    F = false( 1, 26 );
    F( t - 'a' + 1 ) = true;
    C{end}(end+1,:) = F;

    t = fgetl( fid );

  end

  fclose( fid );

end