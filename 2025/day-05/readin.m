function [ R, I ] = readin( filename )

fid = fopen( filename );

R = zeros( 0, 2 );
I = zeros( 0, 1 );

line = fgetl( fid );
while ~isempty( line )
  R = [ R ; cellfun( @str2double, split( line, '-' ) )' ]; %#ok<AGROW>
  line = fgetl( fid );
end

line = fgetl( fid );
while ischar( line )
  I = [ I ; str2double( line ) ]; %#ok<AGROW>
  line = fgetl( fid );
end

fclose( fid );

end