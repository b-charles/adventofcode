function D = readin( file )

fid = fopen( file );

current_mask = '';
D = struct( ...
  'addr', {}, ...
  'val', {}, ...
  'mask', {} );

l = fgetl( fid );
while ischar( l )
  
  T = regexp( l, 'mask = (\w+)', 'tokens' );
  if ~isempty( T )
    current_mask = T{1}{1};
    l = fgetl( fid );
    continue
  end
  
  T = regexp( l, 'mem\[(\d+)\] = (\d+)', 'tokens' );
  D(end+1) = struct( ...
    'addr', str2double( T{1}{1} ), ...
    'val', str2double( T{1}{2} ), ...
    'mask', current_mask );
  
  l = fgetl( fid );

end

end