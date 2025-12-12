function M = readin( filename )

M = repmat( struct( ...
  'lights', [], ...
  'wiring', [], ...
  'joltage', [] ), 1, 0 );

fid = fopen( filename );

line = fgetl( fid );
while ischar( line )

  b = strfind( line, ']' );
  lights = line(2:b-1) == '#';

  a = strfind( line, '{' );
  joltage = str2num( line(a+1:length(line)-1) ); %#ok<ST2NM>

  strwiring = line(b+1:a-1);
  o = strfind( strwiring, '(' );
  c = strfind( strwiring, ')' );
  w = arrayfun( @(o,c) str2num( strwiring(o+1:c-1) ) + 1, o, c, 'UniformOutput', false ); %#ok<ST2NM>
  i = 1:length( lights );
  wiring = cell2mat( cellfun( @(w) ismember(i,w)', w, 'UniformOutput', false ) )';

  M(end+1) = struct( ...
    'lights', lights, ...
    'wiring', wiring, ...
    'joltage', joltage ); %#ok<AGROW> 

  line = fgetl( fid );

end

fclose( fid );

end