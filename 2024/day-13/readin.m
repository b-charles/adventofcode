function [ Ax, Ay, Bx, By, Px, Py ] = readin( filename )

Ax = zeros( 0, 1 ); Ay = zeros( 0, 1 );
Bx = zeros( 0, 1 ); By = zeros( 0, 1 );
Px = zeros( 0, 6 ); Py = zeros( 0, 6 );

fid = fopen( filename );

line = fgetl( fid );
while ischar( line )

  T = regexp( line, 'Button A: X\+(\d+), Y\+(\d+)', 'tokens' );
  Ax = [ Ax str2double( T{1}{1} ) ]; %#ok<AGROW>
  Ay = [ Ay str2double( T{1}{2} ) ]; %#ok<AGROW>

  line = fgetl( fid );
  T = regexp( line, 'Button B: X\+(\d+), Y\+(\d+)', 'tokens' );
  Bx = [ Bx str2double( T{1}{1} ) ]; %#ok<AGROW>
  By = [ By str2double( T{1}{2} ) ]; %#ok<AGROW>

  line = fgetl( fid );
  T = regexp( line, 'Prize: X=(\d+), Y=(\d+)', 'tokens' );
  Px = [ Px str2double( T{1}{1} ) ]; %#ok<AGROW>
  Py = [ Py str2double( T{1}{2} ) ]; %#ok<AGROW>

  line = fgetl( fid );
  if isempty( line )
    line = fgetl( fid );
  end

end

fclose( fid );
