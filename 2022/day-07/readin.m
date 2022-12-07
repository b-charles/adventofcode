function sizes = readin( file )

fid = fopen( file );

sizes = 0;
path = 1;

line = fgetl( fid );
while ischar( line )

  if strcmp( line, '$ cd /' )
    path = 1;
  elseif strcmp( line, '$ cd ..' )
    path = path( 1:end-1 );
  elseif startsWith( line, '$ cd ' )
    sizes = [ sizes 0 ]; %#ok<AGROW> 
    path = [ path length(sizes) ]; %#ok<AGROW>
  elseif strcmp( line, '$ ls' )
    %
  elseif startsWith( line, 'dir ' )
    %
  else
    m = regexp( line, '(?<size>\d+) .+', 'names' );
    sizes(path) = sizes(path) + str2double(m.size); %#ok<AGROW> 
  end

  line = fgetl( fid );

end

fclose( fid );