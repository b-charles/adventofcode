
M = char( readlines( 'input.txt', 'EmptyLineRule', 'skip' ) ) - '0';

N = size(M);
I = M < [ Inf(1,N(2)) ; M(1:end-1,:) ] ...
    & M < [ M(2:end,:) ; Inf(1,N(2)) ] ...
    & M < [ Inf(N(1),1) M(:,1:end-1) ] ...
    & M < [ M(:,2:end) Inf(N(1),1) ];

sum( M(I) + 1 )

%%

H = zeros( 1, N(2) );
V = zeros( N(1), 1 );

K = ( M ~= 9 );

I = reshape( 1:prod(N), N ) .* K;
for i = 1:(max(N)/2+1)
  I = max( cat( 3, I, [ H ; I(1:end-1,:) ], [ I(2:end,:) ; H ], [ V I(:,1:end-1) ], [ I(:,2:end) V ] ), [], 3 ) .* K;
end

[ ~, ~, W ] = unique( I( I ~= 0 ) );
Z = sort( accumarray( W, 1 ), 'descend' );
prod( Z(1:3) )
