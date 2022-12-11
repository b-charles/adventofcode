function [I, M] = readin( filename )

fid = fopen( filename );

I = {};
M = struct( ...
  'op', cell(1,0), ...
  'div', cell(1,0), ...
  'itrue', cell(1,0), ...
  'ifalse', cell(1,0) );

line = fgetl( fid );
while ischar( line )

  % skip monkey number

  line = fgetl( fid ); % items
  R = textscan( line(19:end), '%f', 'Delimiter', ',' );
  I{end+1} = [ R{:} ]'; %#ok<*AGROW>

  line = fgetl( fid ); % operation
  if line(24) == '*'
    if strcmp( line(26:end), 'old' )
      op = @(v)v.*v;
    else
      n = str2double( line(26:end) );
      op = @(v)v*n;
    end
  else % '+'
    n = str2double( line(26:end) );
    op = @(v)v+n;
  end

  line = fgetl( fid ); % test
  div = str2double( line(22:end) );

  line = fgetl( fid ); % true
  itrue = str2double( line(30:end) ) + 1;

  line = fgetl( fid ); % false
  ifalse = str2double( line(31:end) ) + 1;

  M(end+1) = struct( ...
    'op', op, ...
    'div', div, ...
    'itrue', itrue, ...
    'ifalse', ifalse );

  fgetl( fid ); % empty
  line = fgetl( fid ); % next monkey

end

fclose( fid );

end