function [ N, R, T ] = readin( filename )

fid = fopen( filename );

N = { 'AA' };
R = 0;
T = false;

  function idx = findByName( name )
    idx = find( strcmp( N, name ), 1 );
    if isempty( idx )
      N = [ N {name} ]; %#ok<*AGROW>
      R = [ R 0 ];
      T = [ T false(length(N)-1,1) ; false(1, length(N)) ];
      idx = length(N);
    end
  end

line = fgetl( fid );
while ischar( line )

  M = regexp( line, 'Valve (?<name>..) has flow rate=(?<rate>\d+); tunnel(s?) lead(s?) to valve(s?) (?<tunnels>..(, ..)*)', 'names' );

  i = findByName( M.name );
  R(i) = str2double( M.rate );
  T( cellfun( @findByName, split(M.tunnels, ', ') ) ,i ) = true;

  line = fgetl( fid );

end

fclose( fid );

end