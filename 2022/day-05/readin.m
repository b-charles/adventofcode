function [ S, C ] = readin( file )

fid = fopen( file );

line = fgetl( fid );
S = cell( 1, ( length(line)+1 )/4 );

while ~startsWith( line, ' 1 ' )

  for s = regexp( line, '[A-Z]' )
    i = (s-2)/4 + 1;
    S{i} = [ line(s) S{i} ];
  end

  line = fgetl( fid );

end

fgetl( fid ); % empty line

C = zeros( 0, 3 );

line = fgetl( fid );
while ischar( line )

    g = regexp( line, 'move (?<nb>\d+) from (?<from>\d+) to (?<to>\d+)', 'names' );
    C(end+1,:) = str2num([ g.from ' ' g.to ' ' g.nb ]); %#ok<ST2NM,AGROW> 

    line = fgetl(fid);

end

fclose( fid );