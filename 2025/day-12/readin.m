function [ S, P ] = readin( filename )

fid = fopen( filename );

S = cell( 1, 6 );

for s = 1:6
  fgetl( fid );
  S{s} = char( [ fgetl( fid ) ; fgetl( fid ) ; fgetl( fid ) ] ) == '#';
  fgetl( fid );
end

P = zeros( 0, 8 );

line = fgetl( fid );
while ischar( line )
  P( end+1, : ) = str2double( extract( line, digitsPattern ) )'; %#ok<AGROW> 
  line = fgetl( fid );
end

fclose( fid );
