function [ D, K, M ] = readin( filename )

L = readlines( filename, 'EmptyLineRule', 'skip' );

D = ( char(L(1)) == 'R' ) + 1;

K = char( zeros(0, 3) );
M = zeros(0, 2);

  function k = index( key )
    k = find( ismember( K, key, 'rows' ) );
    if isempty( k )
      k = size( K, 1 ) + 1;
      K( k, : ) = key;
    end
  end

for i = 2:length(L)
  N = regexp( char( L(i) ), "(?<key>\w\w\w) = \((?<left>\w\w\w), (?<right>\w\w\w)\)", "names" );
  M( index(N.key), : ) = [ index(N.left) , index(N.right) ];
end

end