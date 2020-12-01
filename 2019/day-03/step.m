
% P1 = readin( 'R75,D30,R83,U83,L12,D49,R71,U7,L72' );
% P2 = readin( 'U62,R66,U55,R34,D71,R55,D58,R83' );

% P1 = readin( 'R98,U47,R26,D63,R33,U87,L62,D20,R33,U53,R51' );
% P2 = readin( 'U98,R91,D20,R16,D67,R40,U7,R15,U6,R7' );

P1 = readin( 'first.in' );
P2 = readin( 'second.in' );

[i1, loc2] = ismember( P1', P2', 'rows' );
P = P1(:, i1 );

%% step 1
min( sum( abs( P ), 1 ) )

%% step2
min( find( i1 ) + loc2( find( loc2 ~= 0 ) ) )


