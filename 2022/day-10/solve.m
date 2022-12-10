
X = readin( 'input.txt' );

I = [20, 60, 100, 140, 180, 220 ];
sum( I.*X(I) )

%%

D = arrayfun( @(i)any( mod(i-1,40) == X(i)+[-1 0 1] ), 1:length(X) );

imagesc( reshape( ~D(1:240), 40, [] )' );
colormap gray
axis equal
