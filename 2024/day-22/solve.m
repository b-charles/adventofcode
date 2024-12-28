
S = readmatrix( 'input.txt' );

S = [ S zeros( size(S,1), 2000 ) ];

for k = 1:2000
  T = mod( bitxor( S(:,k)*64, S(:,k) ), 16777216 );
  T = mod( bitxor( floor( T / 32 ), T ), 16777216 );
  S(:,k+1) = mod( bitxor( T*2048, T ), 16777216 );
end

uint64( sum( S(:,end) ) )

%%

P = mod( S, 10 );
D = diff( P, 1, 2 );

U = [];
for a = 1:size(D,2)-3
  U = unique( [ U ; D( :, a:a+3 ) ], 'rows' );
end

close all
h = waitbar( 0, 'process...' );

PP = [ P zeros(size(P,1),1) ];
T = true( size(P,1), 1 );
I = ( 1:size(P,1) )';

Z = zeros( 1, size(U,1) );
for u = 1:size(U,1)

  if mod(u,20) == 0
    waitbar( u/size(U,1), h, sprintf( '%d / %d', u, size(U,1) ) );
  end

  W = [ D(:,1:end-3) == U(u,1) & ...
    D(:,2:end-2) == U(u,2) & ...
    D(:,3:end-1) == U(u,3) & ...
    D(:,4:end) == U(u,4) T ];
  [ ~, V ] = max( W, [], 2 );

  Z(u) = sum( PP( sub2ind( size(PP), I, V+4 ) ) );

end

close all

max( Z )
