
V( '23456789TJQKA' ) = [ 2 3 4 5 6 7 8 9 10 11 12 13 14 ];
L = char( readlines( 'input.txt', 'EmptyLineRule', 'skip' ) );
H = [ V( L(:,1:5) ) str2num( L(:,7:end) ) ]; %#ok<ST2NM>
n = length(L);

M = cell2mat( arrayfun( @(i) accumarray( H(i,1:5)', 1, [14 1] ), 1:n, 'UniformOutput', false ) )';

T = cell2mat( arrayfun( @(i) accumarray(M(i,:)'+1, 1, [6 1]), 1:n, 'UniformOutput', false ) )';

[ ~, I ] = ismember( T, [ ...
  9 5 0 0 0 0
  10 3 1 0 0 0
  11 1 2 0 0 0
  11 2 0 1 0 0
  12 0 1 1 0 0
  12 1 0 0 1 0
  13 0 0 0 0 1 ], 'rows' );
S = sortrows( [ I H ] );
(1:n) * S(:,7) %#ok<NOPTS>

%%

R = H;
R( [ R(:,1:5) zeros(n,1) ] == 11 ) = 1;

[ ~, I ] = ismember( [ T M(:,11) ], [ ...
  9 5 0 0 0 0 0 % 0J
  9 5 0 0 0 0 1 % 1J: 1Pair
  10 3 1 0 0 0 0 % 1Pair 0J
  10 3 1 0 0 0 1 % 1Pair 1J: Three
  10 3 1 0 0 0 2 % 1Pair 2J: Three
  11 1 2 0 0 0 0 % 2Pair 0J
  11 1 2 0 0 0 1 % 2Pair 1J: Full
  11 1 2 0 0 0 2 % 2Pair 2J: Four
  11 2 0 1 0 0 0 % Three 0J
  11 2 0 1 0 0 1 % Three 1J: Four
  11 2 0 1 0 0 2 % Three 2J: Five
  11 2 0 1 0 0 3 % Three 3J: Four
  12 0 1 1 0 0 0 % Full 0J
  12 0 1 1 0 0 2 % Full 2J: Five
  12 0 1 1 0 0 3 % Full 3J: Five
  12 1 0 0 1 0 0 % Four 0J
  12 1 0 0 1 0 1 % Four 1J: Five
  12 1 0 0 1 0 4 % Four 4J: Five
  13 0 0 0 0 1 0 % Five
  13 0 0 0 0 1 5 % Five 5J
  ], 'rows' );

% 0:- 1:1Pair 2:2Pair 3:Three 4:Full 5:Four 6:Five
A = [ 0 1 1 3 3 2 4 5 3 5 6 5 4 6 6 5 6 6 6 6 ]';

S = sortrows( [ A(I) R ] );
(1:n) * S(:,7) %#ok<NOPTS>
