
L = cellfun( @str2double, regexp( fileread( 'input.txt' ), '-?\d*', 'match' ) );

L(3)*(L(3)+1)/2 %#ok<NOPTS>

%%

SL = @(l) ceil( ( sqrt( 1 + 8*abs(l) ) - 1 )/2 );
[ Vx, Vy ] = meshgrid( SL(L(1)):L(2), L(3):-L(3) );

tmax = 2*abs(L(3));

s = numel( Vx ) ;

Vx = repmat( Vx(:), 1, tmax ) - repmat( 0:(tmax-1), s, 1 );
Vx( Vx < 0 ) = 0;
Px = cumsum( Vx, 2 );

Vy = repmat( Vy(:), 1, tmax ) - repmat( 0:(tmax-1), s, 1 );
Py = cumsum( Vy, 2 );

sum( any( L(1) <= Px & Px <= L(2) & L(3) <= Py & Py <= L(4), 2 ) )
