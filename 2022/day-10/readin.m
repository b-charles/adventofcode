function X = readin( filename )

fid = fopen( filename );

X = 1;

line = fgetl( fid );
while ischar( line )

  disp( line );
  if strcmp( line, 'noop' )
    X =  [ X 0 ]; %#ok<*AGROW> 
  else
    X = [ X 0 sscanf( line, 'addx %d') ];
  end

  line = fgetl( fid );

end

fclose( fid );

X = cumsum( X );
