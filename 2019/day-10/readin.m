function M = readin( in )

  if isfile( in )
    in = cell2mat( split( strip( fileread( in ) ) ) );
  end

  M = in == '#';

end
