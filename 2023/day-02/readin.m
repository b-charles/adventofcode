function S = readin( filename )

S = {};

fid = fopen( filename );

line = fgetl( fid );
while ischar( line )
  t = split(line, ': ');
  s = split(t{2}, '; ');

  m = [ ...
    cellfun( @(s)str2double(regexp(s, '\d+(?= red)', 'match', 'once')), s) ...
    cellfun( @(s)str2double(regexp(s, '\d+(?= green)', 'match', 'once')), s) ...
    cellfun( @(s)str2double(regexp(s, '\d+(?= blue)', 'match', 'once')), s) ];

  m(isnan(m)) = 0;

  S{end+1} = m; %#ok<AGROW> 

  line = fgetl( fid );
end

fclose( fid );