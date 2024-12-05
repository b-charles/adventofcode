function [C, L] = readin( filename )

fid = fopen( filename );

C = zeros( 0, 2 );

line = fgetl( fid );
while ~isempty( line )
  C(end+1,:) = cellfun( @str2double, split( line, '|' ) )'; %#ok<AGROW>
  line = fgetl( fid );
end

L = cell( 0, 1 );

line = fgetl( fid );
while ischar( line )
  L{end+1} = str2num( line ); %#ok<ST2NM,AGROW>
  line = fgetl( fid );
end

fclose( fid );