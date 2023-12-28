
% G = char( readlines( 'input.txt', 'EmptyLineRule', 'skip' ) );
G = char( readlines( 'test1.txt', 'EmptyLineRule', 'skip' ) );

[ s1, s2 ] = size( G );
S = find( G == 'S' );
R = G == '#';

P = false( s1, s2 );
P(S) = true;

for k = 1:64
  P = conv2( P, [ 0 1 0 ; 1 0 1 ; 0 1 0 ], 'same' ) ~= 0 & ~R;
end

sum( P(:) ) % 3671

%%

P = false( s1, s2 );
P(S) = true;

for k = 1:10
  E = conv2( P, [ 0 1 0 ; 1 0 1 ; 0 1 0 ] ) ~= 0;
  P = ( E(2:end-1,2:end-1) ...
    | [ false(s1,s2-1) E(2:end-1,1) ] ...
    | [ E(2:end-1,end) false(s1,s2-1) ] ...
    | [ false(s1-1,s2) ; E(1,2:end-1) ] ...
    | [ E(end,2:end-1) ; false(s1-1,s2) ] ) & ~R;
end

sum( P(:) )

%     In exactly 6 steps, he can still reach 16 garden plots.
%     In exactly 10 steps, he can reach any of 50 garden plots.
%     In exactly 50 steps, he can reach 1594 garden plots.
%     In exactly 100 steps, he can reach 6536 garden plots.
%     In exactly 500 steps, he can reach 167004 garden plots.
%     In exactly 1000 steps, he can reach 668697 garden plots.
%     In exactly 5000 steps, he can reach 16733044 garden plots.
