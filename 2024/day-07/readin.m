function C = readin( filename )

C = repmat( struct(...
  'test', [], ...
  'values', [] ), 0, 1 );

fid = fopen( filename );

line = fgetl( fid );
while ischar( line )
  S = strsplit( line, ':' );
  C = [ C struct( ...
    'test', str2double( S{1} ), ...
    'values', str2num( S{2} ) ) ]; %#ok<AGROW,ST2NM> 
  line = fgetl( fid );
end

fclose( fid );