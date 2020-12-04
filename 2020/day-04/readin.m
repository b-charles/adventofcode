function P = readin( file )

  function s = emptyPassport()
    s = struct( ...
      'byr', '', ...
      'iyr', '', ...
      'eyr', '', ...
      'hgt', '', ...
      'hcl', '', ...
      'ecl', '', ...
      'pid', '', ...
      'cid', '' );
  end
  
  current = emptyPassport();
  P = repmat( current, 0, 1 );
  
  fid = fopen( file );

  t = fgetl( fid );
  while ischar( t )
    
    if isempty( strip( t ) )
      P( end+1 ) = current; %#ok<AGROW>
      current = emptyPassport();
      t = fgetl( fid );
      continue
    end
    
    tokens = regexp( t, '(\w+):([^\s]+)', 'tokens' );
    for i = 1:length( tokens )
      current.( tokens{i}{1} ) = tokens{i}{2};
    end
    
    t = fgetl( fid );

  end
  
  P( end+1 ) = current;
  
  fclose( fid );

end