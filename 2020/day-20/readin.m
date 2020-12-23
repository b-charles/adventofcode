function T = readin( file )
  
  T = repmat( struct( ...
    'id', 0, ...
    'tile', [] ), 1, 0);
  
  fid = fopen( file );
  
  line = fgetl( fid );
  
  while ischar( line )
    
    tok = regexp( line, 'Tile (\d+):', 'tokens' );
    
    tile = [];
    line = fgetl( fid );
    while ischar( line ) && ~isempty( line )
      tile(end+1,:) = line == '#'; %#ok<AGROW>
      line = fgetl( fid );
    end
        
    T(end+1) = struct( ...
      'id', str2double( tok{1}{1} ), ...
      'tile', tile ); %#ok<AGROW>
    
    line = fgetl( fid );
    
  end
  
  fclose( fid );
  
end