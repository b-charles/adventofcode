
% I = readin( sprintf( 'F10\nN3\nF7\nR90\nF11' ) );
I = readin( 'data.in' );

X = [1;0;0]; Y = [0;1;0]; T=[0;0;1];
A = struct( ...
  'N', @(S,v) S + v*Y, ...
  'S', @(S,v) S - v*Y, ...
  'E', @(S,v) S + v*X, ...
  'W', @(S,v) S - v*X, ...
  'L', @(S,v) S + v*T, ...
  'R', @(S,v) S - v*T, ...
  'F', @(S,v) S + v*[cosd(S(3));sind(S(3));0] );

disp( engine( I, A, zeros( 3, 1 ) ) );

%%

T = @(x,y) eye(5) + sparse( [3;4], [5;5], [x;y], 5, 5 );
R = @(a) [1 0 0 0 0; 0 1 0 0 0; 0 0 cosd(a) -sind(a) 0; 0 0 sind(a) cosd(a) 0; 0 0 0 0 1];
A = struct( ...
  'N', @(S,v) T(0,v) * S, ...
  'S', @(S,v) T(0,-v) * S, ...
  'E', @(S,v) T(v,0) * S, ...
  'W', @(S,v) T(-v,0) * S, ...
  'L', @(S,v) R(v) * S, ...
  'R', @(S,v) R(-v) * S, ...
  'F', @(S,v) ( eye(5) + sparse( [1;2], [3;4], [v;v], 5, 5 ) ) * S );

disp( engine( I, A, [ 0 0 10 1 1 ]' ) );

%%

function r = engine( I, A, S )
  for i = 1:length( I )
    S = A.( I(i).ins )( S, I(i).val );
  end
  r = sum( abs( S(1:2) ) );
end
