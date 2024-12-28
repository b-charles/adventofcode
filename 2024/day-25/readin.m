function [ L, K ] = readin( filename )

L = zeros( 0, 5 );
K = zeros( 0, 5 );

fid = fopen( filename );

line = fgetl( fid );
while ischar( line )

  S = '';
  while ischar( line ) && ~isempty( line )
    S = [ S ; line ]; %#ok<AGROW>
    line = fgetl( fid );
  end

  H = sum( S(2:end-1,:) == '#', 1 );
  if S(1,1) == '#'
    L = [ L ; H ]; %#ok<AGROW>
  else
    K = [ K ; H ]; %#ok<AGROW>
  end

  line = fgetl( fid );

end

fclose( fid );
