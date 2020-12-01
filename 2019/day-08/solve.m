
clear all
clc

fid = fopen( 'data.in' );
I = fgetl( fid ) - '0';
fclose( fid );

P = permute( reshape( I, 25, 6, [] ), [ 2 1 3 ] );

Z = sum( P == 0, [ 1 2 ] );
[ ~, i ] = min( Z(:) );

sum( P(:,:,i) == 1, 'all' ) * sum( P(:,:,i) == 2, 'all' )

%%

F = 2 * ones( 6, 25 );
for l = 1:size( P, 3 )

  L = P( :, :, l );

  ind = F == 2;
  F( ind ) = L( ind );

end

imagesc( F )

