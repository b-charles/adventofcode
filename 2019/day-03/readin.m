function P = readin( in )

  if( isfile( in ) )
    fid = fopen( in );
    A = fscanf( fid, '%c%d,', [2, inf] );
    fclose( fid );
  else
    A = sscanf( in, '%c%d,', [2, inf] );
  end

  P = [0;0];
  for( i = 1:size(A,2) )
    if( A(1,i) == 'R' )
      U = [0;1];
    elseif( A(1,i) == 'L' )
      U = [0;-1];
    elseif( A(1,i) == 'U' )
      U = [1;0];
    elseif( A(1,i) == 'D' )
      U = [-1;0];
    end
    P = [ P ( P(:,end) + U * (1:A(2,i)) ) ];
  end

  P = P(:, 2:end);

