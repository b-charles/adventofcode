function [ I, A, Ri, Ra ] = readin( file )
  
  I = struct();
  A = struct();
  
  Ri = false(0,0);
  Ra = false(0,0);
  
  r = 0;
  
  function [i, S, M] = getIndex( name, S, M )
    if ~isfield( S, name )
      i = size( M, 2 ) + 1;
      M(:,i) = 0;
      S.(name) = i;
    else
      i = S.(name);
    end
  end
  
  function i = getIngredient( name )
    [i, I, Ri] = getIndex( name, I, Ri );
  end
  
  function i = getAllergen( name )
    [i, A, Ra] = getIndex( name, A, Ra );
  end
  
  fid = fopen( file );
  
  l = fgetl( fid );
  while ischar( l )
    
    r = r + 1;
    
    T = regexp( l, '(.*) \(contains (.*)\)', 'tokens' );
    
    li = regexp( T{1}{1}, '(\w+)', 'tokens' );
    for k = 1:length( li )
      Ri(r, getIngredient( li{k}{1} )) = true;
    end
    
    la = regexp( T{1}{2}, '(\w+)', 'tokens' );
    for k = 1:length( la )
      Ra(r, getAllergen( la{k}{1} )) = true;
    end
    
    l = fgetl( fid );
    
  end
  
  fclose( fid );
  
end