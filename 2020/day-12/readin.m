function I = readin( str )

  if isfile( str )
    str = fileread( str );
  end
  
  S = split( str );
  n = length( S );
  
  I = repmat( struct ( ...
    'ins', '', ...
    'val', 0 ), 1, n );
  
  for i = 1:n
    T = regexp( S{i}, '(\w)(\d+)', 'tokens' );
    I(i).ins = T{1}{1};
    I(i).val = str2double( T{1}{2} );
  end

end