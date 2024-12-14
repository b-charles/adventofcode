
D = cell2mat( cellfun( @(T) str2double(T{1}), regexp( readlines( 'input.txt', 'EmptyLineRule', 'skip' ), 'p=(-?\d+),(-?\d+) v=(-?\d+),(-?\d+)', 'tokens' ) , 'UniformOutput', false) );

W = 101; H = 103;
P = [ mod( D(:,1)+100*D(:,3), W ), mod( D(:,2)+100*D(:,4), H ) ];

W2 = floor( W / 2 ); H2 = floor( H / 2 );
sum( P(:,1) < W2 & P(:,2) < H2 ) ...
  * sum( P(:,1) < W2 & P(:,2) > H2 ) ...
  * sum( P(:,1) > W2 & P(:,2) < H2 ) ...
  * sum( P(:,1) > W2 & P(:,2) > H2 )

%%

k = 0;
P = D( :, [ 1 2 ] );
while size( unique( P, 'rows' ), 1 ) ~= size( D, 1 )
  k = k + 1;
  P = [ mod( P(:,1)+D(:,3), W ), mod( P(:,2)+D(:,4), H ) ];
end
k

M = false( H, W );
M( sub2ind( [ H, W ], P(:,2)+1, P(:,1)+1 ) ) = true;
h = axes();
axis( h, 'equal' );
imagesc( h, M );
colormap( h, 'gray' );
