function INS = readin( file )

INS = repmat( struct( ...
  'op', '', ...
  'arg', [] ), 1, 0 );

fid = fopen( file );

t = fgetl( fid );
while ischar( t )
  
  T = regexp( t, '(\w+) ([-+]?\d+)', 'tokens' );
  INS(end+1) = struct( ...
    'op', T{1}{1}, ...
    'arg', str2double( T{1}{2} ) );
  
  t = fgetl( fid );
  
end

fclose( fid );

end