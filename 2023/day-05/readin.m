function [S, CM] = readin(filename)

L = readlines( filename );

l = char(L(1));
S = str2num( l(8:end) ); %#ok<*ST2NM> 

seps = find( L == "" );

CM = cell( 1, length(seps) - 1 );
for i = 2:length(seps)
  CM{i-1} = str2num( char( L( (seps(i-1)+2) : (seps(i)-1) ) ) );
end
