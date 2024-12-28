
% 7  8  9
% 4  5  6
% 1  2  3
%   10 11

%   1 5
% 2 4 3

L = char( readlines( 'input.txt', 'EmptyLineRule', 'skip' ) );
P = [ 10 1 2 3 4 5 6 7 8 9 0 0 0 0 0 0 0 11 ];
L = P( L - '/' );

D = [ 1 2 3 4 5 6 7 8 9 0 ];

l = 0;
for C = L'
  l = l + D(C(1:end-1))*[100 10 1]' * numCmdLength( C', 2 );
end
l

% 278748

%%

l = 0;
for C = L'
  l = l + D(C(1:end-1))*[100 10 1]' * numCmdLength( C', 25 );
end
uint64( l )




