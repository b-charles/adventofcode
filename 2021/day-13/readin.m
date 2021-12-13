function [ M, F ] = readin( file )

lines = readlines( file );

M = [];

l = 1;
while strlength( lines(l) ) ~= 0
  match = str2double( regexp( lines(l), '\d+', 'match' ) ) + 1;
  M( match(2), match(1) ) = true; %#ok<AGROW> 
  l = l + 1;
end
M = M ~= 0;

F = struct( ...
  'axe', {}, ...
  'val', {} );

l = l + 1;
while strlength( lines(l) ) ~= 0
  tok = regexp( lines(l), 'fold along (\w)=(\d+)', 'tokens' );
  F(end+1) = struct( ...
    'axe', char( tok{1}(1) ), ...
    'val', str2double( tok{1}(2) ) + 1 ); %#ok<AGROW> 
  M( match(2), match(1) ) = true; %#ok<AGROW> 
  l = l + 1;
end

end