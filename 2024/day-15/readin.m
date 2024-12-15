function [ M, D ] = readin( filename )

fid = fopen( filename );

M = [];

line = fgetl( fid );
while ~isempty( line )
  M = [ M ; -1*(line == '#') + -2*(line == '@') + 3*(line == 'O') ]; %#ok<AGROW>
  line = fgetl( fid );
end
O = find( M == 3 );
M( O ) = O;

D = [];
line = fgetl( fid );
while ischar( line )
  D = [ D ( (line == 'v') + 2*(line == '>') + 3*(line == '^') + 4*(line == '<') ) ]; %#ok<AGROW>
  line = fgetl( fid );
end

fclose( fid );
