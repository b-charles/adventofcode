function M = readin( filename )

L = readlines( filename );

M = {};
T = [];
for l = 1:length( L )

  if( L(l) == "" )
    M{end+1} = T;
    T = [];
  else
    T( end+1, : ) = char( L(l) ) == '#';
  end

end

if ~isempty( T )
  M{end+1} = T;
end
