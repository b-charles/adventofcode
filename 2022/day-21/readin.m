function [ N, M ] = readin( filename )

N = cell(1,0);
M = struct( ...
  'value', {}, ...
  'op', {}, ...
  'i1', {}, ...
  'i2', {} );

  function i = monkey( name )
    i = find( strcmp(N,name), 1 );
    if isempty( i )
      N{end+1} = name;
      M(end+1) = struct( ...
        'value', [], ...
        'op', @(a,b)[], ...
        'i1', 1, ...
        'i2', 1 );
      i = length(N);
    end
  end

  function C = polyplus( A, B )
    lA = length(A); lB = length(B);
    C = [ zeros(lB-lA) A ] + [ zeros(lA-lB) B ];
  end

fid = fopen( filename );

line = fgetl( fid );
while ischar( line )

  R = regexp( line, '(?<name>.+): (?<value>\d+)|(?<name>.+): (?<i1>.+) (?<op>.) (?<i2>.+)', 'names' );

  i = monkey( R.name );
  if ~isempty( R.value )
    M(i) = struct( ...
      'value', str2double(R.value), ...
      'op', @(a,b)[], ...
      'i1', 1, ...
      'i2', 1 );
  else
    if strcmp( R.op, '+' )
      op = @polyplus;
    elseif strcmp( R.op, '-' )
      op = @(a,b)polyplus(a, -b);
    elseif strcmp( R.op, '*' )
      op = @conv;
    else % '/'
      op = @deconv;
    end
    M(i) = struct( ...
      'value', [], ...
      'op', op, ...
      'i1', monkey( R.i1 ), ...
      'i2', monkey( R.i2 ) );
  end

  line = fgetl( fid );

end

fclose( fid );

end