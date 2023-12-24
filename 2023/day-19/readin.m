function [ N, E, V, J, P ] = readin( filename )

fid = fopen( filename );

N = { 'A', 'R' };
E = [ 1 ; 1 ];
V = [ 0 ; 0 ];
J = { ...
  'A' 'A'
  'R' 'R' };

EV('xmas') = 1:4;

l = fgetl( fid );
while ~isempty( l )

  L = regexp( l, '(?<n>\w+){(?<r>.*),(?<f>\w+)}', 'names' );
  R = regexp( L.r, '(?<c>[xmas])(?<op>[<>])(?<val>\d+):(?<jump>\w+)', 'names' );
  n = length(R);

  N{end+1} = L.n; %#ok<*AGROW>
  s = length( N );
  N(end+1:end+n-1) = repmat( {''}, 1, n-1 );

  for i = 1:n

    E(end+1) = EV( R(i).c );

    v = str2double( R(i).val );
    t = R(i).jump;
    f = s+i;
    if i == n
      f = L.f;
    end

    if R(i).op == '<'
      V(end+1) = v;
      J{end+1, 1} = f;
      J{end, 2} = t;
    else % R(i).op == '>'
      V(end+1) = v+1;
      J{end+1, 1} = t;
      J{end, 2} = f;
    end

  end

  l = fgetl( fid );

end

  function i = resolveName( i )
    if ischar( i )
      i = find( strcmp( N, i ), 1 );
    end
  end

J = cellfun( @resolveName, J );

P = zeros( 0, 4 );
l = fgetl( fid );
while l ~= -1

  L = regexp( l, '(\d+)', 'tokens' );
  P(end+1,:) = str2double( [ L{:} ] );
  l = fgetl( fid );

end

fclose( fid );

end