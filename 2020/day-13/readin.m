function [offset, B, I] = readin( in )

  if isfile( in )
    in = fileread( in );
  end
  
  C = split( in );
  
  offset = str2double( C{1} );
  
  schedule = cellfun( @str2double, regexp( C{2}, '(x|\d+)', 'tokens' ) );
  I = find( ~isnan( schedule ) );
  B = schedule( I );

end