
C = readmatrix( 'input.txt' );

S = max( C, [], 1 ) + 2;
D = false( S );
D( sub2ind( S, C(:,1)+1, C(:,2)+1, C(:,3)+1 ) ) = true;

P1 = @(M) cat( 1, false( 1, S(2), S(3) ), M(1:end-1,:,:) );
Q1 = @(M) cat( 1, M(2:end,:,:), false( 1, S(2), S(3) ) );
P2 = @(M) cat( 2, false( S(1), 1, S(3) ), M(:,1:end-1,:) );
Q2 = @(M) cat( 2, M(:,2:end,:), false( S(1), 1, S(3) ) );
P3 = @(M) cat( 3, false( S(1), S(2), 1 ), M(:,:,1:end-1) );
Q3 = @(M) cat( 3, M(:,:,2:end), false( S(1), S(2), 1 ) );

W = ~D;
sum( D & P1(W), 'all' ) + sum( D & Q1(W), 'all' ) + ...
  sum( D & P2(W), 'all' ) + sum( D & Q2(W), 'all' ) + ...
  sum( D & P3(W), 'all' ) + sum( D & Q3(W), 'all' )

%%

W = false( S );
W(1,:,:) = true; W(end,:,:) = true;
W(:,1,:) = true; W(:,end,:) = true;
W(:,:,1) = true; W(:,:,end) = true;
for k = 1:max(S)/2
  W = ( W | P1(W) | Q1(W) | P2(W) | Q2(W) | P3(W) | Q3(W) ) & ~D;
end

E = ~W;
sum( E & P1(W), 'all' ) + sum( E & Q1(W), 'all' ) + ...
  sum( E & P2(W), 'all' ) + sum( E & Q2(W), 'all' ) + ...
  sum( E & P3(W), 'all' ) + sum( E & Q3(W), 'all' )
