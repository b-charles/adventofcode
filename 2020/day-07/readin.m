function [ s, B ] = readin( file )

  s = struct();
  B = zeros( 0, 0 );
  
  function i = getIdx( n )
    
    n = replace( n, ' ', '_' );
    
    if isfield( s, n )
      i = s.(n);
      return
    end
    
    i = size( B, 1 ) + 1;
    s.(n) = i;
    B = [ B zeros( i-1, 1 ); zeros( 1, i ) ];
    
  end

  fid = fopen( file );
  
  t = fgetl( fid );
  while ischar( t )
    
    [ n, e ] = regexp( t, '(?<bag>\w+ \w+) bags contain ', 'names', 'end' );
    
    i = getIdx( n.bag );
    
    T = regexp( t(e+1:end), '(\d+) (\w+ \w+) bag', 'tokens' );
    for j = 1:length( T )
      B( i, getIdx( T{j}{2} ) )= str2double( T{j}{1} );
    end
    
    t = fgetl( fid );
    
  end
  
  fclose( fid );

end